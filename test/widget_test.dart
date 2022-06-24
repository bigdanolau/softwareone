// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:softwareone/data/repository/countries_repository_impl.dart';
import 'package:softwareone/domain/bloc/countries_bloc/countries_bloc.dart';

void main() {
  group('Bloc Tests', () {
    blocTest<CountriesBloc, CountriesState>(
      'Should emit CountriesComplete when GetCountriesEvent is added as event',
      build: () =>
          CountriesBloc(countriesRepository: CountriesRepositoryImpl()),
      act: (CountriesBloc bloc) => bloc.add(
        GetCountriesEvent(),
      ),
      expect: () => [isA<CountriesComplete>()],
    );
  });
}
