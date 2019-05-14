library module_injector;

import 'dart:collection';
import 'package:injectorio/src/models.dart';

abstract class Module {
  LinkedHashMap<Type, Definition> _moduleDef = LinkedHashMap.identity();

  void mSingle<T>(T def) => _moduleDef[T] = Definition<T>(Kind.SINGLE, () => def);
  void mFactory<T>(T def, DefBuilder<T> db) => _moduleDef[T] = Definition<T>(Kind.FACTORY, db);
  T mGet<T>() => _moduleDef[T].type == Kind.SINGLE ? _moduleDef[T].instance : _moduleDef[T].creator();

  LinkedHashMap<Type, Definition> def() => _moduleDef;
}