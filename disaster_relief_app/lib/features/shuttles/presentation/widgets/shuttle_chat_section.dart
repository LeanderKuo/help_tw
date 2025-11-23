import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/theme/app_colors.dart';
import '../../../../models/chat_message.dart';
import '../../../auth/data/auth_repository.dart';
import '../../../chat/data/chat_repository.dart';
import '../shuttle_detail_providers.dart';

class ShuttleChatSection extends ConsumerWidget {
  const ShuttleChatSection({
    required this.shuttleId,
    required this.joined,
    required this.messageController,
    required this.scrollController,
    super.key,
  });

  final String shuttleId;
  final bool joined;
  final TextEditingController messageController;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesAsync = ref.watch(shuttleMessagesProvider(shuttleId));
    final userId = ref.watch(currentUserIdProvider);

    if (!joined) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text('Join this shuttle to view and send messages.'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Shuttle chat',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          height: 240,
          child: messagesAsync.when(
            data: (messages) => _buildMessages(messages, userId),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Chat load failed: $e')),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: messageController,
                decoration: const InputDecoration(
                  hintText: 'Send a message',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => _sendMessage(ref),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMessages(List<ChatMessage> messages, String? currentUserId) {
    if (messages.isEmpty) {
      return const Center(child: Text('No messages yet.'));
    }
    return ListView.builder(
      controller: scrollController,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final msg = messages[index];
        final isMe = msg.senderId == currentUserId;
        return Align(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isMe
                  ? AppColors.primary.withValues(alpha: 0.12)
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(msg.content ?? ''),
                const SizedBox(height: 4),
                Text(
                  msg.createdAt != null ? timeago.format(msg.createdAt!) : '',
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _sendMessage(WidgetRef ref) async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;
    final user = ref.read(authRepositoryProvider).currentUser?.id;
    if (user == null) return;

    final chatRepo = ref.read(chatRepositoryProvider);
    final chatRoom = await chatRepo.getChatRoom(shuttleId, 'shuttle');

    if (chatRoom == null) {
      // Chat room doesn't exist - this shouldn't happen as it's auto-created
      return;
    }

    messageController.clear();

    await chatRepo.sendMessage(
      ChatMessage(
        id: '',
        chatRoomId: chatRoom.id,
        senderId: user,
        content: text,
        createdAt: DateTime.now(),
      ),
    );

    if (scrollController.hasClients) {
      await scrollController.animateTo(
        scrollController.position.maxScrollExtent + 60,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }
}
