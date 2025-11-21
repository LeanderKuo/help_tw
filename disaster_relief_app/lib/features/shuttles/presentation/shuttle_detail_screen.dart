import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../data/shuttle_repository.dart';
import 'shuttle_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/navigation_utils.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../core/widgets/global_chrome.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/shuttle_model.dart';
import '../../auth/data/auth_repository.dart';
import '../../profile/data/profile_repository.dart';
import '../../../models/user_profile.dart';
import '../../chat/data/chat_repository.dart';
import '../../../models/chat_message.dart';

final shuttleDetailProvider = FutureProvider.family<ShuttleModel?, String>((
  ref,
  id,
) async {
  final shuttles = await ref.watch(shuttleRepositoryProvider).getShuttles();
  try {
    return shuttles.firstWhere((s) => s.id == id);
  } catch (_) {
    return null;
  }
});

final shuttleParticipationProvider = FutureProvider.family<bool, String>((
  ref,
  shuttleId,
) async {
  return ref.watch(shuttleRepositoryProvider).isUserParticipant(shuttleId);
});

final shuttleHostProfileProvider = FutureProvider.family<UserProfile?, String?>(
  (ref, userId) async {
    if (userId == null) return null;
    return ref.watch(profileRepositoryProvider).getProfile(userId);
  },
);

final shuttleMessagesProvider =
    StreamProvider.family<List<ChatMessage>, String>((ref, shuttleId) {
      return ref
          .watch(chatRepositoryProvider)
          .subscribeToShuttleMessages(shuttleId);
    });

class ShuttleDetailScreen extends ConsumerStatefulWidget {
  const ShuttleDetailScreen({required this.shuttleId, super.key});

  final String shuttleId;

  @override
  ConsumerState<ShuttleDetailScreen> createState() =>
      _ShuttleDetailScreenState();
}

class _ShuttleDetailScreenState extends ConsumerState<ShuttleDetailScreen> {
  bool _isVisible = true;
  bool _isBusy = false;
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shuttleAsync = ref.watch(shuttleDetailProvider(widget.shuttleId));
    final joinedAsync = ref.watch(
      shuttleParticipationProvider(widget.shuttleId),
    );
    final l10n = AppLocalizations.of(context)!;

    ref.listen(shuttleMessagesProvider(widget.shuttleId), (_, next) {
      if (next.hasValue) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.jumpTo(
              _scrollController.position.maxScrollExtent,
            );
          }
        });
      }
    });

    return Scaffold(
      appBar: GlobalTopNavBar(
        title: l10n.shuttleDetails,
        onNotificationTap: () {},
      ),
      body: shuttleAsync.when(
        data: (shuttle) {
          if (shuttle == null) {
            return Center(child: Text(l10n.shuttleNotFound));
          }
          final joined = joinedAsync.valueOrNull ?? false;
          final isFull =
              shuttle.capacity > 0 && shuttle.seatsTaken >= shuttle.capacity;

          return Column(
            children: [
              SizedBox(
                height: 240,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      shuttle.routeStartLat ?? 25.0330,
                      shuttle.routeStartLng ?? 121.5654,
                    ),
                    zoom: 12,
                  ),
                  markers: {
                    if (shuttle.routeStartLat != null &&
                        shuttle.routeStartLng != null)
                      Marker(
                        markerId: const MarkerId('start'),
                        position: LatLng(
                          shuttle.routeStartLat!,
                          shuttle.routeStartLng!,
                        ),
                        infoWindow: InfoWindow(title: l10n.startPoint),
                      ),
                    if (shuttle.routeEndLat != null &&
                        shuttle.routeEndLng != null)
                      Marker(
                        markerId: const MarkerId('end'),
                        position: LatLng(
                          shuttle.routeEndLat!,
                          shuttle.routeEndLng!,
                        ),
                        infoWindow: InfoWindow(title: l10n.endPoint),
                      ),
                  },
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shuttle.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimaryLight,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          StatusChip(
                            label: _statusLabel(shuttle.status, l10n),
                            backgroundColor: AppColors.primary.withValues(
                              alpha: 0.12,
                            ),
                            textColor: AppColors.primary,
                          ),
                          const SizedBox(width: 8),
                          StatusChip(
                            label: shuttle.costType,
                            backgroundColor: AppColors.secondary.withValues(
                              alpha: 0.12,
                            ),
                            textColor: AppColors.secondary,
                          ),
                          const Spacer(),
                          Text(
                            l10n.updatedAt(
                              shuttle.updatedAt != null
                                  ? '${shuttle.updatedAt!.month}/${shuttle.updatedAt!.day}'
                                  : l10n.unknownTime,
                            ),
                            style: const TextStyle(
                              color: AppColors.textSecondaryLight,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _infoTile(
                        icon: Icons.note_outlined,
                        label: 'Notes',
                        value: shuttle.description ?? 'Not provided',
                      ),
                      _infoTile(
                        icon: Icons.place_outlined,
                        label: 'Origin',
                        value: shuttle.originAddress ?? 'Not set',
                      ),
                      _infoTile(
                        icon: Icons.flag,
                        label: 'Destination',
                        value: shuttle.destinationAddress ?? 'Not set',
                      ),
                      _infoTile(
                        icon: Icons.access_time,
                        label: 'Departure time',
                        value: shuttle.departureTime != null
                            ? '${shuttle.departureTime!.month}/${shuttle.departureTime!.day} ${shuttle.departureTime!.hour.toString().padLeft(2, '0')}:${shuttle.departureTime!.minute.toString().padLeft(2, '0')}'
                            : l10n.timeNotSet,
                      ),
                      _infoTile(
                        icon: Icons.timer_off_outlined,
                        label: 'Signup deadline',
                        value: shuttle.signupDeadline != null
                            ? '${shuttle.signupDeadline!.month}/${shuttle.signupDeadline!.day} ${shuttle.signupDeadline!.hour.toString().padLeft(2, '0')}:${shuttle.signupDeadline!.minute.toString().padLeft(2, '0')}'
                            : 'Not set',
                      ),
                      _infoTile(
                        icon: Icons.people_alt_outlined,
                        label: 'Seats',
                        value: '${shuttle.seatsTaken}/${shuttle.capacity}',
                      ),
                      _infoTile(
                        icon: Icons.payments_outlined,
                        label: 'Fare',
                        value: shuttle.farePerPerson != null
                            ? 'Total ${shuttle.fareTotal?.toStringAsFixed(0) ?? '-'} / Per person ${shuttle.farePerPerson!.toStringAsFixed(0)}'
                            : 'Not set',
                      ),
                      const SizedBox(height: 10),
                      _HostContact(shuttle: shuttle),
                      const SizedBox(height: 16),
                      SwitchListTile(
                        title: const Text('Share my contact with riders'),
                        subtitle: const Text('Visible after joining'),
                        value: _isVisible,
                        onChanged: joined
                            ? null
                            : (v) => setState(() => _isVisible = v),
                      ),
                      const SizedBox(height: 12),
                      _ShuttleChatSection(
                        shuttleId: widget.shuttleId,
                        joined: joined,
                        messageController: _messageController,
                        scrollController: _scrollController,
                      ),
                    ],
                  ),
                ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => _openNavigation(shuttle),
                          icon: const Icon(Icons.navigation),
                          label: const Text('Navigate'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: (isFull && !joined) || _isBusy
                              ? null
                              : () => _toggleJoin(joined),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: joined
                              ? const Text('Leave shuttle')
                              : Text(isFull ? 'Shuttle full' : 'Join shuttle'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text(l10n.errorWithMessage('$e'))),
      ),
    );
  }

  Future<void> _openNavigation(ShuttleModel shuttle) async {
    final targetLat = shuttle.routeEndLat ?? shuttle.routeStartLat;
    final targetLng = shuttle.routeEndLng ?? shuttle.routeStartLng;
    if (targetLat == null || targetLng == null) {
      _showSnack('No coordinates available for navigation');
      return;
    }
    try {
      await launchGoogleMapsNavigation(lat: targetLat, lng: targetLng);
    } catch (e) {
      _showSnack('Navigation failed: $e');
    }
  }

  void _showSnack(String message, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? AppColors.success : null,
      ),
    );
  }

  Future<void> _toggleJoin(bool joined) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) return;
    setState(() => _isBusy = true);
    try {
      if (joined) {
        await ref
            .read(shuttleControllerProvider.notifier)
            .leaveShuttle(widget.shuttleId);
        if (!mounted) return;
        _showSnack('Left shuttle');
      } else {
        await ref
            .read(shuttleControllerProvider.notifier)
            .joinShuttle(widget.shuttleId, isVisible: _isVisible);
        if (!mounted) return;
        _showSnack('Joined shuttle', success: true);
      }
    } catch (e) {
      if (!mounted) return;
      _showSnack('Action failed: $e');
    } finally {
      if (mounted) {
        setState(() => _isBusy = false);
      }
    }
  }
}

Widget _infoTile({
  required IconData icon,
  required String label,
  required String value,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondaryLight),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: AppColors.textSecondaryLight,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

String _statusLabel(String status, AppLocalizations l10n) {
  switch (status.toLowerCase()) {
    case 'open':
    case 'scheduled':
      return l10n.shuttleStatusScheduled;
    case 'in_progress':
    case 'en route':
      return l10n.shuttleStatusEnRoute;
    case 'done':
    case 'arrived':
      return l10n.shuttleStatusArrived;
    case 'cancelled':
    case 'canceled':
      return l10n.shuttleStatusCancelled;
    default:
      return status;
  }
}

class _HostContact extends ConsumerWidget {
  const _HostContact({required this.shuttle});

  final ShuttleModel shuttle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(
      shuttleHostProfileProvider(shuttle.createdBy),
    );
    return profileAsync.when(
      data: (profile) {
        if (profile == null) {
          return const SizedBox.shrink();
        }
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                child: const Icon(Icons.person, color: AppColors.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.nickname ?? 'Host',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimaryLight,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      profile.maskedPhone ?? 'Contact phone masked',
                      style: const TextStyle(
                        color: AppColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.privacy_tip_outlined,
                color: AppColors.textSecondaryLight,
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _ShuttleChatSection extends ConsumerWidget {
  const _ShuttleChatSection({
    required this.shuttleId,
    required this.joined,
    required this.messageController,
    required this.scrollController,
  });

  final String shuttleId;
  final bool joined;
  final TextEditingController messageController;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesAsync = ref.watch(shuttleMessagesProvider(shuttleId));
    final userId = ref.watch(authRepositoryProvider).currentUser?.id;

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
            data: (messages) {
              if (messages.isEmpty) {
                return const Center(child: Text('No messages yet.'));
              }
              return ListView.builder(
                controller: scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  final isMe = msg.senderId == userId;
                  return Align(
                    alignment: isMe
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
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
                            msg.createdAt != null
                                ? timeago.format(msg.createdAt!)
                                : '',
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
            },
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
              onPressed: () async {
                final text = messageController.text.trim();
                if (text.isEmpty) return;
                final user = ref.read(authRepositoryProvider).currentUser?.id;
                if (user == null) return;
                messageController.clear();
                await ref
                    .read(chatRepositoryProvider)
                    .sendShuttleMessage(
                      ChatMessage(
                        id: '',
                        shuttleId: shuttleId,
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
              },
            ),
          ],
        ),
      ],
    );
  }
}
