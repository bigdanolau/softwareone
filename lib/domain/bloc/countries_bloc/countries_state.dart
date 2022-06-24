part of 'countries_bloc.dart';

abstract class CountriesState {}

class CountriesInitial extends CountriesState {}

class CountriesComplete extends CountriesState {
  final List<CountriesModel> countries;

  CountriesComplete(this.countries);
}
