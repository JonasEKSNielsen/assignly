import 'package:flutter/foundation.dart';

/// Notifier that increments when modules are created/changed so listeners
/// (like the calendar) can reload their data.
final ValueNotifier<int> modulesVersion = ValueNotifier<int>(0);

void notifyModulesChanged() {
  modulesVersion.value = modulesVersion.value + 1;
}
