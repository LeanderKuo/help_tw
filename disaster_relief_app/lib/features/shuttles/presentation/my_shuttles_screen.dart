import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/auth/role.dart';
import '../../../core/auth/role_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../core/widgets/global_chrome.dart';
import '../../../features/auth/data/auth_repository.dart';
import '../../../models/shuttle_model.dart';
import '../data/shuttle_repository.dart';
import 'shuttle_controller.dart';

final joinedShuttleIdsProvider = FutureProvider<Set<String>>((ref) {
  return ref.watch(shuttleRepositoryProvider).getJoinedShuttleIds();
});

class MyShuttlesScreen extends ConsumerStatefulWidget {
  const MyShuttlesScreen({super.key});

  @override
  ConsumerState<MyShuttlesScreen> createState() => _MyShuttlesScreenState();
}

class _MyShuttlesScreenState extends ConsumerState<MyShuttlesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool _isArchived(ShuttleModel shuttle) {
    final depart = shuttle.departureTime;
    if (depart == null) return false;
    return depart.isBefore(DateTime.now().subtract(const Duration(days: 7)));
  }

  bool _isHistory(ShuttleModel shuttle) {
    final status = shuttle.status.toLowerCase();
    final completed = status == 'done' || status == 'canceled';
    return completed && !_isArchived(shuttle);
  }

  bool _isActive(ShuttleModel shuttle) {
    final status = shuttle.status.toLowerCase();
    if (status == 'done' || status == 'canceled') return false;
    return !_isArchived(shuttle);
  }

  Future<void> _completeShuttle(ShuttleModel shuttle) async {
    final confirmed = await _confirm(
      title: 'Mark complete',
      message: 'Mark this shuttle as completed?',
    );
    if (!confirmed) return;
    await ref
        .read(shuttleControllerProvider.notifier)
        .completeShuttle(shuttle.id);
    ref.invalidate(joinedShuttleIdsProvider);
    _showSnack('Shuttle marked as done', isError: false);
  }

  Future<void> _deleteShuttle(ShuttleModel shuttle) async {
    final confirmed = await _confirm(
      title: 'Delete shuttle',
      message: 'Delete ${shuttle.title}? This cannot be undone.',
      isDestructive: true,
    );
    if (!confirmed) return;
    await ref
        .read(shuttleControllerProvider.notifier)
        .deleteShuttle(shuttle.id);
    ref.invalidate(joinedShuttleIdsProvider);
    _showSnack('Shuttle deleted', isError: false);
  }

  Future<bool> _confirm({
    required String title,
    required String message,
    bool isDestructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              isDestructive ? 'Delete' : 'Confirm',
              style: TextStyle(
                color: isDestructive ? Colors.red : AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  void _showSnack(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.redAccent : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final shuttlesAsync = ref.watch(shuttleControllerProvider);
    final joinedAsync = ref.watch(joinedShuttleIdsProvider);
    final role = ref.watch(currentUserRoleProvider);
    final userId = ref.watch(authRepositoryProvider).currentUser?.id;

    return Scaffold(
      appBar: const GlobalTopNavBar(title: 'My Shuttles'),
      body: joinedAsync.when(
        data: (joinedIds) {
          return shuttlesAsync.when(
            data: (shuttles) {
              final hosting = shuttles
                  .where((s) => s.createdBy == userId && _isActive(s))
                  .toList();
              final joined = shuttles
                  .where(
                    (s) =>
                        joinedIds.contains(s.id) &&
                        s.createdBy != userId &&
                        _isActive(s),
                  )
                  .toList();
              final history = shuttles
                  .where(
                    (s) =>
                        (s.createdBy == userId || joinedIds.contains(s.id)) &&
                        _isHistory(s),
                  )
                  .toList();

              return Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: AppColors.textSecondaryLight,
                    indicatorColor: AppColors.primary,
                    tabs: const [
                      Tab(text: 'Hosting'),
                      Tab(text: 'Joined'),
                      Tab(text: 'History'),
                    ],
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await ref
                            .read(shuttleControllerProvider.notifier)
                            .loadShuttles();
                        ref.invalidate(joinedShuttleIdsProvider);
                      },
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _MyShuttleList(
                            shuttles: hosting,
                            emptyMessage: 'You are not hosting any shuttles.',
                            role: role,
                            currentUserId: userId,
                            onEdit: (s) => context.push(
                              '/shuttles/${s.id}/edit',
                              extra: s,
                            ),
                            onComplete: _completeShuttle,
                            onDelete: _deleteShuttle,
                          ),
                          _MyShuttleList(
                            shuttles: joined,
                            emptyMessage: 'You have not joined any shuttles.',
                            role: role,
                            currentUserId: userId,
                            onEdit: null,
                            onComplete: (s) => _completeShuttle(s),
                            onDelete: null,
                          ),
                          _MyShuttleList(
                            shuttles: history,
                            emptyMessage: 'No recent history.',
                            role: role,
                            currentUserId: userId,
                            isHistory: true,
                            onEdit: null,
                            onComplete: null,
                            onDelete: null,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => EmptyState(
              icon: Icons.error_outline,
              title: 'Load failed',
              message: error.toString(),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => EmptyState(
          icon: Icons.error_outline,
          title: 'Load failed',
          message: error.toString(),
        ),
      ),
    );
  }
}

class _MyShuttleList extends StatelessWidget {
  const _MyShuttleList({
    required this.shuttles,
    required this.emptyMessage,
    required this.role,
    required this.currentUserId,
    this.isHistory = false,
    this.onEdit,
    this.onComplete,
    this.onDelete,
  });

  final List<ShuttleModel> shuttles;
  final String emptyMessage;
  final AppRole role;
  final String? currentUserId;
  final bool isHistory;
  final void Function(ShuttleModel shuttle)? onEdit;
  final void Function(ShuttleModel shuttle)? onComplete;
  final void Function(ShuttleModel shuttle)? onDelete;

  @override
  Widget build(BuildContext context) {
    if (shuttles.isEmpty) {
      return EmptyState(
        icon: Icons.directions_bus_filled_outlined,
        title: emptyMessage,
        message: 'Shuttles you host or join will show here.',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: shuttles.length,
      itemBuilder: (context, index) {
        final shuttle = shuttles[index];
        return _MyShuttleCard(
          shuttle: shuttle,
          isHistory: isHistory,
          role: role,
          isOwner: currentUserId != null && shuttle.createdBy == currentUserId,
          onEdit: onEdit,
          onComplete: onComplete,
          onDelete: onDelete,
        );
      },
    );
  }
}

class _MyShuttleCard extends StatelessWidget {
  const _MyShuttleCard({
    required this.shuttle,
    required this.isHistory,
    required this.role,
    required this.isOwner,
    this.onEdit,
    this.onComplete,
    this.onDelete,
  });

  final ShuttleModel shuttle;
  final bool isHistory;
  final AppRole role;
  final bool isOwner;
  final void Function(ShuttleModel shuttle)? onEdit;
  final void Function(ShuttleModel shuttle)? onComplete;
  final void Function(ShuttleModel shuttle)? onDelete;

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(shuttle.status);
    final remainingSeats = (shuttle.capacity - shuttle.seatsTaken).clamp(
      0,
      shuttle.capacity,
    );

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        onTap: () => context.push('/shuttles/${shuttle.id}'),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  StatusChip(
                    label: shuttle.status,
                    backgroundColor: statusColor.withValues(alpha: 0.12),
                    textColor: statusColor,
                  ),
                  const Spacer(),
                  Text(
                    _formatDate(shuttle.departureTime),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                shuttle.title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _infoTile(
                      icon: Icons.place_outlined,
                      label: shuttle.originAddress ?? 'Origin TBD',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _infoTile(
                      icon: Icons.flag,
                      label: shuttle.destinationAddress ?? 'Destination TBD',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _infoChip(
                    icon: Icons.event,
                    label: _formatDate(shuttle.departureTime),
                  ),
                  const SizedBox(width: 8),
                  _infoChip(
                    icon: Icons.airline_seat_recline_normal,
                    label:
                        'Seats: ${shuttle.seatsTaken}/${shuttle.capacity} (left $remainingSeats)',
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  if (isOwner && onEdit != null && !isHistory)
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => onEdit!(shuttle),
                        icon: const Icon(Icons.edit, size: 18),
                        label: const Text('Edit'),
                      ),
                    ),
                  if (isOwner && onEdit != null && !isHistory)
                    const SizedBox(width: 8),
                  if (onComplete != null && !isHistory)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: (isOwner || role.isLeaderOrAbove)
                            ? () => onComplete!(shuttle)
                            : null,
                        icon: const Icon(Icons.check_circle, size: 18),
                        label: const Text('Complete'),
                      ),
                    ),
                  if (onDelete != null && isOwner && !isHistory)
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        color: Colors.redAccent,
                        onPressed: () => onDelete!(shuttle),
                      ),
                    ),
                  if (isHistory)
                    Chip(
                      avatar: const Icon(
                        Icons.inventory_2_outlined,
                        size: 16,
                        color: AppColors.textSecondaryLight,
                      ),
                      label: const Text('History (7d)'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoTile({required IconData icon, required String label}) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondaryLight),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: AppColors.textSecondaryLight),
          ),
        ),
      ],
    );
  }

  Widget _infoChip({required IconData icon, required String label}) {
    return Chip(
      avatar: Icon(icon, size: 16, color: AppColors.primary),
      label: Text(label),
      padding: const EdgeInsets.symmetric(horizontal: 6),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'TBD';
    return '${date.month}/${date.day} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return AppColors.primary;
      case 'in_progress':
      case 'in progress':
        return AppColors.warning;
      case 'done':
        return AppColors.success;
      case 'canceled':
        return AppColors.error;
      default:
        return AppColors.textSecondaryLight;
    }
  }
}
