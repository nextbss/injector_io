import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectorio/keeper.dart';


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

class MyModule extends Module{
  MyModule(){
    single(A());
    single(B( A()));
    single(C( A(), B( inject())));
  }
}


void main() {

  test("Define instances using Module", (){
    Keeper.start()
        .module( MyModule());
  });

  test("single Definition should return same instance", (){
    Keeper.start()
        .single( A())
        .single( B( get()));

    A a1 = get();
    A a2 = get();

    assert(a1 == a2);
  });

  test('factory Definition should return diferent instances', (){
    Keeper.start()
        .factory(()=> A());

    A b1 = get();
    A b2 = get();
    A b3 = get();

    print("B1: ${b1.hashCode} B2: ${b2.hashCode} B3: ${b3.hashCode}");

    assert(b1.hashCode != b2.hashCode);
  });

  test('reuse class instace between Definitions', () {
    Keeper.start()
        .single( A())
        .factory( ()=> B( get()));

    final A a = get();
    final B b = get();

    assert(a == b.a);
  });

  test('throw error if no instance found', () {
    Keeper.start()
        .factory( ()=> B( get()));

    throwsA(()=> get<A>());
  });

  test("throw if trying to register a Widget class", (){
    Keeper.start()
        .single( MyWidget());
  });

}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container( );
  }
}
