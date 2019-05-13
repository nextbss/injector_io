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
        .register( single( A()));

    A a1 = get();
    A a2 = get();

    assert(a1 == a2);
  });

  test('factory Definition should return diferent instances', (){
    InjectorIO.start()
        .register( factory( A()));

    A b1 = get();
    b1.key = 1;
    A b2 = get();
    b2.key = 2;

    print("B1: ${b1.key} B2: ${b2.key}");

    assert(b1.key != b2.key);
    //assert(b1 != b2);
  });

  test('reuse class instace between Definitions', () {
    InjectorIO.start()
        .register( single( A()))
        .register( factory( B( get())));

    final A a = get();
    final B b = get();

    assert(a == b.a);
  });

  test('throw error if no instance found', () {
    InjectorIO.start()
        //.register( single( A()))
        .register( factory( B( get())));

    A a = get();
    final B b = get();

    throwsA(()=> a = get());
  });

}