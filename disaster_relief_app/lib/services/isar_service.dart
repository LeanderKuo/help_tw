import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/resource_point.dart';
import '../models/task_model.dart';
import '../models/shuttle_model.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      // On web there is no path_provider implementation; Isar stores data in IndexedDB.
      if (kIsWeb) {
        return Isar.open(
          [ResourcePointSchema, TaskModelSchema, ShuttleModelSchema],
          inspector: false,
        );
      } else {
        final dir = await getApplicationDocumentsDirectory();
        return Isar.open(
          [ResourcePointSchema, TaskModelSchema, ShuttleModelSchema],
          directory: dir.path,
          inspector: true,
        );
      }
    }
    return Future.value(Isar.getInstance());
  }
}
