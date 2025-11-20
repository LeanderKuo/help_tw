import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'resource_controller.dart';
import '../../../models/resource_point.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/common_widgets.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('COMMUNITY RESOURCES\nResource directory'),
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
                      onPressed: () => context.push('/resources/create'),
                      icon: const Icon(Icons.add),
                      label: const Text('Add resource'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search resources or locations',
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
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('All', null),
                        const SizedBox(width: 8),
                        _buildFilterChip('Shelter', AppColors.chipShelter),
                        const SizedBox(width: 8),
                        _buildFilterChip('Water', AppColors.chipWater),
                        const SizedBox(width: 8),
                        _buildFilterChip('Food', AppColors.chipClothes),
                        const SizedBox(width: 8),
                        _buildFilterChip('Medical', AppColors.error),
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
                      title: 'No resources found',
                      message: 'Try adjusting filters or add a resource.',
                      action: ElevatedButton.icon(
                        onPressed: () => context.push('/resources/create'),
                        icon: const Icon(Icons.add),
                        label: const Text('Add resource'),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: filteredResources.length,
                    itemBuilder: (context, index) {
                      final resource = filteredResources[index];
                      return _ResourceCard(resource: resource);
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => EmptyState(
                  icon: Icons.error_outline,
                  title: 'Load failed',
                  message: error.toString(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, Color? color) {
    final isSelected = _selectedType == label;
    return FilterChip(
      label: Text(label),
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
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
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
}

class _ResourceCard extends StatelessWidget {
  final ResourcePoint resource;

  const _ResourceCard({required this.resource});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: () {},
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
                      color: _getTypeColor(resource.type).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getIconForType(resource.type),
                      color: _getTypeColor(resource.type),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          resource.title,
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
                            color: resource.isActive
                                ? AppColors.success.withValues(alpha: 0.1)
                                : AppColors.statusCompleted.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                resource.isActive ? Icons.check_circle : Icons.cancel,
                                size: 12,
                                color: resource.isActive
                                    ? AppColors.success
                                    : AppColors.statusCompleted,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                resource.isActive ? 'Active' : 'Inactive',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: resource.isActive
                                      ? AppColors.success
                                      : AppColors.statusCompleted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  StatusChip(
                    label: _getTypeLabel(resource.type),
                    backgroundColor: _getTypeColor(resource.type),
                    textColor: Colors.white,
                  ),
                ],
              ),
              if (resource.description != null && resource.description!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  resource.description!,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondaryLight,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.location_on_outlined,
                      size: 16, color: AppColors.textSecondaryLight),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '${resource.latitude.toStringAsFixed(4)}, ${resource.longitude.toStringAsFixed(4)}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondaryLight,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.access_time,
                      size: 16, color: AppColors.textSecondaryLight),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(resource.updatedAt ?? resource.createdAt),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryLight,
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
        return 'Water';
      case 'Shelter':
        return 'Shelter';
      case 'Medical':
        return 'Medical';
      case 'Food':
        return 'Food';
      default:
        return 'Other';
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown';
    return 'Updated ${date.month}/${date.day} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
