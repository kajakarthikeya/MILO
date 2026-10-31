import 'package:drift/drift.dart';

import '../database/app_database.dart';

class ProfileRepository {
  final AppDatabase _db;
  static const String defaultProfileId = 'primary_user';

  ProfileRepository(this._db);

  Future<UserProfileData?> getProfile() {
    return _db.userProfileDao.getProfile();
  }

  Stream<UserProfileData?> watchProfile() {
    return _db.userProfileDao.watchProfile();
  }

  Future<void> saveProfile({
    String? displayName,
    String currencyCode = 'INR',
    String distanceUnit = 'km',
    String themePreference = 'system',
    bool onboardingCompleted = false,
  }) async {
    final existing = await _db.userProfileDao.getProfile();
    final now = DateTime.now();

    final companion = UserProfilesCompanion.insert(
      id: defaultProfileId,
      displayName: Value(displayName),
      currencyCode: Value(currencyCode),
      distanceUnit: Value(distanceUnit),
      themePreference: Value(themePreference),
      onboardingCompleted: Value(onboardingCompleted),
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );

    await _db.userProfileDao.upsertProfile(companion);
  }

  Future<void> setOnboardingCompleted(bool completed) async {
    final existing = await _db.userProfileDao.getProfile();
    await saveProfile(
      displayName: existing?.displayName,
      currencyCode: existing?.currencyCode ?? 'INR',
      distanceUnit: existing?.distanceUnit ?? 'km',
      themePreference: existing?.themePreference ?? 'system',
      onboardingCompleted: completed,
    );
  }
}
