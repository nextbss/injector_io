# Injector IO

Inject your dependencies easily and quickly.

## Features
- [x] Create singleton instances;
- [ ] Create factory instances (recreated every time it is called);
- [x] Register instances using Module;
- [x] Get instances from everywhere using get() function.

# Usage
To use this plugin, add `simple_injector` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

### Example 1
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

All ready! you can now get your dependency by calling `get()` when you do so, the library will get the instance of that class registered previously.

``` dart

final repository = get<CountriesRepository>();
//or
CountriesRepository repository = get();

```
