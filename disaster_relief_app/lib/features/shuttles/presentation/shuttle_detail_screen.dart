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

final shuttleDetailProvider = FutureProvider.family<ShuttleModel?, String>((ref, id) async {
  final shuttles = await ref.watch(shuttleRepositoryProvider).getShuttles();
  try {
    return shuttles.firstWhere((s) => s.id == id);
  } catch (_) {
    return null;
  }
});

class ShuttleDetailScreen extends ConsumerWidget {
  final String shuttleId;

  const ShuttleDetailScreen({required this.shuttleId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shuttleAsync = ref.watch(shuttleDetailProvider(shuttleId));
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
                    if (shuttle.routeStartLat != null)
                      Marker(
                        markerId: const MarkerId('start'),
                        position: LatLng(shuttle.routeStartLat!, shuttle.routeStartLng!),
                        infoWindow: InfoWindow(title: l10n.startPoint),
                      ),
                    if (shuttle.routeEndLat != null)
                      Marker(
                        markerId: const MarkerId('end'),
                        position: LatLng(shuttle.routeEndLat!, shuttle.routeEndLng!),
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
                            backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                            textColor: AppColors.primary,
                          ),
                          const SizedBox(width: 8),
                          StatusChip(
                            label: shuttle.costType,
                            backgroundColor: AppColors.secondary.withValues(alpha: 0.12),
                            textColor: AppColors.secondary,
                          ),
                          const Spacer(),
                          Text(
                            l10n.updatedAt(
                              shuttle.updatedAt != null
                                  ? '${shuttle.updatedAt!.month}/${shuttle.updatedAt!.day}'
                                  : l10n.unknownTime,
                            ),
                            style: const TextStyle(color: AppColors.textSecondaryLight),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _infoTile(
                        icon: Icons.note_outlined,
                        label: '備註 / 描述',
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
                        label: '出發時間',
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
                            : '未提供',
                      ),
                      const SizedBox(height: 16),
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
                              '參與者列表 / 聊天訊息串',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimaryLight,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              '加入班車後即可查看參與者與聊天室。',
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
                          label: const Text('導航集合地'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            final user = ref.read(authRepositoryProvider).currentUser;
                            if (user != null) {
                              ref
                                  .read(shuttleControllerProvider.notifier)
                                  .joinShuttle(shuttleId);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(l10n.joinedShuttleSuccess)),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text('我要上車'),
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
