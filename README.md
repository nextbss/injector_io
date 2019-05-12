# Injector IO

Inject your dependencies easily and quickly.

## Features
- [x] Create singleton instances;
- [ ] Create factory instances (recreated every time it is called);
- [x] Register instances using Module;
- [x] Get instances from everywhere using get() function.

# Usage

### Example 1 - Basic
Now that you added the package lets see how to use it easily.

``` dart

import 'package:injectorio/injectorio.dart';

void main(){
  InjectorIO.start()
  .register( single( CountriesRepository()));

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
    single( CountriesRepository( get())); // the library will take care of getting the instance of CountriesWebService
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
  CountriesRepository _repository;

  @override
  void initState() {
    super.initState();
    _repository = get(); // resolve dependency in your initState()
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