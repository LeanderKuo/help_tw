// DRIP shared models (TypeScript) aligned with specs_arch.md & specs_feature.md
export type LocaleKey = 'zh-TW' | 'en-US';
export type MissionStatus = 'open' | 'in_progress' | 'done' | 'canceled';
export type ShuttleStatus = 'open' | 'in_progress' | 'done' | 'canceled';
export type ShuttleCostType = 'free' | 'share_gas';
export type ResourceStatus = 'active' | 'shortage' | 'closed';

export type MissionType = 'rescue' | 'medical' | 'transport' | 'clearing' | 'other';
export type ShuttlePurpose = 'evacuation' | 'medical_transport' | 'supply_transport' | 'volunteer_shuttle' | 'other';
export type ResourceCategory = 'food' | 'water' | 'medical' | 'shelter' | 'power' | 'other';

export interface LocalizedText {
  'zh-TW': string;
  'en-US': string;
}

export interface GeoLocation {
  lat: number;
  lng: number;
  address: string;
  geohash?: string | null;
}

export interface MissionRequirements {
  materials: string[];
  manpower_needed: number;
  manpower_current: number;
}

export interface Mission {
  id: string;
  title: LocalizedText;
  description?: LocalizedText | null;
  types: MissionType[];
  status: MissionStatus;
  priority: boolean;
  requirements: MissionRequirements;
  location: GeoLocation;
  contact_name?: string | null;
  contact_phone_masked?: string | null;
  creator_id: string;
  chat_room_id?: string | null;
  participant_count: number;
  created_at: string;
  updated_at: string;
}

export interface MissionParticipant {
  mission_id: string;
  user_id: string;
  is_visible: boolean;
  joined_at: string;
}

export interface MissionMessage {
  id: string;
  mission_id: string;
  author_id: string;
  content: string;
  created_at: string;
  expires_at: string;
}

export interface ShuttleVehicleInfo {
  type: 'bus' | 'van' | 'car' | 'truck' | 'other';
  plate?: string;
}

export interface ShuttleRoute {
  origin: GeoLocation;
  destination: GeoLocation;
  stops?: GeoLocation[];
}

export interface ShuttleSchedule {
  depart_at: string;
  arrive_at?: string | null;
}

export interface ShuttleCapacity {
  total: number;
  taken: number;
  remaining: number;
}

export interface Shuttle {
  id: string;
  title: LocalizedText;
  description?: LocalizedText | null;
  vehicle_info: ShuttleVehicleInfo;
  purposes: ShuttlePurpose[];
  route: ShuttleRoute;
  schedule: ShuttleSchedule;
  capacity: ShuttleCapacity;
  cost_type: ShuttleCostType;
  status: ShuttleStatus;
  priority: boolean;
  contact_name?: string | null;
  contact_phone_masked?: string | null;
  creator_id: string;
  chat_room_id?: string | null;
  participants_snapshot: string[];
  created_at: string;
  updated_at: string;
}

export interface ShuttleParticipant {
  shuttle_id: string;
  user_id: string;
  role: 'driver' | 'staff' | 'passenger';
  is_visible: boolean;
  joined_at: string;
}

export interface ShuttleMessage {
  id: string;
  shuttle_id: string;
  author_id: string;
  content: string;
  created_at: string;
  expires_at: string;
}

export interface ResourcePoint {
  id: string;
  title: LocalizedText;
  description?: LocalizedText | null;
  categories: ResourceCategory[];
  status: ResourceStatus;
  expiry: string;
  location: GeoLocation;
  address?: string | null;
  contact_masked_phone?: string | null;
  created_by: string;
  created_at: string;
  updated_at: string;
}

export interface ChatRoom {
  id: string;
  entity_type: 'mission' | 'shuttle';
  entity_id: string;
  expires_at: string;
  created_by?: string | null;
  created_at: string;
}

export interface NotificationEvent {
  id: number;
  entity_type: 'mission' | 'shuttle';
  entity_id: string;
  payload: {
    changed_fields: string[];
    status: MissionStatus | ShuttleStatus;
    updated_at: string;
  };
  created_at: string;
}
