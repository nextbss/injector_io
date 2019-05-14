import 'dart:math';

import 'package:flutter/material.dart';
import 'package:injectorio/keeper.dart';

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
    single( CountriesWebService()); // register a singleton of CountriesWebService
    single( CountriesRepository( get())); // the library will take care of getting the instance of CountriesWebService
  }
}

void main(){
  Keeper.start()
  .module( AppModule());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CountriesRepository _repository;

  @override
  void initState() {
    super.initState();

    _repository = get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _repository.getCountries().isEmpty ?
      Center( child: Text("Adicione Países!", style: TextStyle(fontSize: 24),),) :
      ListView(
        children: _repository.getCountries().map((name){
          return Container(
            height: 100,
              margin: EdgeInsets.all(8),
              color: Colors.primaries[_repository.getCountries().indexOf(name)],
              child: Text(name,),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _repository.addCountry(Colors.primaries[Random().nextInt(10)].toString());
          setState(() {});
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
