import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'shuttle_controller.dart';
import '../../../models/shuttle_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/common_widgets.dart';

class ShuttleListScreen extends ConsumerStatefulWidget {
  const ShuttleListScreen({super.key});

  @override
  ConsumerState<ShuttleListScreen> createState() => _ShuttleListScreenState();
}

class _ShuttleListScreenState extends ConsumerState<ShuttleListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shuttlesAsync = ref.watch(shuttleControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MY SHUTTLES\n我的班車'),
        actions: [
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
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: 創建新班車
                      },
                      icon: const Icon(Icons.directions_bus),
                      label: const Text('回班車列表'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: '搜尋班車、目的地或描述',
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
                ],
              ),
            ),
            TabBar(
              controller: _tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondaryLight,
              indicatorColor: AppColors.primary,
              tabs: const [
                Tab(text: '我是主揪'),
                Tab(text: '加入班車'),
                Tab(text: '完成車次'),
              ],
            ),
            Expanded(
              child: shuttlesAsync.when(
                data: (shuttles) {
                  final filteredShuttles = shuttles.where((s) {
                    if (_searchQuery.isNotEmpty) {
                      return s.title
                          .toLowerCase()
                          .contains(_searchQuery.toLowerCase());
                    }
                    return true;
                  }).toList();

                  final myShuttles = filteredShuttles
                      .where((s) => s.status != 'Arrived' && s.status != 'Cancelled')
                      .toList();
                  final joinedShuttles = filteredShuttles
                      .where((s) => s.status == 'En Route')
                      .toList();
                  final completedShuttles = filteredShuttles
                      .where((s) => s.status == 'Arrived' || s.status == 'Cancelled')
                      .toList();

                  return TabBarView(
                    controller: _tabController,
                    children: [
                      _ShuttleListView(
                        shuttles: myShuttles,
                        emptyMessage: '您尚未建立任何班車',
                      ),
                      _ShuttleListView(
                        shuttles: joinedShuttles,
                        emptyMessage: '您尚未加入任何班車',
                      ),
                      _ShuttleListView(
                        shuttles: completedShuttles,
                        emptyMessage: '尚無完成的車次',
                        isCompleted: true,
                      ),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => EmptyState(
                  icon: Icons.error_outline,
                  title: '載入失敗',
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

class _ShuttleListView extends StatelessWidget {
  final List<ShuttleModel> shuttles;
  final String emptyMessage;
  final bool isCompleted;

  const _ShuttleListView({
    required this.shuttles,
    required this.emptyMessage,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    if (shuttles.isEmpty) {
      return EmptyState(
        icon: Icons.directions_bus_outlined,
        title: emptyMessage,
        message: '嘗試建立新班車或加入現有班車',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: shuttles.length,
      itemBuilder: (context, index) {
        final shuttle = shuttles[index];
        return _ShuttleCard(shuttle: shuttle, isCompleted: isCompleted);
      },
    );
  }
}

class _ShuttleCard extends StatelessWidget {
  final ShuttleModel shuttle;
  final bool isCompleted;

  const _ShuttleCard({
    required this.shuttle,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: () => context.push('/shuttles/${shuttle.id}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getStatusColor(shuttle.status).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.directions_bus,
                      color: _getStatusColor(shuttle.status),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shuttle.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimaryLight,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getStatusColor(shuttle.status),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            _getStatusText(shuttle.status),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (shuttle.description != null && shuttle.description!.isNotEmpty) ...[
                Text(
                  shuttle.description!,
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
                  Icon(Icons.access_time,
                      size: 16, color: AppColors.textSecondaryLight),
                  const SizedBox(width: 4),
                  Text(
                    _formatTime(shuttle.departureTime),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.people_outline,
                      size: 16, color: AppColors.textSecondaryLight),
                  const SizedBox(width: 4),
                  Text(
                    '${shuttle.seatsTaken}/${shuttle.capacity}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
              if (!isCompleted) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // TODO: 導航功能
                        },
                        icon: const Icon(Icons.navigation, size: 16),
                        label: const Text('導航'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => context.push('/shuttles/${shuttle.id}'),
                        icon: const Icon(Icons.info_outline, size: 16),
                        label: const Text('查看詳情'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return AppColors.primary;
      case 'en route':
        return AppColors.warning;
      case 'arrived':
        return AppColors.success;
      case 'cancelled':
        return AppColors.statusCompleted;
      default:
        return AppColors.textSecondaryLight;
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return '已排程';
      case 'en route':
        return '行駛中';
      case 'arrived':
        return '已抵達';
      case 'cancelled':
        return '已取消';
      default:
        return status;
    }
  }

  String _formatTime(DateTime? time) {
    if (time == null) return '未設定時間';
    return '${time.month}月${time.day}日 ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
