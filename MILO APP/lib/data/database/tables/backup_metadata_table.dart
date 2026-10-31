import 'package:drift/drift.dart';

@DataClassName('BackupMetadataData')
class BackupMetadatas extends Table {
  TextColumn get id => text()();
  TextColumn get provider => text()();
  DateTimeColumn get lastBackupAt => dateTime().nullable()();
  DateTimeColumn get lastSuccessfulSyncAt => dateTime().nullable()();
  TextColumn get syncStatus => text().withDefault(
    const Constant('idle'),
  )(); // 'idle', 'in_progress', 'success', 'failed'
  IntColumn get schemaVersion => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {id};
}
