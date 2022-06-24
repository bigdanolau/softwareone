// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_launcher/maps_launcher.dart';

// Project imports:
import 'package:softwareone/data/models/countries_model.dart';
import 'package:softwareone/domain/bloc/countries_bloc/countries_bloc.dart';
import 'package:softwareone/generated/l10n.dart';
import 'package:softwareone/presentation/utils/responsive.dart';

class ListCountriesPage extends StatefulWidget {
  const ListCountriesPage({Key? key}) : super(key: key);

  @override
  State<ListCountriesPage> createState() => _ListCountriesPageState();
}

class _ListCountriesPageState extends State<ListCountriesPage>
    // ignore: prefer_mixin
    with
        WidgetsBindingObserver {
  TextEditingController editingController = TextEditingController();
  List<CountriesModel?> countriesList = [];
  List<CountriesModel?> countriesListFilter = [];
  bool inizialiteData = false;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _initializeData(context);
    }
  }

  void _initializeData(BuildContext context) {
    BlocProvider.of<CountriesBloc>(context).add(
      GetCountriesEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveDimensions sizeDevice = ResponsiveDimensions.of(context);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: sizeDevice.widthDevice,
          height: sizeDevice.heightDevice,
          child: BlocConsumer<CountriesBloc, CountriesState>(
            listener: (context, state) {
              if (state is CountriesComplete) {
                setState(() {
                  countriesList = state.countries;
                  countriesListFilter = state.countries;
                  inizialiteData = true;
                });
              }
            },
            builder: (context, state) {
              return Container(
                width: sizeDevice.widthDevice,
                height: sizeDevice.heightDevice,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.4)),
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: sizeDevice.ip(2),
                  vertical: sizeDevice.ip(1),
                ),
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: sizeDevice.ip(1)),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            countriesListFilter = countriesList
                                .where(
                                  (e) =>
                                      e?.countryName.toLowerCase().contains(
                                          editingController.text
                                              .toLowerCase()) ==
                                      true,
                                )
                                .toList();
                          });
                        },
                        controller: editingController,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.search),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(
                          sizeDevice.ip(2),
                        ),
                        child: inizialiteData
                            ? Scrollbar(
                                thumbVisibility: true,
                                child: countriesListFilter.isEmpty
                                    ? const Text('No results found')
                                    : ListView.builder(
                                        itemCount: countriesListFilter.length,
                                        itemBuilder: (_, int index) {
                                          return _buildCard(sizeDevice,
                                              countriesListFilter[index]!);
                                        },
                                      ),
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Card _buildCard(ResponsiveDimensions sizeDevice, CountriesModel country) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(sizeDevice.ip(1)),
      elevation: 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.all(sizeDevice.ip(2)),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  country.countryName,
                  style: TextStyle(
                    fontSize: sizeDevice.ip(2.5),
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  country.countryPhoneCode.toString(),
                ),
                Text(
                  country.countryShortName,
                  style: TextStyle(
                    fontSize: sizeDevice.ip(2.3),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            leading: InkWell(
              onTap: () => MapsLauncher.launchQuery(country.countryName),
              child: Container(
                padding: EdgeInsets.all(
                  sizeDevice.ip(1),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      sizeDevice.ip(0.5),
                    ),
                  ),
                  border: Border.all(),
                ),
                child: Text(
                  S.current.go,
                  style: TextStyle(
                    fontSize: sizeDevice.ip(3),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
