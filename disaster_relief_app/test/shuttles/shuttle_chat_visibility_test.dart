import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:disaster_relief_platform/features/shuttles/presentation/shuttle_detail_providers.dart';
import 'package:disaster_relief_platform/features/shuttles/presentation/widgets/shuttle_chat_section.dart';
import 'package:disaster_relief_platform/models/chat_message.dart';

void main() {
  Widget buildApp({
    bool joined = false,
    List<ChatMessage> messages = const [],
  }) {
    return ProviderScope(
      overrides: [
        shuttleMessagesProvider.overrideWith(
          (ref, shuttleId) => Stream.value(messages),
        ),
        currentUserIdProvider.overrideWithValue('user-123'),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: ShuttleChatSection(
            shuttleId: 's1',
            joined: joined,
            messageController: TextEditingController(),
            scrollController: ScrollController(),
          ),
        ),
      ),
    );
  }

  testWidgets('Non-participants see join prompt for shuttle chat', (
    tester,
  ) async {
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    expect(
      find.text('Join this shuttle to view and send messages.'),
      findsOneWidget,
    );
  });

  testWidgets('Participants see chat messages', (tester) async {
    final msgs = [
      ChatMessage(
        id: 'm1',
        shuttleId: 's1',
        senderId: 'user-123',
        content: 'Hello team',
        createdAt: DateTime.now(),
      ),
    ];

    await tester.pumpWidget(buildApp(joined: true, messages: msgs));
    await tester.pumpAndSettle();

    expect(find.text('Shuttle chat'), findsOneWidget);
    expect(find.text('Hello team'), findsOneWidget);
  });
}
