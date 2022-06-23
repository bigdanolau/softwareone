import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softwareone/data/models/token_model.dart';
import 'package:softwareone/domain/repository/countries_repository.dart';

part 'countries_event.dart';
part 'countries_state.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  final CountiesRepository countiesRepository;
  CountriesBloc(this.countiesRepository) : super(CountriesInitial()) {
    on<CountriesEvent>((event, emit) async {
      final TokenModel? getToken = await countiesRepository.getToken();
      print(getToken);
      // TODO: implement event handler
    });
  }
}
