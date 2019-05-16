# InjectorIO - Dependency Injection for Flutter

Inject your dependencies easily and quickly. Register in one place and use `get()` everywhere to retrieve your instances and InjectorIO will take car of the rest.

## Features
- [x] Create singleton instances;
- [X] Create factory instances (recreated every time it is called);
- [x] Register instances using Module;
- [x] Get instances from everywhere using get() function.
- [x] Logs printed while in DEBUG mode.
- [x] Don't use reflection.

## Core concepts
- get() => Used to resolve the instance of a registered class. This is what you will use most.
- inject() => Used to resolve a dependency inside a Module.
- single() => Used to register a singleton instance. You will receive a the same instance every time you use get().
- factory() => Used to register a factory instance. You will receive a new instance every time you use get().

NOTE: don't get confused with `get()` and `inject()`. Just remember this: If you are inside a Module and you want to resolve a dependency use `inject()`, but if you are out of a Module and want to resolve a dependency always use `get()`.

# Usage

### Register Instances

``` dart

import 'package:injectorio/injectorio.dart';

void main(){
  InjectorIO.start()
  .single( CountriesWebService())
  .factory( CountriesRepository( get()), ()=> CountriesRepository( get()));

  runApp(MyApp());
}
```

### Enable/Disable Logs
We can also provide printed logs while in development mode. The function `InjectorIO.start()` receive a `InjectorMode` that can be:

- [X] DEBUG - we will show logs
- [X] PRODUCTION - we will disable logs. You will not see logs of this package in the console.

The default value for this is DEBUG. If you don't want to see logs, just use the production mode:

```dart
//...

InjectorIO.start(mode: InjectorMode.PRODUCTION)
.module( AppModule());

//...
```

### Register dependencies using Module

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

### Example 1 - Basic
Now that you added the package lets see how to use it easily.

``` dart

import 'package:injectorio/injectorio.dart';

void main(){
  InjectorIO.start()
  .single( CountriesRepository());

  runApp(MyApp());
}
```

In the example above we registered a singleton dependency instance of `CountriesRepository` class.

All ready! you can get your dependencies now by calling `get()` when you do so, the library will get the instance of that class registered previously.

``` dart

final repository = get<CountriesRepository>();
//or
CountriesRepository repository = get();

```
### Example 2 - Register Modules

Note that you can also use modules to register you  definitions. Check the example below:

``` dart

import 'package:injectorio/injectorio.dart';

class CountriesWebService{
  List<String> countries = [];
}

class CountriesRepository{
  final CountriesWebService webService;
  CountriesRepository(this.webService);


  List<String> getCountries() => webService.countries;
  String getCountryByIndex(int index) => webService.countries.elementAt(index);

  addCountry(String name) => webService.countries.add(name);
}

class AppModule extends Module{
  AppModule(){
    single(CountriesWebService()); // register a singleton of CountriesWebService
    single( CountriesRepository( inject())); // the library will take care of getting the instance of CountriesWebService
  }
}

void main(){
  InjectorIO.start()
  .module( AppModule()); // register your module

  runApp(MyApp());
}
```

After that you can now get your instances by using the `get()` function.

``` dart

class _MyHomePageState extends State<MyHomePage> {
  // This works
  //final CountriesRepository repository = get();
  CountriesRepository _repository;

  @override
  void initState() {
    super.initState();
    _repository = get(); // resolve the dependency
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: _repository.getCountries().map((name){
          return Text(name,);
        }).toList(),
      ),
    );
  }
}
```

## Help this Library

You can help or support by:

- [X] Reporting a Bug;
- [X] Making pull requests;
- [X] Write a tutorial about this;
- [X] :heart: Staring :heart: this repository;

#### :heart: Star the repo to support the project or :smile:[Follow Me](https://github.com/pedromassango).Thanks!

#### Follow me on Twitter: [![Twitter Follow](https://img.shields.io/twitter/follow/pedromassangom.svg?style=social&label=Follow)](https://twitter.com/pedromassangom)
