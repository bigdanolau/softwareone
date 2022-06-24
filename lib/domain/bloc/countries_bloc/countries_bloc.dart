// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:softwareone/data/models/countries_model.dart';
import 'package:softwareone/data/models/token_model.dart';
import 'package:softwareone/data/repository/countries_repository_impl.dart';

part 'countries_event.dart';
part 'countries_state.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  final CountriesRepositoryImpl countriesRepository;
  CountriesBloc({
    required this.countriesRepository,
  }) : super(CountriesInitial()) {
    on<GetCountriesEvent>((event, emit) async {
      final TokenModel? getToken = await countriesRepository.getToken();
      if (getToken != null) {
        final List<CountriesModel> getCountries =
            await countriesRepository.getCountries(getToken);
        emit(
          CountriesComplete(getCountries),
        );
      } else {
        emit(
          CountriesComplete([]),
        );
      }
    });
  }
}
