import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../core/auth/role.dart';
import '../../../core/auth/role_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/phone_masking.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/shuttle_model.dart';
import '../../../services/location_service.dart';
import 'shuttle_controller.dart';

class CreateShuttleScreen extends ConsumerStatefulWidget {
  const CreateShuttleScreen({super.key, this.shuttle, this.isEditing = false});

  final ShuttleModel? shuttle;
  final bool isEditing;

  @override
  ConsumerState<CreateShuttleScreen> createState() =>
      _CreateShuttleScreenState();
}

class _CreateShuttleScreenState extends ConsumerState<CreateShuttleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _originAddressController = TextEditingController();
  final _destinationAddressController = TextEditingController();
  final _contactNameController = TextEditingController();
  final _contactPhoneController = TextEditingController();
  final _vehiclePlateController = TextEditingController();
  final _costPerSeatController = TextEditingController();

  LatLng? _origin;
  LatLng? _destination;
  DateTime? _departAt;
  DateTime? _arriveAt;
  String _vehicleType = 'van';
  String _costType = 'free';
  int _seatsTotal = 4;
  bool _isPriority = false;
  bool _isSubmitting = false;
  bool _prefilledContact = false;

  @override
  void initState() {
    super.initState();
    // Prefill contact fields once profile is available.
    ref.listen(currentUserProfileProvider, (prev, next) {
      final profile = next.valueOrNull;
      if (!_prefilledContact && profile != null) {
        _contactNameController.text =
            profile.fullName ?? profile.nickname ?? profile.email;
        if (profile.maskedPhone != null &&
            profile.maskedPhone!.isNotEmpty &&
            _contactPhoneController.text.isEmpty) {
          _contactPhoneController.text = profile.maskedPhone!;
        }
        _prefilledContact = true;
      }
    });
    _prefillFromShuttle();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _originAddressController.dispose();
    _destinationAddressController.dispose();
    _contactNameController.dispose();
    _contactPhoneController.dispose();
    _vehiclePlateController.dispose();
    _costPerSeatController.dispose();
    super.dispose();
  }

  AppLocalizations get _l10n => AppLocalizations.of(context)!;

  void _prefillFromShuttle() {
    final shuttle = widget.shuttle;
    if (shuttle == null) return;

    _titleController.text = shuttle.title;
    if (shuttle.description != null) {
      _descriptionController.text = shuttle.description!;
    }
    _originAddressController.text = shuttle.originAddress ?? '';
    _destinationAddressController.text = shuttle.destinationAddress ?? '';
    if (shuttle.routeStartLat != null && shuttle.routeStartLng != null) {
      _origin = LatLng(shuttle.routeStartLat!, shuttle.routeStartLng!);
    }
    if (shuttle.routeEndLat != null && shuttle.routeEndLng != null) {
      _destination = LatLng(shuttle.routeEndLat!, shuttle.routeEndLng!);
    }
    _departAt = shuttle.departureTime;
    _arriveAt = shuttle.signupDeadline ?? _arriveAt;
    _seatsTotal = shuttle.capacity > 0 ? shuttle.capacity : _seatsTotal;
    _costType = shuttle.costType;
    if (shuttle.farePerPerson != null) {
      _costPerSeatController.text = shuttle.farePerPerson!.toString();
    }
  }

  Future<void> _pickLocation({required bool isOrigin}) async {
    final initialPosition = isOrigin ? _origin : _destination;
    final userPosition = await LocationService.currentPosition();
    if (!mounted) return;
    final defaultLatLng =
        initialPosition ??
        (userPosition != null
            ? LatLng(userPosition.latitude, userPosition.longitude)
            : const LatLng(25.0330, 121.5654));

    final selected = await showModalBottomSheet<LatLng>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        LatLng tempSelection = defaultLatLng;
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: Column(
              children: [
                const SizedBox(height: 12),
                Text(
                  isOrigin ? 'Select origin' : 'Select destination',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: StatefulBuilder(
                    builder: (context, setModalState) {
                      return GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: defaultLatLng,
                          zoom: 14,
                        ),
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        onTap: (pos) {
                          setModalState(() => tempSelection = pos);
                        },
                        markers: {
                          Marker(
                            markerId: const MarkerId('selection'),
                            position: tempSelection,
                          ),
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${tempSelection.latitude.toStringAsFixed(5)}, ${tempSelection.longitude.toStringAsFixed(5)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimaryLight,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: () =>
                            Navigator.of(context).pop(tempSelection),
                        icon: const Icon(Icons.check),
                        label: const Text('Use this point'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (selected != null) {
      setState(() {
        if (isOrigin) {
          _origin = selected;
        } else {
          _destination = selected;
        }
      });
      unawaited(_reverseGeocode(selected, isOrigin: isOrigin));
    }
  }

  Future<void> _reverseGeocode(LatLng point, {required bool isOrigin}) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        point.latitude,
        point.longitude,
      );
      if (placemarks.isEmpty) return;
      if (!mounted) return;
      final place = placemarks.first;
      final address =
          '${place.street ?? ''} ${place.locality ?? ''} ${place.administrativeArea ?? ''}';
      setState(() {
        if (isOrigin) {
          _originAddressController.text = address.trim();
        } else {
          _destinationAddressController.text = address.trim();
        }
      });
    } catch (_) {
      // Ignore geocode failures; user can type manually.
    }
  }

  Future<void> _searchAddress({required bool isOrigin}) async {
    final controller = isOrigin
        ? _originAddressController
        : _destinationAddressController;
    final query = controller.text.trim();
    if (query.isEmpty) return;

    try {
      final locations = await locationFromAddress(query);
      if (locations.isEmpty) {
        _showMessage('No results for that address');
        return;
      }
      if (!mounted) return;
      final result = locations.first;
      final latLng = LatLng(result.latitude, result.longitude);
      setState(() {
        if (isOrigin) {
          _origin = latLng;
        } else {
          _destination = latLng;
        }
      });
      _showMessage('Location pinned on map');
    } catch (e) {
      _showMessage('Address lookup failed: $e');
    }
  }

  Future<void> _useCurrentLocation({required bool isOrigin}) async {
    final position = await LocationService.currentPosition();
    if (position == null) {
      _showMessage('Unable to get current location');
      return;
    }
    if (!mounted) return;
    final latLng = LatLng(position.latitude, position.longitude);
    setState(() {
      if (isOrigin) {
        _origin = latLng;
      } else {
        _destination = latLng;
      }
    });
    unawaited(_reverseGeocode(latLng, isOrigin: isOrigin));
  }

  Future<void> _pickDateTime({required bool isDeparture}) async {
    final base = isDeparture ? _departAt : _arriveAt;
    final date = await showDatePicker(
      context: context,
      initialDate: base ?? DateTime.now().add(const Duration(hours: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: base != null
          ? TimeOfDay.fromDateTime(base)
          : TimeOfDay.now(),
    );
    if (time == null) return;

    final combined = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() {
      if (isDeparture) {
        _departAt = combined;
      } else {
        _arriveAt = combined;
      }
    });
  }

  Future<void> _submit() async {
    final role = ref.read(currentUserRoleProvider).valueOrNull ?? AppRole.user;
    final isEditing = widget.isEditing && widget.shuttle != null;
    final canSetPriority = role.isLeaderOrAbove;

    if (!role.isAuthenticated) {
      _showMessage('Please sign in to manage shuttles.');
      return;
    }
    if (!_formKey.currentState!.validate()) return;

    final origin = _origin;
    final destination = _destination;

    if (origin == null || destination == null) {
      _showMessage('Select both origin and destination points.');
      return;
    }
    if (_departAt == null) {
      _showMessage('Set a departure time.');
      return;
    }
    if (_departAt!.isBefore(DateTime.now())) {
      _showMessage('Departure time must be in the future.');
      return;
    }
    if (_arriveAt != null && _arriveAt!.isBefore(_departAt!)) {
      _showMessage('Arrival time must be after departure.');
      return;
    }

    final costPerSeat = double.tryParse(_costPerSeatController.text);
    final contactName = _contactNameController.text.trim();
    final contactPhoneMasked = _contactPhoneController.text.trim().isNotEmpty
        ? maskPhone(_contactPhoneController.text.trim())
        : null;
    final priorityValue = canSetPriority ? _isPriority : null;

    setState(() => _isSubmitting = true);
    try {
      if (isEditing) {
        await ref
            .read(shuttleControllerProvider.notifier)
            .updateShuttle(
              shuttleId: widget.shuttle!.id,
              title: _titleController.text.trim(),
              description: _descriptionController.text.trim().isEmpty
                  ? null
                  : _descriptionController.text.trim(),
              originLat: origin.latitude,
              originLng: origin.longitude,
              destinationLat: destination.latitude,
              destinationLng: destination.longitude,
              departAt: _departAt,
              arriveAt: _arriveAt,
              seatsTotal: _seatsTotal,
              costPerSeat: costPerSeat,
              originAddress: _originAddressController.text.trim().isEmpty
                  ? null
                  : _originAddressController.text.trim(),
              destinationAddress:
                  _destinationAddressController.text.trim().isEmpty
                  ? null
                  : _destinationAddressController.text.trim(),
              costType: _costType,
              vehicleType: _vehicleType,
              vehiclePlate: _vehiclePlateController.text.trim(),
              contactName: contactName.isEmpty ? null : contactName,
              contactPhoneMasked: contactPhoneMasked,
              isPriority: priorityValue,
            );
      } else {
        await ref
            .read(shuttleControllerProvider.notifier)
            .createShuttle(
              title: _titleController.text.trim(),
              description: _descriptionController.text.trim().isEmpty
                  ? null
                  : _descriptionController.text.trim(),
              originLat: origin.latitude,
              originLng: origin.longitude,
              destinationLat: destination.latitude,
              destinationLng: destination.longitude,
              departAt: _departAt!,
              arriveAt: _arriveAt,
              seatsTotal: _seatsTotal,
              costPerSeat: costPerSeat,
              originAddress: _originAddressController.text.trim().isEmpty
                  ? null
                  : _originAddressController.text.trim(),
              destinationAddress:
                  _destinationAddressController.text.trim().isEmpty
                  ? null
                  : _destinationAddressController.text.trim(),
              costType: _costType,
              vehicleType: _vehicleType,
              vehiclePlate: _vehiclePlateController.text.trim(),
              contactName: contactName.isEmpty ? null : contactName,
              contactPhoneMasked: contactPhoneMasked,
              isPriority: priorityValue ?? false,
            );
      }
      if (!mounted) return;
      _showMessage(
        isEditing ? 'Shuttle updated' : 'Shuttle created and joined as driver',
        isError: false,
      );
      context.pop();
    } catch (e) {
      _showMessage('Failed to save shuttle: $e');
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  void _showMessage(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.redAccent : Colors.green,
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildLocationBlock({
    required String title,
    required LatLng? value,
    required TextEditingController controller,
    required VoidCallback onPick,
    required VoidCallback onUseCurrent,
    required VoidCallback onSearchAddress,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryLight,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            OutlinedButton.icon(
              onPressed: onPick,
              icon: const Icon(Icons.map_outlined),
              label: const Text('Map pick'),
            ),
            OutlinedButton.icon(
              onPressed: onUseCurrent,
              icon: const Icon(Icons.my_location),
              label: const Text('Use current'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: 'Address',
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: onSearchAddress,
            ),
          ),
          maxLines: 2,
        ),
        const SizedBox(height: 6),
        Text(
          value != null
              ? '${value.latitude.toStringAsFixed(5)}, ${value.longitude.toStringAsFixed(5)}'
              : 'No point selected',
          style: TextStyle(
            color: value != null
                ? AppColors.textSecondaryLight
                : Colors.red.shade700,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final role = ref.watch(currentUserRoleProvider).valueOrNull ?? AppRole.user;
    final canSetPriority = role.isLeaderOrAbove;
    final pageTitle = widget.isEditing ? 'Edit shuttle' : _l10n.createShuttle;

    return Scaffold(
      appBar: AppBar(title: Text(pageTitle)),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildSection('Basic info', [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    maxLength: 100,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Title is required';
                      }
                      if (value.trim().length > 100) {
                        return 'Title must be under 100 characters';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    maxLength: 500,
                    maxLines: 3,
                  ),
                ]),
                _buildSection('Locations', [
                  _buildLocationBlock(
                    title: 'Origin',
                    value: _origin,
                    controller: _originAddressController,
                    onPick: () => _pickLocation(isOrigin: true),
                    onUseCurrent: () => _useCurrentLocation(isOrigin: true),
                    onSearchAddress: () => _searchAddress(isOrigin: true),
                  ),
                  const Divider(height: 24),
                  _buildLocationBlock(
                    title: 'Destination',
                    value: _destination,
                    controller: _destinationAddressController,
                    onPick: () => _pickLocation(isOrigin: false),
                    onUseCurrent: () => _useCurrentLocation(isOrigin: false),
                    onSearchAddress: () => _searchAddress(isOrigin: false),
                  ),
                ]),
                _buildSection('Schedule', [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Departure time *'),
                    subtitle: Text(
                      _departAt != null
                          ? _departAt!.toString()
                          : 'Select a future time',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.calendar_month),
                      onPressed: () => _pickDateTime(isDeparture: true),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Arrival time (optional)'),
                    subtitle: Text(
                      _arriveAt != null
                          ? _arriveAt!.toString()
                          : 'Select arrival (after departure)',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.schedule),
                      onPressed: () => _pickDateTime(isDeparture: false),
                    ),
                  ),
                ]),
                _buildSection('Seats & cost', [
                  TextFormField(
                    initialValue: _seatsTotal.toString(),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Total seats (1-100)',
                    ),
                    onChanged: (value) {
                      final parsed = int.tryParse(value);
                      if (parsed != null) {
                        _seatsTotal = parsed.clamp(1, 100);
                      }
                    },
                    validator: (value) {
                      final parsed = int.tryParse(value ?? '');
                      if (parsed == null || parsed < 1) {
                        return 'Seats required (>=1)';
                      }
                      if (parsed > 100) {
                        return 'Max 100 seats';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: _costType,
                    decoration: const InputDecoration(labelText: 'Cost type'),
                    items: const [
                      DropdownMenuItem(value: 'free', child: Text('Free')),
                      DropdownMenuItem(
                        value: 'share_gas',
                        child: Text('Share gas'),
                      ),
                      DropdownMenuItem(
                        value: 'paid',
                        child: Text('Paid per seat'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) setState(() => _costType = value);
                    },
                  ),
                  TextFormField(
                    controller: _costPerSeatController,
                    decoration: const InputDecoration(
                      labelText: 'Cost per seat (optional)',
                      prefixText: '\$',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                ]),
                _buildSection('Vehicle & contact', [
                  DropdownButtonFormField<String>(
                    value: _vehicleType,
                    decoration: const InputDecoration(
                      labelText: 'Vehicle type',
                    ),
                    items: const [
                      DropdownMenuItem(value: 'van', child: Text('Van')),
                      DropdownMenuItem(value: 'bus', child: Text('Bus')),
                      DropdownMenuItem(value: 'truck', child: Text('Truck')),
                      DropdownMenuItem(value: 'other', child: Text('Other')),
                    ],
                    onChanged: (value) {
                      if (value != null) setState(() => _vehicleType = value);
                    },
                  ),
                  TextFormField(
                    controller: _vehiclePlateController,
                    decoration: const InputDecoration(
                      labelText: 'Plate number',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _contactNameController,
                    decoration: const InputDecoration(
                      labelText: 'Contact name',
                    ),
                  ),
                  TextFormField(
                    controller: _contactPhoneController,
                    decoration: const InputDecoration(
                      labelText: 'Contact phone (masked in public view)',
                    ),
                  ),
                ]),
                _buildSection('Visibility & priority', [
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Mark as priority'),
                    subtitle: Text(
                      canSetPriority
                          ? 'Leader+ can flag priority to surface on lists'
                          : 'Only Leader+ can toggle priority',
                    ),
                    value: _isPriority,
                    onChanged: canSetPriority
                        ? (value) => setState(() => _isPriority = value)
                        : null,
                  ),
                ]),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: _isSubmitting
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.check),
                    label: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        _isSubmitting
                            ? (widget.isEditing
                                  ? 'Updating...'
                                  : 'Submitting...')
                            : (widget.isEditing ? 'Update' : 'Create'),
                      ),
                    ),
                    onPressed: _isSubmitting ? null : _submit,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
