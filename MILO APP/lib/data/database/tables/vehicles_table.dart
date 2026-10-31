import 'package:drift/drift.dart';

@DataClassName('VehicleData')
class Vehicles extends Table {
  TextColumn get id => text()();
  TextColumn get nickname => text()();
  TextColumn get make => text()();
  TextColumn get model => text()();
  TextColumn get vehicleType =>
      text()(); // 'motorcycle', 'scooter', 'car', 'other'
  TextColumn get fuelType =>
      text()(); // 'petrol', 'diesel', 'cng', 'electric', 'hybrid'
  TextColumn get registrationLabel => text().nullable()();
  RealColumn get initialOdometerKm => real()();
  RealColumn get expectedMileageKmPerLitre => real().nullable()();
  RealColumn get tankCapacityLitres => real().nullable()();
  DateTimeColumn get purchaseDate => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
