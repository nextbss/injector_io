library module_injector;

import 'package:injectorio/src/models.dart';
import 'package:injectorio/src/io.dart' show registry;

abstract class Module {
  List<Definition> _moduleDef = [];

  void single<T>(T def) => _moduleDef.add( Definition<T>(Kind.SINGLE, () => def));
  void factory<T>(T def) => _moduleDef.add( Definition(Kind.FACTORY, () => def));
  T get<T>() => registry.get<T>();

  List<Definition> mDef() => _moduleDef;
}