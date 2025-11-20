import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data/shuttle_repository.dart';
import 'shuttle_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../core/widgets/global_chrome.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/shuttle_model.dart';
import '../../auth/data/auth_repository.dart';
import '../../profile/data/profile_repository.dart';
import '../../../models/user_profile.dart';

final shuttleDetailProvider =
    FutureProvider.family<ShuttleModel?, String>((ref, id) async {
  final shuttles = await ref.watch(shuttleRepositoryProvider).getShuttles();
  try {
    return shuttles.firstWhere((s) => s.id == id);
  } catch (_) {
    return null;
  }
});

final shuttleParticipationProvider =
    FutureProvider.family<bool, String>((ref, shuttleId) async {
  return ref.watch(shuttleRepositoryProvider).isUserParticipant(shuttleId);
});

final shuttleHostProfileProvider =
    FutureProvider.family<UserProfile?, String?>((ref, userId) async {
  if (userId == null) return null;
  return ref.watch(profileRepositoryProvider).getProfile(userId);
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

  @override
  Widget build(BuildContext context) {
    final shuttleAsync = ref.watch(shuttleDetailProvider(widget.shuttleId));
    final joinedAsync =
        ref.watch(shuttleParticipationProvider(widget.shuttleId));
    final l10n = AppLocalizations.of(context)!;

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
          final isFull = shuttle.capacity > 0 &&
              shuttle.seatsTaken >= shuttle.capacity &&
              !joined;
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
                        position:
                            LatLng(shuttle.routeStartLat!, shuttle.routeStartLng!),
                        infoWindow: InfoWindow(title: l10n.startPoint),
                      ),
                    if (shuttle.routeEndLat != null && shuttle.routeEndLng != null)
                      Marker(
                        markerId: const MarkerId('end'),
                        position:
                            LatLng(shuttle.routeEndLat!, shuttle.routeEndLng!),
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
                            backgroundColor:
                                AppColors.primary.withValues(alpha: 0.12),
                            textColor: AppColors.primary,
                          ),
                          const SizedBox(width: 8),
                          StatusChip(
                            label: shuttle.costType,
                            backgroundColor:
                                AppColors.secondary.withValues(alpha: 0.12),
                            textColor: AppColors.secondary,
                          ),
                          const Spacer(),
                          Text(
                            l10n.updatedAt(
                              shuttle.updatedAt != null
                                  ? '${shuttle.updatedAt!.month}/${shuttle.updatedAt!.day}'
                                  : l10n.unknownTime,
                            ),
                            style:
                                const TextStyle(color: AppColors.textSecondaryLight),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _infoTile(
                        icon: Icons.note_outlined,
                        label: '備註 / 說明',
                        value: shuttle.description ?? '尚未填寫',
                      ),
                      _infoTile(
                        icon: Icons.place_outlined,
                        label: '起點地址',
                        value: shuttle.originAddress ?? '尚未設定',
                      ),
                      _infoTile(
                        icon: Icons.flag,
                        label: '終點地址',
                        value: shuttle.destinationAddress ?? '尚未設定',
                      ),
                      _infoTile(
                        icon: Icons.access_time,
                        label: '發車時間',
                        value: shuttle.departureTime != null
                            ? '${shuttle.departureTime!.month}/${shuttle.departureTime!.day} ${shuttle.departureTime!.hour.toString().padLeft(2, '0')}:${shuttle.departureTime!.minute.toString().padLeft(2, '0')}'
                            : l10n.timeNotSet,
                      ),
                      _infoTile(
                        icon: Icons.timer_off_outlined,
                        label: '報名截止',
                        value: shuttle.signupDeadline != null
                            ? '${shuttle.signupDeadline!.month}/${shuttle.signupDeadline!.day} ${shuttle.signupDeadline!.hour.toString().padLeft(2, '0')}:${shuttle.signupDeadline!.minute.toString().padLeft(2, '0')}'
                            : '未設定',
                      ),
                      _infoTile(
                        icon: Icons.people_alt_outlined,
                        label: '參與人數',
                        value: '${shuttle.seatsTaken}/${shuttle.capacity}',
                      ),
                      _infoTile(
                        icon: Icons.payments_outlined,
                        label: '費用',
                        value: shuttle.farePerPerson != null
                            ? '總額 ${shuttle.fareTotal?.toStringAsFixed(0) ?? '-'} / 人均 ${shuttle.farePerPerson!.toStringAsFixed(0)}'
                            : '未設定',
                      ),
                      const SizedBox(height: 10),
                      _HostContact(shuttle: shuttle),
                      const SizedBox(height: 16),
                      SwitchListTile(
                        title: const Text('公開聯絡方式給同車成員'),
                        subtitle: const Text('關閉後僅主揪可見'),
                        value: _isVisible,
                        onChanged: joined ? null : (v) => setState(() => _isVisible = v),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              '已加入者可查看聊聊 / 與主揪訊息',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimaryLight,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              '加入後即可在聊天室同步行程異動',
                              style: TextStyle(color: AppColors.textSecondaryLight),
                            ),
                          ],
                        ),
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
                          onPressed: () {},
                          icon: const Icon(Icons.navigation),
                          label: const Text('導航查看'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isFull && !joined || _isBusy
                              ? null
                              : () => _toggleJoin(joined),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: joined
                              ? const Text('退出班車')
                              : Text(isFull ? '車次已滿' : '報名上車'),
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

  Future<void> _toggleJoin(bool joined) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) return;
    setState(() => _isBusy = true);
    try {
      if (joined) {
        await ref.read(shuttleControllerProvider.notifier).leaveShuttle(widget.shuttleId);
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('已退出班車')));
      } else {
        await ref
            .read(shuttleControllerProvider.notifier)
            .joinShuttle(widget.shuttleId, isVisible: _isVisible);
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('報名成功')));
      }
    } finally {
      setState(() => _isBusy = false);
    }
  }
}

Widget _infoTile({required IconData icon, required String label, required String value}) {
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
    final profileAsync =
        ref.watch(shuttleHostProfileProvider(shuttle.createdBy));
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
                      profile.nickname ?? '主揪',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimaryLight,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      profile.maskedPhone ?? '已遮罩聯絡電話',
                      style: const TextStyle(color: AppColors.textSecondaryLight),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.privacy_tip_outlined, color: AppColors.textSecondaryLight),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
