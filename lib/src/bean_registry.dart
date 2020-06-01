/*
 * Copyright 2019 Pedro Massango.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

library bean_registry;

import 'dart:collection';
import 'package:flutter/material.dart';

import 'models.dart';
import 'package:logger/logger.dart';

class DefinitionRegistry {
  DefinitionRegistry._internal(this.mode);
  final LinkedHashMap<Type, Definition> _kInstances = LinkedHashMap();
  factory DefinitionRegistry.build(InjectorMode mode) {
    return DefinitionRegistry._internal(mode);
  }

  final InjectorMode mode;

  var logger = Logger(
  printer: PrettyPrinter(),
);

  void register(Definition def) {
    if (def.instance is Widget) {
      throw UnsupportedError("Class of type Widget are not supported.");
    }

    switch (def.type) {
      case Kind.FACTORY:
        _showCreateFactory(def.instance);
        _kInstances[def.instance.runtimeType] = def;
        break;
      case Kind.SINGLE:
        _showCreateSingle(def.instance);
        _kInstances[def.instance.runtimeType] = def;
        break;
    }
  }

  T get<T>() {
    try {
      return _getInstance(T);
    } catch (e) {
      _showInstanceNotFound(T);
      throw _instanceNotFoundException(T);
    }
  }

  T _getInstance<T>(T) {
    if (_kInstances.containsKey(T)) {
      if (_kInstances[T].type == Kind.SINGLE) {
        _showGetSingleInstance(T);
        return _kInstances[T].instance;
      }

      _showGetFactoryInstance(T);
      return _kInstances[T].creator();
    }

    throw _instanceNotFoundException(T);
  }

  Exception _instanceNotFoundException(T) =>
      Exception("""Instance of $T not found. Make sure you added
        it by using module or with [single()], [factory()] definition.""");

  _log(String m) {
    if (mode == InjectorMode.DEBUG) logger.d("InjectorIO:::\t$m");
  }

  _showCreateSingle(Object t) => _log("+++ Register single\t${t.runtimeType}");
  _showCreateFactory(Object t) => _log("+++ Register factory ${t.runtimeType}");
  _showGetFactoryInstance(Object t) => _log("--- Get Factory $t");
  _showGetSingleInstance(Object t) => _log("--- Get Single\t$t");
  _showInstanceNotFound(Object t) =>
      _log("!!!--- Instance of type $t not found ---!!!");
}
