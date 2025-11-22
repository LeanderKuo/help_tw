// Edge Function to process notification_events
// Consumes events from the notification_events table and sends notifications to affected users

import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

interface NotificationEvent {
  id: number
  entity_type: 'mission' | 'shuttle'
  entity_id: string
  payload: {
    changed_fields: string[]
    status: string
    updated_at: string
  }
  created_at: string
}

serve(async (req) => {
  // Handle CORS preflight requests
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    // Initialize Supabase client
    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '',
      {
        auth: {
          autoRefreshToken: false,
          persistSession: false
        }
      }
    )

    // Fetch unprocessed notification events (last 100)
    const { data: events, error: fetchError } = await supabaseClient
      .from('notification_events')
      .select('*')
      .order('created_at', { ascending: true })
      .limit(100)

    if (fetchError) {
      throw new Error(`Failed to fetch events: ${fetchError.message}`)
    }

    if (!events || events.length === 0) {
      return new Response(
        JSON.stringify({ message: 'No events to process', processed: 0 }),
        { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: 200 }
      )
    }

    const processedIds: number[] = []
    const notifications: any[] = []

    // Process each event
    for (const event of events as NotificationEvent[]) {
      try {
        // Fetch affected participants based on entity type
        let participants: any[] = []

        if (event.entity_type === 'mission') {
          const { data } = await supabaseClient
            .from('mission_participants')
            .select('user_id')
            .eq('mission_id', event.entity_id)
          participants = data || []
        } else if (event.entity_type === 'shuttle') {
          const { data } = await supabaseClient
            .from('shuttle_participants')
            .select('user_id')
            .eq('shuttle_id', event.entity_id)
          participants = data || []
        }

        // Create notification message
        const changedFields = event.payload.changed_fields.join(', ')
        const message = event.entity_type === 'mission'
          ? `任務已更新：${changedFields}`
          : `接駁已更新：${changedFields}`

        // Insert notifications for each participant
        for (const participant of participants) {
          notifications.push({
            user_id: participant.user_id,
            title: event.entity_type === 'mission' ? '任務更新' : '接駁更新',
            message: message,
            entity_type: event.entity_type,
            entity_id: event.entity_id,
            created_at: new Date().toISOString()
          })
        }

        processedIds.push(event.id)
      } catch (err) {
        console.error(`Error processing event ${event.id}:`, err)
      }
    }

    // Insert all notifications at once (if you have a notifications table)
    // For now, we'll just log them and delete the events
    console.log(`Generated ${notifications.length} notifications`)

    // Delete processed events
    if (processedIds.length > 0) {
      const { error: deleteError } = await supabaseClient
        .from('notification_events')
        .delete()
        .in('id', processedIds)

      if (deleteError) {
        throw new Error(`Failed to delete events: ${deleteError.message}`)
      }
    }

    return new Response(
      JSON.stringify({
        message: 'Events processed successfully',
        processed: processedIds.length,
        notifications_generated: notifications.length
      }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: 200 }
    )

  } catch (error) {
    return new Response(
      JSON.stringify({ error: error.message }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' }, status: 500 }
    )
  }
})
