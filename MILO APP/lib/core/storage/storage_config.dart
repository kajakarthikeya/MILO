import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Storage configuration ensuring compliance with the D: drive requirement
/// for development/desktop environments, and OS application sandbox for mobile runtimes.
class StorageConfig {
  static const String devDrive = 'D:';
  static const String devDataRoot = r'D:\FuelTrackerData';

  /// Override path for testing or custom configuration
  static String? _customStoragePath;

  static void setCustomStoragePath(String? path) {
    _customStoragePath = path;
  }

  /// Resolves the base directory for app data, local databases, and file exports.
  static Future<Directory> getBaseDirectory() async {
    if (_customStoragePath != null) {
      final dir = Directory(_customStoragePath!);
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
      return dir;
    }

    // Windows or Desktop Development / Unit Tests
    if (kIsWeb) {
      throw UnsupportedError('Web storage is not directly filesystem based.');
    }

    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      // Check if D: exists on Windows
      if (Platform.isWindows) {
        final driveDir = Directory(r'D:\');
        if (!await driveDir.exists()) {
          throw StateError(
            'CRITICAL STORAGE ERROR: Configured D: drive is unavailable. '
            'Please ensure the D: drive is mounted and accessible.',
          );
        }
      }

      final dir = Directory(devDataRoot);
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
      return dir;
    }

    // Mobile runtime: Android and iOS application sandbox
    final appDocDir = await getApplicationDocumentsDirectory();
    return appDocDir;
  }

  /// Directory for local SQLite databases
  static Future<String> getDatabasePath({
    String dbName = 'milo_fuel_tracker.db',
  }) async {
    final baseDir = await getBaseDirectory();
    final dbDir = Directory(p.join(baseDir.path, 'databases'));
    if (!await dbDir.exists()) {
      await dbDir.create(recursive: true);
    }
    return p.join(dbDir.path, dbName);
  }

  /// Directory for exported CSV and PDF reports
  static Future<Directory> getExportsDirectory() async {
    final baseDir = await getBaseDirectory();
    final exportDir = Directory(p.join(baseDir.path, 'exports'));
    if (!await exportDir.exists()) {
      await exportDir.create(recursive: true);
    }
    return exportDir;
  }

  /// Directory for local JSON/Data backups
  static Future<Directory> getBackupsDirectory() async {
    final baseDir = await getBaseDirectory();
    final backupDir = Directory(p.join(baseDir.path, 'backups'));
    if (!await backupDir.exists()) {
      await backupDir.create(recursive: true);
    }
    return backupDir;
  }
}
