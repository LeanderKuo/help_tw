import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'shuttle_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../core/widgets/global_chrome.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/shuttle_model.dart';

class ShuttleListScreen extends ConsumerStatefulWidget {
  const ShuttleListScreen({super.key});

  @override
  ConsumerState<ShuttleListScreen> createState() => _ShuttleListScreenState();
}

class _ShuttleListScreenState extends ConsumerState<ShuttleListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();
  final _latController = TextEditingController();
  final _lngController = TextEditingController();

  String _searchQuery = '';
  String _costType = '全部費用';
  double _distanceKm = 25;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
    final shuttlesAsync = ref.watch(shuttleControllerProvider);
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
            _ShuttleHeader(),
            const SizedBox(height: 12),
            _buildControlPanel(),
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
                  final filtered = shuttles.where((s) {
                    final matchesSearch = _searchQuery.isEmpty ||
                        s.title.toLowerCase().contains(_searchQuery.toLowerCase());
                    final matchesCost =
                        _costType == '全部費用' || s.costType == _costType;
                    return matchesSearch && matchesCost;
                  }).toList();

                  final hosting = filtered
                      .where((s) => s.status != 'Arrived' && s.status != 'Cancelled')
                      .toList();
                  final joined =
                      filtered.where((s) => s.status == 'En Route').toList();
                  final completed = filtered
                      .where((s) => s.status == 'Arrived' || s.status == 'Cancelled')
                      .toList();

                  return TabBarView(
                    controller: _tabController,
                    children: [
                      _ShuttleListView(
                        shuttles: hosting,
                        emptyMessage: l10n.noShuttlesHosting,
                        l10n: l10n,
                      ),
                      _ShuttleListView(
                        shuttles: joined,
                        emptyMessage: l10n.noShuttlesJoined,
                        l10n: l10n,
                      ),
                      _ShuttleListView(
                        shuttles: completed,
                        emptyMessage: l10n.noShuttlesCompleted,
                        l10n: l10n,
                        isCompleted: true,
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

  Widget _buildControlPanel() {
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
                    onPressed: () {},
                    icon: const Icon(Icons.directions_bus),
                    label: const Text('發起班車'),
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
                    decoration: const InputDecoration(
                      hintText: '經度',
                      prefixIcon: Icon(Icons.place_outlined),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _latController,
                    decoration: const InputDecoration(
                      hintText: '緯度',
                      prefixIcon: Icon(Icons.place_outlined),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '搜尋班車、目的地或描述',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text(
                  '定位後可依距離 (0-100 公里) 篩選',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimaryLight,
                  ),
                ),
                const Spacer(),
                Text(
                  '${_distanceKm.toStringAsFixed(0)} km',
                  style: const TextStyle(color: AppColors.primary),
                ),
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
                    value: _costType,
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
                      '全部費用',
                      '免費',
                      '分攤油費',
                      '付費車',
                    ].map((value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() => _costType = value);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: '最新建立',
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
                      '出發時間',
                      '優先度',
                    ].map((value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
                    onChanged: (_) {},
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

class _ShuttleListView extends StatelessWidget {
  final List<ShuttleModel> shuttles;
  final String emptyMessage;
  final bool isCompleted;
  final AppLocalizations l10n;

  const _ShuttleListView({
    required this.shuttles,
    required this.emptyMessage,
    required this.l10n,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    if (shuttles.isEmpty) {
      return EmptyState(
        icon: Icons.directions_bus_outlined,
        title: emptyMessage,
        message: l10n.shuttleEmptyMessage,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: shuttles.length,
      itemBuilder: (context, index) {
        final shuttle = shuttles[index];
        return _ShuttleCard(
          shuttle: shuttle,
          isCompleted: isCompleted,
          l10n: l10n,
        );
      },
    );
  }
}

class _ShuttleCard extends StatelessWidget {
  final ShuttleModel shuttle;
  final bool isCompleted;
  final AppLocalizations l10n;

  const _ShuttleCard({
    required this.shuttle,
    required this.l10n,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    final startLabel = shuttle.originAddress ??
        (shuttle.routeStartLat != null && shuttle.routeStartLng != null
            ? '${shuttle.routeStartLat!.toStringAsFixed(4)}, ${shuttle.routeStartLng!.toStringAsFixed(4)}'
            : '起點未設定');
    final endLabel = shuttle.destinationAddress ??
        (shuttle.routeEndLat != null && shuttle.routeEndLng != null
            ? '${shuttle.routeEndLat!.toStringAsFixed(4)}, ${shuttle.routeEndLng!.toStringAsFixed(4)}'
            : '終點未設定');

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
                    label: _costLabel(shuttle.costType),
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    textColor: AppColors.primary,
                  ),
                  const Spacer(),
                  StatusChip(
                    label: _getStatusText(shuttle.status),
                    backgroundColor:
                        _getStatusColor(shuttle.status).withValues(alpha: 0.12),
                    textColor: _getStatusColor(shuttle.status),
                  ),
                ],
              ),
              const SizedBox(height: 10),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.route, color: AppColors.primary, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '起點：$startLabel',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondaryLight,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '終點：$endLabel',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16, color: AppColors.textSecondaryLight),
                  const SizedBox(width: 6),
                  Text(
                    _formatTime(shuttle.departureTime),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.people_outline,
                      size: 16, color: AppColors.textSecondaryLight),
                  const SizedBox(width: 6),
                  Text(
                    '${shuttle.seatsTaken}/${shuttle.capacity} 人',
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
                        onPressed: () {},
                        icon: const Icon(Icons.navigation, size: 16),
                        label: const Text('導航'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => context.push('/shuttles/${shuttle.id}'),
                        icon: const Icon(Icons.directions_bus, size: 16),
                        label: const Text('加入班車'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10),
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
      case 'open':
      case 'scheduled':
        return AppColors.primary;
      case 'in_progress':
      case 'en route':
        return AppColors.warning;
      case 'done':
      case 'arrived':
        return AppColors.success;
      case 'cancelled':
      case 'canceled':
        return AppColors.statusCompleted;
      default:
        return AppColors.textSecondaryLight;
    }
  }

  String _getStatusText(String status) {
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

  String _formatTime(DateTime? time) {
    if (time == null) return l10n.timeNotSet;
    return '${time.month}/${time.day} ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  String _costLabel(String? costType) {
    switch (costType?.toLowerCase()) {
      case 'free':
        return '免費';
      case '分攤油費':
      case 'share_gas':
        return '分攤油費';
      case 'paid':
        return '付費車';
      default:
        return '班車';
    }
  }
}

class _ShuttleHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'MY SHUTTLES',
            style: TextStyle(
              color: AppColors.primary,
              letterSpacing: 1.6,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4),
          Text(
            '我的班車',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimaryLight,
            ),
          ),
          SizedBox(height: 4),
          Text(
            '管理你發起或加入的班車，快速進行狀態更新與操作。',
            style: TextStyle(color: AppColors.textSecondaryLight),
          ),
        ],
      ),
    );
  }
}
