import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/resource_point.dart';
import '../data/resource_repository.dart';

final resourceControllerProvider =
    StateNotifierProvider<ResourceController, AsyncValue<List<ResourcePoint>>>(
        (ref) {
  return ResourceController(ref.watch(resourceRepositoryProvider));
});

class ResourceController extends StateNotifier<AsyncValue<List<ResourcePoint>>> {
  final ResourceRepository _repository;

  ResourceController(this._repository) : super(const AsyncValue.loading()) {
    loadResources();
  }

  Future<void> loadResources() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.getResources());
  }

  Future<void> addResource(ResourcePoint resource) async {
    // Optimistic update could be done here, but for now we'll just reload
    await _repository.createResourcePoint(resource);
    await loadResources();
  }
  
  void filterResources(String type) {
    // This would require keeping the full list in memory or re-fetching
    // For simplicity, let's just re-fetch or filter the current state if it's data
    state.whenData((resources) {
      if (type == 'All') {
        // We need the original list. 
        // Better pattern: separate provider for filter state.
        loadResources(); 
      } else {
        state = AsyncValue.data(
          resources.where((r) => r.type == type).toList(),
        );
      }
    });
  }
}
