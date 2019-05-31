# InjectorIO - Dependency Injection for Flutter

[![Pub](https://img.shields.io/pub/v/injectorio.svg?style=flat-square)](https://pub.dev/packages/injectorio)
[![support](https://img.shields.io/badge/platform-flutter%7Cdart%20vm-ff69b4.svg?style=flat-square)](https://github.com/pedromassango/injector_io)

Inject your dependencies easily and quickly. Register in one place and use `get()` everywhere to retrieve your instances and `InjectorIO` will take care of the rest.

## Features

- [x] Create singleton instances;
- [X] Create factory instances (recreated on every call);
- [x] Register instances using Module;
- [x] Get instances from anywhere using the `get()` function.
- [x] Logs printed while in DEBUG mode.
- [x] Easy to test.
- [x] Doesn't use reflection.
- [x] InjectorIO prevents you from keeping instances of classes that extends Widget.

## Core concepts
- **get()** => Used to resolve the instance of a registered class. This is what you will use most.
- **inject()** => Used to resolve a dependency inside a Module.
- **single()** => Used to register a singleton instance. You will receive a the same instance every time you use get().
- **factory()** => Used to register a factory instance. You will receive a new instance every time you use get().

NOTE: don't get confused with `get()` and `inject()`. Just remember this: If you are inside a Module and you want to resolve a dependency use `inject()`, but if you are not within a Module always use `get()`.

# Usage

### Basic Sample
Here is how you can easily use this package. Import this package and register your dependency instance, then in any part of your code use `get()` to resolve the registered instance.

``` dart

import 'package:injectorio/injectorio.dart';

void main(){
  InjectorIO.start()
  .single( CountriesRepository()); // register a instance

  runApp(MyApp());
}

class _MyHomePageState extends State<MyHomePage> {
  // This works
  // final CountriesRepository repository = get();

  CountriesRepository _repository;

  @override
  void initState() {
    super.initState();
    _repository = get(); // resolve the dependency
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```


### Register Dependencies

``` dart

import 'package:injectorio/injectorio.dart';

void main(){
  InjectorIO.start()
  .single( CountriesWebService())
  .factory( CountriesRepository( get()), ()=> CountriesRepository( get()));

  runApp(MyApp());
}
```


### Register Dependencies using Module

``` dart

import 'package:injectorio/injectorio.dart';

class CountriesWebService{}

class CountriesRepository{
  final CountriesWebService webService;
  CountriesRepository(this.webService);
}

class AppModule extends Module{
  AppModule(){
    single( CountriesWebService()); // register a singleton of CountriesWebService
    factory( CountriesRepository( inject())); // the library will take care of getting the instance of CountriesWebService
  }
}

void main(){
  InjectorIO.start()
  .module( AppModule());

  runApp(MyApp());
}
```


### Enable/Disable Logs
InjectorIO can also provide printed logs while in development mode. The function `InjectorIO.start()` receives a `InjectorMode` that can be:

- [X] DEBUG - Displays logs
- [X] PRODUCTION - Disables logs. You will not see logs from this package in the console.

The default value for this is DEBUG. If you don't want to see logs, just use production mode:

```dart
//...

InjectorIO.start(mode: InjectorMode.PRODUCTION)
.module( AppModule());

//...
```

## Help this Library

You can help/support by:

- [X] Reporting a Bug;
- [X] Making pull request;
- [X] Write a tutorial about this;
- [X] :heart: Staring this repository;
