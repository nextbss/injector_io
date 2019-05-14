library injector_io;

import 'package:injectorio/src/component_binder.dart' as IBinder;
export 'package:injectorio/src/module_injector.dart' show Module;
export 'package:injectorio/src/models.dart' show InjectorMode;
export 'package:injectorio/src/io.dart' show InjectorIO;

/// Resolve Instance
T get<T>() => IBinder.get<T>();