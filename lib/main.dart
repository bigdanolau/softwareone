// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:softwareone/data/repository/countries_repository_impl.dart';
import 'package:softwareone/domain/bloc/countries_bloc/countries_bloc.dart';
import 'package:softwareone/presentation/pages/countries/list_countries.dart';
import 'generated/l10n.dart';

void main() async {
  await dotenv.load();
  await _forceOrientation();
  await _initializeGetIt();
  _initializeSplash();
  runApp(
    const RootPage(),
  );
}

void _initializeSplash() {
  WidgetsFlutterBinding.ensureInitialized();
}

Future<void> _forceOrientation() =>
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

Future<void> _initializeGetIt() async {
  await _registerAppDependencies();
}

Future<void> _registerAppDependencies() async {
  GetIt.I.registerLazySingleton<CountriesRepositoryImpl>(
    CountriesRepositoryImpl.new,
  );
}

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: _getAppRoutesInitialization(),
      initialRoute: AppRoutes.listCountries,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }

  Map<String, Widget Function(dynamic context)> _getAppRoutesInitialization() =>
      {
        AppRoutes.listCountries: (_) => _createListCountriesPageWithBloc(),
      };
}

BlocProvider _createListCountriesPageWithBloc() {
  return BlocProvider<CountriesBloc>(
    create: (_) =>
        CountriesBloc(countriesRepository: GetIt.I<CountriesRepositoryImpl>())
          ..add(
            GetCountriesEvent(),
          ),
    child: const ListCountriesPage(),
  );
}

class AppRoutes {
  static const listCountries = '/';
}
