import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'shuttle_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/navigation_utils.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../core/widgets/global_chrome.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/shuttle_model.dart';
import '../../../services/location_service.dart';

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
  String _costType = 'All costs';
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

  Future<void> _fillWithCurrentLocation() async {
    final position = await LocationService.currentPosition();
    if (!mounted) return;
    if (position == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to fetch location. Please enable permissions and location services.',
          ),
        ),
      );
      return;
    }
    setState(() {
      _latController.text = position.latitude.toStringAsFixed(5);
      _lngController.text = position.longitude.toStringAsFixed(5);
    });
  }

  Future<void> _openCreateShuttle() async {
    await context.push('/shuttles/create');
    if (!mounted) return;
    await ref.read(shuttleControllerProvider.notifier).loadShuttles();
  }

  @override
  Widget build(BuildContext context) {
    final shuttlesAsync = ref.watch(shuttleControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: GlobalTopNavBar(
        title: l10n.appTitle,
        onNotificationTap: () => context.push('/announcements'),
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
                Tab(text: 'Hosting'),
                Tab(text: 'Joined'),
                Tab(text: 'History'),
              ],
            ),
            Expanded(
              child: shuttlesAsync.when(
                data: (shuttles) {
                  final filtered = shuttles.where((s) {
                    final matchesSearch =
                        _searchQuery.isEmpty ||
                        s.title.toLowerCase().contains(
                          _searchQuery.toLowerCase(),
                        );
                    final matchesCost =
                        _costType == 'All costs' || s.costType == _costType;
                    return matchesSearch && matchesCost;
                  }).toList();

                  final hosting = filtered
                      .where(
                        (s) =>
                            s.status != 'done' &&
                            s.status != 'canceled' &&
                            s.status.toLowerCase() != 'arrived',
                      )
                      .toList();
                  final joined = filtered
                      .where(
                        (s) =>
                            s.status.toLowerCase() == 'in_progress' ||
                            s.status.toLowerCase() == 'en route',
                      )
                      .toList();
                  final completed = filtered
                      .where(
                        (s) =>
                            s.status.toLowerCase() == 'done' ||
                            s.status.toLowerCase() == 'canceled',
                      )
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
                    onPressed: _openCreateShuttle,
                    icon: const Icon(Icons.directions_bus),
                    label: const Text('Create shuttle'),
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
                    onPressed: _fillWithCurrentLocation,
                    icon: const Icon(Icons.my_location),
                    label: const Text('Use my location'),
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
                      hintText: 'Longitude',
                      prefixIcon: Icon(Icons.place_outlined),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _latController,
                    decoration: const InputDecoration(
                      hintText: 'Latitude',
                      prefixIcon: Icon(Icons.place_outlined),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search shuttles',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (v) => setState(() => _searchQuery = v),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  'Distance 0-100 km',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(width: 8),
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
                    items: const ['All costs', 'free', 'share_gas', 'paid']
                        .map(
                          (cost) =>
                              DropdownMenuItem(value: cost, child: Text(cost)),
                        )
                        .toList(),
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() => _costType = v);
                    },
                    decoration: const InputDecoration(labelText: 'Cost type'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () => context.push('/shuttles/my'),
                icon: const Icon(Icons.assignment_ind_outlined),
                label: const Text('My shuttles'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShuttleListView extends StatelessWidget {
  const _ShuttleListView({
    required this.shuttles,
    required this.emptyMessage,
    required this.l10n,
    this.isCompleted = false,
  });

  final List<ShuttleModel> shuttles;
  final String emptyMessage;
  final AppLocalizations l10n;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    if (shuttles.isEmpty) {
      return EmptyState(
        icon: Icons.directions_bus_outlined,
        title: emptyMessage,
        message: isCompleted
            ? l10n.noShuttlesCompleted
            : l10n.noShuttlesHosting,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: shuttles.length,
      itemBuilder: (context, index) {
        final shuttle = shuttles[index];
        return _ShuttleCard(shuttle: shuttle, l10n: l10n);
      },
    );
  }
}

class _ShuttleCard extends StatelessWidget {
  const _ShuttleCard({required this.shuttle, required this.l10n});

  final ShuttleModel shuttle;
  final AppLocalizations l10n;

  int get remainingSeats =>
      (shuttle.capacity - shuttle.seatsTaken).clamp(0, shuttle.capacity);

  Future<void> _navigate(BuildContext context) async {
    final targetLat = shuttle.routeEndLat ?? shuttle.routeStartLat;
    final targetLng = shuttle.routeEndLng ?? shuttle.routeStartLng;
    if (targetLat == null || targetLng == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No coordinates available for navigation'),
        ),
      );
      return;
    }
    try {
      await launchGoogleMapsNavigation(lat: targetLat, lng: targetLng);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Navigation failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                    textColor: AppColors.primary,
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
                      icon: Icons.place,
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
                    label: 'Seats: ${shuttle.seatsTaken}/${shuttle.capacity}',
                  ),
                  const SizedBox(width: 8),
                  _infoChip(
                    icon: Icons.access_time,
                    label: shuttle.signupDeadline != null
                        ? 'Deadline: ${_formatDate(shuttle.signupDeadline)}'
                        : 'No deadline',
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _navigate(context),
                      icon: const Icon(Icons.navigation, size: 18),
                      label: const Text('Navigate'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => context.push('/shuttles/${shuttle.id}'),
                      icon: const Icon(Icons.info_outline, size: 18),
                      label: const Text('Details'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
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
}

class _ShuttleHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SHUTTLE DISPATCH',
            style: TextStyle(
              color: AppColors.primary.withValues(alpha: 0.8),
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Coordinate transport routes, seats, and pickup points.',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimaryLight,
            ),
          ),
        ],
      ),
    );
  }
}
