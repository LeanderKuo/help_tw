import 'package:isar/isar.dart';

part 'pending_mutation.g.dart';

@Collection()
class PendingMutation {
  PendingMutation({
    required this.table,
    required this.payload,
    required this.createdAt,
  });

  @Id()
  int id = Isar.autoIncrement;
  late String table;
  late String payload;
  late DateTime createdAt;
}
