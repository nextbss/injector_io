library injector_io;

import 'package:injectorio/src/component_binder.dart' as IBinder;
import 'package:injectorio/src/models.dart' show Definition;
import 'package:injectorio/src/models.dart';
export 'package:injectorio/src/module_injector.dart' show Module;
export 'package:injectorio/src/models.dart' show InjectorMode;
export 'package:injectorio/src/io.dart' show InjectorIO;

/// Register a singleton instance
Definition<T> single<T>(T def) => IBinder.single<T>(def);

/// Register a modifiable instance
Definition<T> factory<T>(T def, DefBuilder<T> db) => IBinder.factory<T>(def, db);

/// Resolve Instance
T get<T>() => IBinder.get<T>();