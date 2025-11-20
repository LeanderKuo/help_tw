import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'resource_controller.dart';
import '../../../core/theme/app_colors.dart';
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
  String _selectedType = 'All';

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
        title: '救災資源整合平台',
        onNotificationTap: () {},
        onAvatarTap: () => context.push('/profile'),
      ),
      body: ResponsiveLayout(
        child: Column(
          children: [
            _ResourceHeader(),
            const SizedBox(height: 12),
            _buildMapView(context),
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
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                        _buildFilterChip('Shelter', AppColors.chipShelter, l10n),
                        const SizedBox(width: 8),
                        _buildFilterChip('Water', AppColors.chipWater, l10n),
                        const SizedBox(width: 8),
                        _buildFilterChip('Food', AppColors.chipFood, l10n),
                        const SizedBox(width: 8),
                        _buildFilterChip('Medical', AppColors.error, l10n),
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
                    if (!r.isActive) return false;
                    if (_searchQuery.isNotEmpty) {
                      return r.title
                          .toLowerCase()
                          .contains(_searchQuery.toLowerCase());
                    }
                    if (_selectedType != 'All') {
                      return r.type == _getTypeFromChip(_selectedType);
                    }
                    return true;
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

  Widget _buildMapView(BuildContext context) {
    return Padding(
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
                      label: '定位',
                      icon: Icons.my_location,
                      background: AppColors.primary.withValues(alpha: 0.1),
                      foreground: AppColors.primary,
                      onTap: () {},
                    ),
                    _pillButton(
                      label: '新增資源點',
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
                label: const Text('官方地圖'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withValues(alpha: 0.05),
                          AppColors.secondary.withValues(alpha: 0.05),
                        ],
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        '地圖模式預留區域',
                        style: TextStyle(color: AppColors.textSecondaryLight),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  top: 12,
                  child: Column(
                    children: [
                      _zoomButton(Icons.add),
                      const SizedBox(height: 8),
                      _zoomButton(Icons.remove),
                    ],
                  ),
                ),
                Positioned(
                  left: 12,
                  right: 12,
                  bottom: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.search, color: AppColors.textSecondaryLight),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '搜尋資源點或輸入地址',
                            style: TextStyle(color: AppColors.textSecondaryLight),
                          ),
                        ),
                        Text(
                          '篩選中',
                          style: TextStyle(color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pillButton({
    required String label,
    required IconData icon,
    required Color background,
    required Color foreground,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: foreground, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: foreground,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _zoomButton(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: AppColors.textPrimaryLight),
        onPressed: () {},
      ),
    );
  }

  Widget _buildFilterChip(String label, Color? color, AppLocalizations l10n) {
    final isSelected = _selectedType == label;
    return FilterChip(
      label: Text(_getTypeLabel(label, l10n)),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedType = selected ? label : 'All';
        });
      },
      backgroundColor: color?.withValues(alpha: 0.1) ?? AppColors.backgroundLight,
      selectedColor: color?.withValues(alpha: 0.3) ?? AppColors.primary.withValues(alpha: 0.2),
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primary : AppColors.textPrimaryLight,
        fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
      ),
    );
  }

  String _getTypeFromChip(String chip) {
    switch (chip) {
      case 'Shelter':
        return 'Shelter';
      case 'Water':
        return 'Water';
      case 'Food':
        return 'Food';
      case 'Medical':
        return 'Medical';
      default:
        return 'Other';
    }
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
        return l10n.resourceTypeAll;
      default:
        return l10n.resourceTypeOther;
    }
  }
}

class _ResourceCard extends StatelessWidget {
  final ResourcePoint resource;
  final AppLocalizations l10n;

  const _ResourceCard({required this.resource, required this.l10n});

  @override
  Widget build(BuildContext context) {
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
                    label: _getTypeLabel(resource.type),
                    backgroundColor: _getTypeColor(resource.type).withValues(alpha: 0.12),
                    textColor: _getTypeColor(resource.type),
                  ),
                  const Spacer(),
                  StatusChip(
                    label: resource.isActive ? l10n.activeStatus : l10n.inactiveStatus,
                    backgroundColor: resource.isActive
                        ? AppColors.success.withValues(alpha: 0.12)
                        : AppColors.statusCompleted.withValues(alpha: 0.12),
                    textColor:
                        resource.isActive ? AppColors.success : AppColors.statusCompleted,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('查看詳情'),
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
              if (resource.description != null && resource.description!.isNotEmpty) ...[
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
                children: (resource.tags.isEmpty ? ['基礎補給'] : resource.tags)
                    .map((tag) => Chip(
                          label: Text(
                            tag,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          backgroundColor: AppColors.backgroundLight,
                        ))
                    .toList(),
              ),
              const SizedBox(height: 10),
              _infoRow(Icons.location_on_outlined,
                  resource.address ?? '${resource.latitude.toStringAsFixed(4)}, ${resource.longitude.toStringAsFixed(4)}'),
              const SizedBox(height: 4),
              _infoRow(Icons.access_time, _formatDate(resource.updatedAt ?? resource.createdAt)),
              if (resource.expiresAt != null) ...[
                const SizedBox(height: 4),
                _infoRow(Icons.hourglass_bottom,
                    '到期：${_formatDate(resource.expiresAt)}'),
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

  // Used for future type-specific pin styling; ignore analyzer unused warning for now.
  // ignore: unused_element
  IconData _getIconForType(String type) {
    switch (type) {
      case 'Water':
        return Icons.water_drop;
      case 'Shelter':
        return Icons.home;
      case 'Medical':
        return Icons.local_hospital;
      case 'Food':
        return Icons.restaurant;
      default:
        return Icons.place;
    }
  }

  Color _getTypeColor(String type) {
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

  String _getTypeLabel(String type) {
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
            '資源點管理',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimaryLight,
            ),
          ),
          SizedBox(height: 4),
          Text(
            '切換地圖或列表模式，快速瀏覽、定位與管理資源點。',
            style: TextStyle(color: AppColors.textSecondaryLight),
          ),
        ],
      ),
    );
  }
}
