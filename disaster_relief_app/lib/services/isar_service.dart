import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/resource_point.dart';
import '../models/task_model.dart';
import '../models/shuttle_model.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    // Isar 3.x currently lacks web support; skip initialization on web.
    if (kIsWeb) {
      db = Future.error(
        UnsupportedError(
          'Isar 3.x has no web support yet. Web builds skip local caching.',
        ),
      );
    } else {
      db = openDB();
    }
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return Isar.open(
        [ResourcePointSchema, TaskModelSchema, ShuttleModelSchema],
        directory: dir.path,
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }
}
