import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/user_profiles_table.dart';

part 'user_profile_dao.g.dart';

@DriftAccessor(tables: [UserProfiles])
class UserProfileDao extends DatabaseAccessor<AppDatabase>
    with _$UserProfileDaoMixin {
  UserProfileDao(super.db);

  Future<UserProfileData?> getProfile() {
    return select(userProfiles).getSingleOrNull();
  }

  Stream<UserProfileData?> watchProfile() {
    return select(userProfiles).watchSingleOrNull();
  }

  Future<int> upsertProfile(UserProfilesCompanion profile) {
    return into(userProfiles).insertOnConflictUpdate(profile);
  }
}
