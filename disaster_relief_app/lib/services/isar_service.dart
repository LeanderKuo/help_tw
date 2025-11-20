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
      if (kIsWeb) {
        // Web uses isar_web (IndexedDB); no directory needed.
        return Isar.open(
          schemas: [ResourcePointSchema, TaskModelSchema, ShuttleModelSchema],
          inspector: false,
        );
      } else {
        final dir = await getApplicationDocumentsDirectory();
        return Isar.open(
          schemas: [ResourcePointSchema, TaskModelSchema, ShuttleModelSchema],
          directory: dir.path,
          inspector: true,
        );
      }
    }
    return Future.value(Isar.getInstance());
  }
}
