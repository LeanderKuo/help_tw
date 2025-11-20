import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/shuttle_model.dart';
import '../data/shuttle_repository.dart';

final shuttleControllerProvider =
    StateNotifierProvider<ShuttleController, AsyncValue<List<ShuttleModel>>>(
        (ref) {
  return ShuttleController(ref.watch(shuttleRepositoryProvider));
});

class ShuttleController extends StateNotifier<AsyncValue<List<ShuttleModel>>> {
  final ShuttleRepository _repository;

  ShuttleController(this._repository) : super(const AsyncValue.loading()) {
    loadShuttles();
  }

  Future<void> loadShuttles() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.getShuttles());
  }

  Future<void> joinShuttle(String shuttleId,
      {String role = 'passenger', bool isVisible = true}) async {
    await _repository.joinShuttle(shuttleId,
        role: role, isVisible: isVisible);
    await loadShuttles();
  }
}
