library module_injector;

import 'dart:collection';
import 'models.dart';

abstract class Module {
  LinkedHashMap<Type, Definition> _moduleDef = LinkedHashMap.identity();

  void single<T>(T def) =>
      _moduleDef[T] = Definition<T>(Kind.SINGLE, () => def);
  void factory<T>(T def, DefBuilder<T> db) =>
      _moduleDef[T] = Definition<T>(Kind.FACTORY, db);

  /// Resolve a dependency's instance inside of a Module
  T inject<T>() => _moduleDef[T].type == Kind.SINGLE
      ? _moduleDef[T].instance
      : _moduleDef[T].creator();

  LinkedHashMap<Type, Definition> kDef() => _moduleDef;
}
