import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'task_controller.dart';
import '../../../models/task_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../l10n/app_localizations.dart';

class TaskListScreen extends ConsumerStatefulWidget {
  const TaskListScreen({super.key});

  @override
  ConsumerState<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends ConsumerState<TaskListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All categories';
  String _selectedSort = 'Newest';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  String _filterLabel(String value, AppLocalizations l10n) {
    switch (value) {
      case 'General':
        return l10n.filterGeneral;
      case 'Urgent':
        return l10n.filterUrgent;
      case 'My drafts':
        return l10n.filterMyDrafts;
      default:
        return l10n.filterAllCategories;
    }
  }

  String _sortLabel(String value, AppLocalizations l10n) {
    switch (value) {
      case 'Nearest':
        return l10n.sortNearest;
      case 'Priority':
        return l10n.sortPriority;
      default:
        return l10n.sortNewest;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tasksAsync = ref.watch(taskControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.missionBoardTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () {
              ref.read(taskControllerProvider.notifier).syncDrafts();
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => context.push('/profile'),
          ),
        ],
      ),
      body: ResponsiveLayout(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: AppColors.surfaceLight,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => context.push('/tasks/create'),
                          icon: const Icon(Icons.add),
                          label: Text(l10n.createTask),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // TODO: Location picker
                          },
                          icon: const Icon(Icons.my_location),
                          label: Text(l10n.useMyLocation),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: l10n.searchTasksHint,
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: _selectedFilter,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          items: ['All categories', 'General', 'Urgent', 'My drafts']
                              .map(
                                (filter) => DropdownMenuItem(
                                  value: filter,
                                  child: Text(
                                    _filterLabel(filter, l10n),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _selectedFilter = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: _selectedSort,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          items: ['Newest', 'Nearest', 'Priority']
                              .map(
                                (sort) => DropdownMenuItem(
                                  value: sort,
                                  child: Text(
                                    _sortLabel(sort, l10n),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              )
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
                    if (!t.isDraft) {
                      if (_searchQuery.isNotEmpty) {
                        return t.title
                            .toLowerCase()
                            .contains(_searchQuery.toLowerCase());
                      }
                      return true;
                    }
                    return false;
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

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: () => context.push('/tasks/${task.id}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(task.status),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      _statusLabel(task.status),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (isMyTasks)
                    const Icon(Icons.edit, size: 18, color: AppColors.textSecondaryLight),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                task.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 8),
              if (task.description != null && task.description!.isNotEmpty) ...[
                Text(
                  task.description!,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondaryLight,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
              ],
              Row(
                children: [
                  Icon(Icons.location_on_outlined,
                      size: 16, color: AppColors.textSecondaryLight),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      task.latitude != null && task.longitude != null
                          ? '${task.latitude}, ${task.longitude}'
                          : l10n.locationNotSet,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondaryLight,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.access_time,
                      size: 16, color: AppColors.textSecondaryLight),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(task.createdAt),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getPriorityColor(task.priority).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getPriorityIcon(task.priority),
                          size: 14,
                          color: _getPriorityColor(task.priority),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _priorityLabel(task.priority),
                          style: TextStyle(
                            fontSize: 11,
                            color: _getPriorityColor(task.priority),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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

  String _priorityLabel(String priority) {
    switch (priority.toLowerCase()) {
      case 'low':
        return l10n.priorityLow;
      case 'high':
        return l10n.priorityHigh;
      case 'emergency':
        return l10n.priorityEmergency;
      default:
        return l10n.priorityNormal;
    }
  }
}
