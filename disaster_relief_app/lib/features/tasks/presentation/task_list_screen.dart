import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'task_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../core/widgets/global_chrome.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/task_model.dart';

class TaskListScreen extends ConsumerStatefulWidget {
  const TaskListScreen({super.key});

  @override
  ConsumerState<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends ConsumerState<TaskListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();
  final _latController = TextEditingController();
  final _lngController = TextEditingController();

  String _searchQuery = '';
  double _distanceKm = 25;
  String _selectedFilter = '全部任務';
  String _selectedSort = '最新建立';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _latController.dispose();
    _lngController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasksAsync = ref.watch(taskControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: GlobalTopNavBar(
        title: '救災資源整合平台',
        onNotificationTap: () {},
        onAvatarTap: () => context.push('/profile'),
      ),
      body: ResponsiveLayout(
        child: Column(
          children: [
            _MissionHeader(l10n: l10n),
            const SizedBox(height: 12),
            _buildControlPanel(context, l10n),
            TabBar(
              controller: _tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondaryLight,
              indicatorColor: AppColors.primary,
              tabs: [
                Tab(text: l10n.tabOpenTasks),
                Tab(text: l10n.tabMyDrafts),
              ],
            ),
            Expanded(
              child: tasksAsync.when(
                data: (tasks) {
                  final filteredTasks = tasks.where((t) {
                    if (t.isDraft) return false;
                    final matchesSearch = _searchQuery.isEmpty ||
                        t.title.toLowerCase().contains(_searchQuery.toLowerCase());
                    return matchesSearch;
                  }).toList();

                  final myTasks = tasks.where((t) => t.isDraft).toList();

                  return TabBarView(
                    controller: _tabController,
                    children: [
                      _TaskListView(
                        tasks: filteredTasks,
                        emptyMessage: l10n.noTasksMatch,
                        l10n: l10n,
                      ),
                      _TaskListView(
                        tasks: myTasks,
                        emptyMessage: l10n.noDraftsYet,
                        l10n: l10n,
                        isMyTasks: true,
                      ),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => EmptyState(
                  icon: Icons.error_outline,
                  title: l10n.loadFailed,
                  message: error.toString(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlPanel(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => context.push('/tasks/create'),
                    icon: const Icon(Icons.add),
                    label: Text(l10n.createTask),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.my_location),
                    label: const Text('定位我附近'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _lngController,
                    decoration: InputDecoration(
                      hintText: '經度',
                      prefixIcon: const Icon(Icons.place_outlined),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _latController,
                    decoration: InputDecoration(
                      hintText: '緯度',
                      prefixIcon: const Icon(Icons.place_outlined),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: l10n.searchTasksHint,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text('距離 0-100 公里',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryLight)),
                const SizedBox(width: 8),
                Text('${_distanceKm.toStringAsFixed(0)} km',
                    style: const TextStyle(color: AppColors.primary)),
              ],
            ),
            Slider(
              value: _distanceKm,
              min: 0,
              max: 100,
              activeColor: AppColors.primary,
              onChanged: (v) => setState(() => _distanceKm = v),
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedFilter,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: const [
                      '全部任務',
                      '一般任務',
                      '緊急任務',
                      '我的草稿',
                    ]
                        .map((filter) => DropdownMenuItem(
                              value: filter,
                              child: Text(filter),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _selectedFilter = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedSort,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: const [
                      '最新建立',
                      '最近更新',
                      '距離最近',
                    ]
                        .map((sort) => DropdownMenuItem(
                              value: sort,
                              child: Text(sort),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _selectedSort = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskListView extends StatelessWidget {
  final List<TaskModel> tasks;
  final String emptyMessage;
  final bool isMyTasks;
  final AppLocalizations l10n;

  const _TaskListView({
    required this.tasks,
    required this.emptyMessage,
    required this.l10n,
    this.isMyTasks = false,
  });

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return EmptyState(
        icon: Icons.assignment_outlined,
        title: emptyMessage,
        message: l10n.taskEmptyMessage,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return _TaskCard(task: task, isMyTasks: isMyTasks, l10n: l10n);
      },
    );
  }
}

class _TaskCard extends StatelessWidget {
  final TaskModel task;
  final bool isMyTasks;
  final AppLocalizations l10n;

  const _TaskCard({
    required this.task,
    required this.l10n,
    this.isMyTasks = false,
  });

  int get remainingSlots =>
      (task.requiredParticipants - task.participantCount).clamp(0, 999);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        onTap: () => context.push('/tasks/${task.id}'),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  StatusChip(
                    label: task.roleLabel ?? '任務發起人',
                    backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                    textColor: AppColors.primary,
                  ),
                  const Spacer(),
                  Text(
                    _formatDate(task.createdAt),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      task.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimaryLight,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '剩餘 $remainingSlots 人',
                      style: const TextStyle(
                        color: AppColors.secondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              if (task.description != null && task.description!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  task.description!,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondaryLight,
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 12),
              Column(
                children: [
                  _infoTile(
                    icon: Icons.place_outlined,
                    label: task.address ?? l10n.locationNotSet,
                  ),
                  _infoTile(
                    icon: Icons.update,
                    label: '最近更新：${_formatDate(task.updatedAt)}',
                  ),
                  _infoTile(
                    icon: Icons.inventory_2_outlined,
                    label: '物資需求：${task.materialsStatus}',
                  ),
                  _infoTile(
                    icon: Icons.people_alt_outlined,
                    label:
                        '參與情況：${task.participantCount}/${task.requiredParticipants <= 0 ? '—' : task.requiredParticipants}',
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.navigation, size: 18),
                      label: const Text('導航'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => context.push('/tasks/${task.id}'),
                      icon: const Icon(Icons.info_outline, size: 18),
                      label: const Text('查看詳情 / 加入'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  StatusChip(
                    label: _statusLabel(task.status),
                    backgroundColor: _getStatusColor(task.status).withValues(alpha: 0.12),
                    textColor: _getStatusColor(task.status),
                    icon: _getPriorityIcon(task.priority),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondaryLight),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondaryLight,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return AppColors.primary;
      case 'in progress':
        return AppColors.warning;
      case 'completed':
        return AppColors.success;
      case 'cancelled':
        return AppColors.statusCompleted;
      default:
        return AppColors.textSecondaryLight;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'emergency':
        return AppColors.error;
      case 'high':
        return AppColors.warning;
      case 'normal':
        return AppColors.primary;
      case 'low':
        return AppColors.success;
      default:
        return AppColors.textSecondaryLight;
    }
  }

  IconData _getPriorityIcon(String priority) {
    switch (priority.toLowerCase()) {
      case 'emergency':
        return Icons.priority_high;
      case 'high':
        return Icons.arrow_upward;
      case 'normal':
        return Icons.remove;
      case 'low':
        return Icons.arrow_downward;
      default:
        return Icons.label;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return l10n.unknownTime;
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return l10n.justNow;
    } else if (difference.inHours < 1) {
      return l10n.minutesAgo(difference.inMinutes);
    } else if (difference.inDays < 1) {
      return l10n.hoursAgo(difference.inHours);
    } else {
      return l10n.daysAgo(difference.inDays);
    }
  }

  String _statusLabel(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return l10n.taskStatusOpen;
      case 'in progress':
        return l10n.taskStatusInProgress;
      case 'completed':
        return l10n.taskStatusCompleted;
      case 'cancelled':
        return l10n.taskStatusCancelled;
      default:
        return status;
    }
  }
}

class _MissionHeader extends StatelessWidget {
  const _MissionHeader({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MISSION BOARD',
            style: TextStyle(
              color: AppColors.primary.withValues(alpha: 0.8),
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.missionBoardTitle,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '任務一覽・搜尋、篩選並快速加入救災任務',
            style: TextStyle(
              color: AppColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }
}
