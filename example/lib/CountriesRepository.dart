
class CountriesRepository{
  List<String> countries = [];

  List<String> getCoutries() => countries;
  String getCountryByIndex(int index) => countries.elementAt(index);

  addCountry(String name) => countries.add(name);
}