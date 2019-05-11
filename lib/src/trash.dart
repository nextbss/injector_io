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
 *//*


library activator;

import 'tt.dart';
import 'bean_registry.dart' show registry;

class Activator {
  static createInstance(Type type, [Symbol constructor, List
  arguments, Map<Symbol, dynamic> namedArguments]) {

    if (type == null) {
      throw new ArgumentError("type is null: $type");
    }

    if (constructor == null) {
      constructor = const Symbol("");
    }

    if (arguments == null) {
      arguments = const [];
    }

    var typeMirror = reflectType(type);
    if (typeMirror is ClassMirror) {
      try {
        return typeMirror
            .newInstance(constructor, arguments,
            namedArguments)
            .reflectee;
      }catch(e){
        final c = getConstructor(typeMirror);
        return typeMirror
            .newInstance( c.constructorName,
            c.parameters.map((pm)=> tryGetInstance(pm)).toList(),
            namedArguments)
            .reflectee;
      }
    } else {
      throw new ArgumentError("Cannot create the instance of the type '$type'.");
    }
  }

  static Object tryGetInstance(ParameterMirror m){
    try{
      print("parameter lookup: ${m.type.reflectedType}");
      return registry.getBy(m.type.reflectedType);
    }catch(e){
      return null;
    }
  }

  static MethodMirror getConstructor<T>(ClassMirror typeMirror){
    MethodMirror sr;
    typeMirror.declarations.forEach((s, d){
      if(d is MethodMirror && d.isConstructor){
        sr = d;
      }
    });
    return sr;
  }
}*/
