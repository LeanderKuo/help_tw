# Chat API Migration Guide

## Breaking Changes

The chat system has been unified to use a single `chat_rooms` and `chat_messages` table instead of separate `mission_messages` and `shuttle_messages` tables.

---

## Old Schema (Deprecated)

```sql
-- Old tables (no longer exist)
mission_messages (id, mission_id, author_id, content, created_at)
shuttle_messages (id, shuttle_id, author_id, content, created_at)
```

## New Schema

```sql
-- New unified tables
chat_rooms (id, entity_id, entity_type, created_at)
chat_messages (id, chat_room_id, sender_id, content, image_url, created_at, expires_at)
```

---

## Model Changes

### ChatMessage Model

**Before:**
```dart
ChatMessage(
  id: '...',
  taskId: 'mission-123',      // ❌ Removed
  shuttleId: 'shuttle-456',   // ❌ Removed
  senderId: 'user-789',
  content: 'Hello',
  createdAt: DateTime.now(),
)
```

**After:**
```dart
ChatMessage(
  id: '...',
  chatRoomId: 'room-abc',     // ✅ New field
  senderId: 'user-789',
  content: 'Hello',
  imageUrl: null,             // ✅ New optional field
  createdAt: DateTime.now(),
  expiresAt: DateTime.now().add(Duration(days: 30)), // ✅ Auto-cleanup
)
```

---

## Repository API Changes

### ChatRepository

#### 1. Get Messages

**Before:**
```dart
// Separate methods for tasks and shuttles
final messages = await chatRepository.getTaskMessages(taskId);
final messages = await chatRepository.getShuttleMessages(shuttleId);
```

**After (Option 1 - Direct):**
```dart
// Get chat room first
final chatRoom = await chatRepository.getChatRoom(taskId, 'mission');
if (chatRoom != null) {
  final messages = await chatRepository.getMessages(chatRoom.id);
}
```

**After (Option 2 - Legacy Helper):**
```dart
// Use legacy helpers (internally calls getChatRoom)
final messages = await chatRepository.getTaskMessages(taskId);
final messages = await chatRepository.getShuttleMessages(shuttleId);
```

#### 2. Send Message

**Before:**
```dart
// Separate methods
await chatRepository.sendTaskMessage(ChatMessage(
  id: uuid.v4(),
  taskId: taskId,
  senderId: userId,
  content: 'Hello',
));

await chatRepository.sendShuttleMessage(ChatMessage(
  id: uuid.v4(),
  shuttleId: shuttleId,
  senderId: userId,
  content: 'Hello',
));
```

**After:**
```dart
// Unified method - need to get chat room first
final chatRoom = await chatRepository.getChatRoom(entityId, entityType);
if (chatRoom != null) {
  await chatRepository.sendMessage(ChatMessage(
    id: uuid.v4(),
    chatRoomId: chatRoom.id,
    senderId: userId,
    content: 'Hello',
  ));
}
```

#### 3. Subscribe to Messages

**Before:**
```dart
chatRepository.subscribeToTaskMessages(taskId).listen((messages) {
  // Handle messages
});

chatRepository.subscribeToShuttleMessages(shuttleId).listen((messages) {
  // Handle messages
});
```

**After (Option 1 - Direct):**
```dart
final chatRoom = await chatRepository.getChatRoom(entityId, entityType);
if (chatRoom != null) {
  chatRepository.subscribeToMessages(chatRoom.id).listen((messages) {
    // Handle messages
  });
}
```

**After (Option 2 - Legacy Helper):**
```dart
// Legacy helpers still work
chatRepository.subscribeToTaskMessages(taskId).listen((messages) {
  // Handle messages
});

chatRepository.subscribeToShuttleMessages(shuttleId).listen((messages) {
  // Handle messages
});
```

---

## UI Updates Required

### 1. Task Detail Screen

**File:** `lib/features/tasks/presentation/task_detail_screen.dart`

**Current Code (Lines 150-155):**
```dart
// ❌ This will cause errors
final messages = await chatRepository.subscribeToTaskMessages(task.id);
await chatRepository.sendTaskMessage(ChatMessage(
  taskId: task.id,  // ❌ taskId doesn't exist
  senderId: userId,
  content: text,
));
```

**Fixed Code:**
```dart
// Option 1: Use getChatRoom (recommended)
class _TaskDetailScreenState extends ConsumerStatefulWidget {
  ChatRoom? _chatRoom;

  @override
  void initState() {
    super.initState();
    _loadChatRoom();
  }

  Future<void> _loadChatRoom() async {
    final room = await ref.read(chatRepositoryProvider)
        .getChatRoom(widget.taskId, 'mission');
    setState(() => _chatRoom = room);
  }

  // Subscribe to messages
  Stream<List<ChatMessage>> get messagesStream {
    if (_chatRoom == null) return Stream.value([]);
    return ref.read(chatRepositoryProvider)
        .subscribeToMessages(_chatRoom!.id);
  }

  // Send message
  Future<void> _sendMessage(String text) async {
    if (_chatRoom == null) return;

    await ref.read(chatRepositoryProvider).sendMessage(
      ChatMessage(
        id: const Uuid().v4(),
        chatRoomId: _chatRoom!.id,
        senderId: ref.read(authRepositoryProvider).currentUser!.id,
        content: text,
      ),
    );
  }
}

// Option 2: Use legacy helpers (simpler but less efficient)
Stream<List<ChatMessage>> get messagesStream {
  return ref.read(chatRepositoryProvider)
      .subscribeToTaskMessages(widget.taskId);
}

Future<void> _sendMessage(String text) async {
  final chatRoom = await ref.read(chatRepositoryProvider)
      .getChatRoom(widget.taskId, 'mission');

  if (chatRoom == null) return;

  await ref.read(chatRepositoryProvider).sendMessage(
    ChatMessage(
      id: const Uuid().v4(),
      chatRoomId: chatRoom.id,
      senderId: ref.read(authRepositoryProvider).currentUser!.id,
      content: text,
    ),
  );
}
```

### 2. Shuttle Chat Section

**File:** `lib/features/shuttles/presentation/widgets/shuttle_chat_section.dart`

**Current Code (Lines 131-134):**
```dart
// ❌ This will cause errors
await chatRepository.sendShuttleMessage(ChatMessage(
  shuttleId: widget.shuttleId,  // ❌ shuttleId doesn't exist
  senderId: userId,
  content: text,
));
```

**Fixed Code:**
```dart
Future<void> _sendMessage(String text) async {
  final chatRoom = await ref.read(chatRepositoryProvider)
      .getChatRoom(widget.shuttleId, 'shuttle');

  if (chatRoom == null) {
    // Chat room doesn't exist - this shouldn't happen as it's auto-created
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('聊天室尚未建立，請稍後再試')),
    );
    return;
  }

  await ref.read(chatRepositoryProvider).sendMessage(
    ChatMessage(
      id: const Uuid().v4(),
      chatRoomId: chatRoom.id,
      senderId: ref.read(authRepositoryProvider).currentUser!.id,
      content: text,
    ),
  );
}

// Subscribe to messages
Stream<List<ChatMessage>> get messagesStream {
  return ref.read(chatRepositoryProvider)
      .subscribeToShuttleMessages(widget.shuttleId);
}
```

---

## Migration Benefits

### 1. **Unified Architecture**
- Single chat system for all entities (missions, shuttles, future: groups, etc.)
- Easier to add new entity types

### 2. **Auto-Created Chat Rooms**
- No need to manually create chat rooms
- Database trigger creates room on mission/shuttle insert

### 3. **Message Expiry**
- Automatic cleanup of old messages (30 days)
- `prune_expired_messages()` function can be called via cron

### 4. **Better Permissions**
- RLS policies check participant status
- Only joined participants can read/write messages

### 5. **Image Support**
- New `image_url` field for sharing photos
- Can be used for damage reports, resource photos, etc.

---

## Testing Checklist

After updating the UI code:

- [ ] Test sending message in task detail screen
- [ ] Test sending message in shuttle chat section
- [ ] Verify messages appear in real-time (subscriptions work)
- [ ] Test that non-participants cannot see chat (RLS)
- [ ] Test image upload (if implemented)
- [ ] Verify old messages expire after 30 days
- [ ] Test chat room auto-creation on new mission/shuttle

---

## Rollback Plan (If Needed)

If you need to temporarily restore the old schema:

```sql
-- Recreate old tables (not recommended)
CREATE TABLE mission_messages (
  id UUID PRIMARY KEY,
  mission_id UUID REFERENCES missions(id),
  author_id UUID REFERENCES auth.users(id),
  content TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE shuttle_messages (
  id UUID PRIMARY KEY,
  shuttle_id UUID REFERENCES shuttles(id),
  author_id UUID REFERENCES auth.users(id),
  content TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);
```

But **strongly recommend** updating the UI instead, as the new schema provides:
- Better architecture
- Auto-cleanup
- Unified permissions
- Future extensibility

---

## Questions?

Check these files for reference:
- `lib/features/chat/data/chat_repository.dart` - Full repository API
- `lib/models/chat_message.dart` - Message model definition
- `lib/models/chat_room.dart` - Chat room model definition
- `supabase_schema.sql` - Database schema (lines 217-237)

**Last Updated:** 2025-11-23
