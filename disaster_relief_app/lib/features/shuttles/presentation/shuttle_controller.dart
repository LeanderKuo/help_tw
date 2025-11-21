import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/shuttle_model.dart';
import '../data/shuttle_repository.dart';

final shuttleControllerProvider =
    StateNotifierProvider<ShuttleController, AsyncValue<List<ShuttleModel>>>((
      ref,
    ) {
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

  Future<void> joinShuttle(
    String shuttleId, {
    String role = 'passenger',
    bool isVisible = true,
  }) async {
    await _repository.joinShuttle(shuttleId, role: role, isVisible: isVisible);
    await loadShuttles();
  }

  Future<void> leaveShuttle(String shuttleId) async {
    await _repository.leaveShuttle(shuttleId);
    await loadShuttles();
  }

  Future<ShuttleModel> createShuttle({
    required String title,
    String? description,
    required double originLat,
    required double originLng,
    required double destinationLat,
    required double destinationLng,
    required DateTime departAt,
    DateTime? arriveAt,
    required int seatsTotal,
    double? costPerSeat,
    String? originAddress,
    String? destinationAddress,
    String costType = 'free',
    String vehicleType = 'other',
    String? vehiclePlate,
    String? contactName,
    String? contactPhoneMasked,
    bool isPriority = false,
  }) async {
    final shuttle = await _repository.createShuttle(
      title: title,
      description: description,
      originLat: originLat,
      originLng: originLng,
      destinationLat: destinationLat,
      destinationLng: destinationLng,
      departAt: departAt,
      arriveAt: arriveAt,
      seatsTotal: seatsTotal,
      costPerSeat: costPerSeat,
      originAddress: originAddress,
      destinationAddress: destinationAddress,
      costType: costType,
      vehicleType: vehicleType,
      vehiclePlate: vehiclePlate,
      contactName: contactName,
      contactPhoneMasked: contactPhoneMasked,
      isPriority: isPriority,
    );
    await loadShuttles();
    return shuttle;
  }

  Future<ShuttleModel> updateShuttle({
    required String shuttleId,
    String? title,
    String? description,
    double? originLat,
    double? originLng,
    double? destinationLat,
    double? destinationLng,
    DateTime? departAt,
    DateTime? arriveAt,
    int? seatsTotal,
    double? costPerSeat,
    String? originAddress,
    String? destinationAddress,
    String? costType,
    String? vehicleType,
    String? vehiclePlate,
    String? contactName,
    String? contactPhoneMasked,
    bool? isPriority,
  }) async {
    final shuttle = await _repository.updateShuttle(
      shuttleId: shuttleId,
      title: title,
      description: description,
      originLat: originLat,
      originLng: originLng,
      destinationLat: destinationLat,
      destinationLng: destinationLng,
      departAt: departAt,
      arriveAt: arriveAt,
      seatsTotal: seatsTotal,
      costPerSeat: costPerSeat,
      originAddress: originAddress,
      destinationAddress: destinationAddress,
      costType: costType,
      vehicleType: vehicleType,
      vehiclePlate: vehiclePlate,
      contactName: contactName,
      contactPhoneMasked: contactPhoneMasked,
      isPriority: isPriority,
    );
    await loadShuttles();
    return shuttle;
  }

  Future<void> completeShuttle(String shuttleId) async {
    await _repository.completeShuttle(shuttleId);
    await loadShuttles();
  }

  Future<void> deleteShuttle(String shuttleId) async {
    await _repository.deleteShuttle(shuttleId);
    await loadShuttles();
  }

  Future<Set<String>> myJoinedShuttleIds() {
    return _repository.getJoinedShuttleIds();
  }
}
