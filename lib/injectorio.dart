library keeper;

import 'src/component_binder.dart' as IBinder;
export 'src/module_injector.dart' show Module;
export 'src/models.dart' show KeepMode;
export 'src/io.dart' show Keeper;

/// Resolve a dependency's instance
T get<T>() => IBinder.get<T>();