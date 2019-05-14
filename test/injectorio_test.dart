import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:injectorio/injectorio.dart';

class A{
  int key;
  A();
}

class B{
  final A a;
  int k;
  B(this.a);
}

class C{
  final A a;
  final B b;
  C(this.a, this.b);
}

class Cf{

}


void main() {

  test("single Definition should return same instance", (){
    InjectorIO.start()
        .register( single( A()))
        .register( single( B( get())));

    A a1 = get();
    A a2 = get();

    assert(a1 == a2);
  });

  test('factory Definition should return diferent instances', (){
    InjectorIO.start()
        .register( factory(()=> A()));

    A b1 = get();
    A b2 = get();
    A b3 = get();

    print("B1: ${b1.hashCode} B2: ${b2.hashCode} B3: ${b3.hashCode}");

    assert(b1.hashCode != b2.hashCode);
  });

  test('reuse class instace between Definitions', () {
    InjectorIO.start()
        .register( single( A()))
        .register( factory( ()=> B( get())));

    final A a = get();
    final B b = get();

    assert(a == b.a);
  });

  test('throw error if no instance found', () {
    InjectorIO.start()
        .register( factory( ()=> B( get())));

    throwsA(()=> get<A>());
  });

  test("throw if trying to register a Widget class", (){
    InjectorIO.start()
        .register( single( MyWidget()));
  });

}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container( );
  }
}
