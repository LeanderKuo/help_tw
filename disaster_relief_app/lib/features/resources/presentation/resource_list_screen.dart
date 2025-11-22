import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import 'resource_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/navigation_utils.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../core/widgets/global_chrome.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/resource_point.dart';

class ResourceListScreen extends ConsumerStatefulWidget {
  const ResourceListScreen({super.key});

  @override
  ConsumerState<ResourceListScreen> createState() => _ResourceListScreenState();
}

class _ResourceListScreenState extends ConsumerState<ResourceListScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  final Set<String> _selectedTypes = {};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resourcesAsync = ref.watch(resourceControllerProvider);
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
            const _ResourceHeader(),
            const SizedBox(height: 12),
            resourcesAsync.maybeWhen(
              data: (resources) => _buildMapView(context, resources),
              orElse: () => const SizedBox(
                height: 220,
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: l10n.searchResourcesHint,
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                    onChanged: (value) => setState(() => _searchQuery = value),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('All', null, l10n),
                        const SizedBox(width: 8),
                        _buildFilterChip(
                          'Shelter',
                          AppColors.chipShelter,
                          l10n,
                        ),
                        const SizedBox(width: 8),
                        _buildFilterChip('Water', AppColors.chipWater, l10n),
                        const SizedBox(width: 8),
                        _buildFilterChip('Food', AppColors.chipFood, l10n),
                        const SizedBox(width: 8),
                        _buildFilterChip('Medical', AppColors.error, l10n),
                        const SizedBox(width: 8),
                        _buildFilterChip(
                          'Other',
                          AppColors.textSecondaryLight,
                          l10n,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: resourcesAsync.when(
                data: (resources) {
                  final filteredResources = resources.where((r) {
                    if (r.status.toLowerCase() != 'active') return false;
                    if (_searchQuery.isNotEmpty) {
                      return r.title.toLowerCase().contains(
                        _searchQuery.toLowerCase(),
                      );
                    }
                    if (_selectedTypes.isEmpty) return true;
                    return _selectedTypes.contains(_normalizeType(r.type));
                  }).toList();

                  if (filteredResources.isEmpty) {
                    return EmptyState(
                      icon: Icons.place_outlined,
                      title: l10n.noResourcesFound,
                      message: l10n.noResourcesMessage,
                      action: ElevatedButton.icon(
                        onPressed: () => context.push('/resources/create'),
                        icon: const Icon(Icons.add),
                        label: Text(l10n.addResource),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: filteredResources.length,
                    itemBuilder: (context, index) {
                      final resource = filteredResources[index];
                      return _ResourceCard(resource: resource, l10n: l10n);
                    },
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

  Widget _buildMapView(BuildContext context, List<ResourcePoint> resources) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _pillButton(
                        label: 'Locate me',
                        icon: Icons.my_location,
                        background: AppColors.primary.withValues(alpha: 0.1),
                        foreground: AppColors.primary,
                        onTap: () {},
                      ),
                      _pillButton(
                        label: 'Add resource',
                        icon: Icons.add_location_alt_outlined,
                        background: AppColors.secondary.withValues(alpha: 0.1),
                        foreground: AppColors.secondary,
                        onTap: () => context.push('/resources/create'),
                      ),
                    ],
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('Open map'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: resources.isNotEmpty
                        ? LatLng(
                            resources.first.latitude,
                            resources.first.longitude,
                          )
                        : const LatLng(25.0330, 121.5654),
                    zoom: 12,
                  ),
                  markers: resources
                      .take(30)
                      .map(
                        (r) => Marker(
                          markerId: MarkerId(r.id),
                          position: LatLng(r.latitude, r.longitude),
                          infoWindow: InfoWindow(title: r.title),
                        ),
                      )
                      .toSet(),
                  myLocationEnabled: false,
                  zoomControlsEnabled: false,
                  onTap: (_) => context.push('/map'),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _pillButton({
    required String label,
    required IconData icon,
    required Color background,
    required Color foreground,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: foreground),
        label: Text(
          label,
          style: TextStyle(color: foreground, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, Color? color, AppLocalizations l10n) {
    final isSelected = label == 'All'
        ? _selectedTypes.isEmpty
        : _selectedTypes.contains(label);
    return FilterChip(
      label: Text(_getTypeLabel(label, l10n)),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          if (label == 'All') {
            _selectedTypes.clear();
            return;
          }
          if (selected) {
            _selectedTypes.add(label);
          } else {
            _selectedTypes.remove(label);
          }
        });
      },
      backgroundColor:
          color?.withValues(alpha: 0.1) ?? AppColors.backgroundLight,
      selectedColor:
          color?.withValues(alpha: 0.3) ??
          AppColors.primary.withValues(alpha: 0.2),
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primary : AppColors.textPrimaryLight,
        fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
      ),
    );
  }

  String _getTypeLabel(String type, AppLocalizations l10n) {
    switch (type) {
      case 'Shelter':
        return l10n.resourceTypeShelter;
      case 'Water':
        return l10n.resourceTypeWater;
      case 'Food':
        return l10n.resourceTypeFood;
      case 'Medical':
        return l10n.resourceTypeMedical;
      case 'All':
        return 'All types';
      default:
        return l10n.resourceTypeOther;
    }
  }

  String _normalizeType(String raw) {
    if (raw.isEmpty) return 'Other';
    final lower = raw.toLowerCase();
    switch (lower) {
      case 'water':
        return 'Water';
      case 'shelter':
        return 'Shelter';
      case 'medical':
        return 'Medical';
      case 'food':
        return 'Food';
      default:
        return 'Other';
    }
  }
}

class _ResourceCard extends StatelessWidget {
  final ResourcePoint resource;
  final AppLocalizations l10n;

  const _ResourceCard({required this.resource, required this.l10n});

  Future<void> _navigate(BuildContext context) async {
    try {
      await launchGoogleMapsNavigation(
        lat: resource.latitude,
        lng: resource.longitude,
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Navigation failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isActive = resource.status.toLowerCase() == 'active';
    final categories =
        resource.categories.isEmpty ? const ['uncategorized'] : resource.categories;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  StatusChip(
                    label: _typeLabel(resource.type),
                    backgroundColor: _typeColor(
                      resource.type,
                    ).withValues(alpha: 0.12),
                    textColor: _typeColor(resource.type),
                  ),
                  const Spacer(),
                  StatusChip(
                    label:
                        isActive ? l10n.activeStatus : l10n.inactiveStatus,
                    backgroundColor: isActive
                        ? AppColors.success.withValues(alpha: 0.12)
                        : AppColors.statusCompleted.withValues(alpha: 0.12),
                    textColor:
                        isActive ? AppColors.success : AppColors.statusCompleted,
                  ),
                  IconButton(
                    onPressed: () => _navigate(context),
                    icon: const Icon(Icons.navigation_outlined),
                  ),
                  TextButton(
                    onPressed: () => context.push('/map'),
                    child: const Text('Details'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                resource.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimaryLight,
                ),
              ),
              if (resource.description != null &&
                  resource.description!.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  resource.description!,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondaryLight,
                  ),
                ),
              ],
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: categories
                    .map(
                      (tag) => Chip(
                        label: Text(
                          tag,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        backgroundColor: AppColors.backgroundLight,
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 10),
              _infoRow(
                Icons.location_on_outlined,
                resource.address ??
                    '${resource.latitude.toStringAsFixed(4)}, ${resource.longitude.toStringAsFixed(4)}',
              ),
              const SizedBox(height: 4),
              _infoRow(
                Icons.access_time,
                _formatDate(resource.updatedAt ?? resource.createdAt),
              ),
              if (resource.expiry != null) ...[
                const SizedBox(height: 4),
                _infoRow(
                  Icons.hourglass_bottom,
                  'Expires: ${_formatDate(resource.expiry)}',
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondaryLight),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondaryLight,
            ),
          ),
        ),
      ],
    );
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'Water':
        return AppColors.chipWater;
      case 'Shelter':
        return AppColors.chipShelter;
      case 'Medical':
        return AppColors.error;
      case 'Food':
        return AppColors.chipFood;
      default:
        return AppColors.textSecondaryLight;
    }
  }

  String _typeLabel(String type) {
    switch (type) {
      case 'Water':
        return l10n.resourceTypeWater;
      case 'Shelter':
        return l10n.resourceTypeShelter;
      case 'Medical':
        return l10n.resourceTypeMedical;
      case 'Food':
        return l10n.resourceTypeFood;
      default:
        return l10n.resourceTypeOther;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return l10n.unknownTime;
    final formatted = DateFormat('MM/dd HH:mm').format(date);
    return l10n.updatedAt(formatted);
  }
}

class _ResourceHeader extends StatelessWidget {
  const _ResourceHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'RESOURCE MANAGEMENT',
            style: TextStyle(
              color: AppColors.primary,
              letterSpacing: 1.4,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Resource points',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimaryLight,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Browse and manage supply locations quickly from map or list.',
            style: TextStyle(color: AppColors.textSecondaryLight),
          ),
        ],
      ),
    );
  }
}
