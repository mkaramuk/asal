import 'package:asal/services/addressservice.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateTimesCubit extends Cubit<UpdateTimesState> {
  UpdateTimesCubit() : super(UpdateTimesInitial()) {
    loadCountries();
  }

  List<String> countries = [];
  List<String> cities = [];
  List<String> regions = [];

  String country = "";
  String city = "";
  String region = "";

  bool countriesLoading = false;
  bool citiesLoading = false;
  bool regionsLoading = false;

  Future<void> loadCountries() async {
    countriesLoading = true;
    countries = [];
    cities = [];
    regions = [];
    city = "";
    country = "";
    region = "";
    emit(UpdateTimesInitial());

    countries = await AddressService.getCountries();
    countries.sort();
    country = countries.first;
    countriesLoading = false;

    emit(UpdateTimesInitial());
  }

  Future<void> loadCities() async {
    citiesLoading = true;
    cities = [];
    regions = [];
    city = "";
    region = "";
    emit(UpdateTimesInitial());

    cities = await AddressService.getCities(country);
    cities.sort();
    city = cities.first;
    citiesLoading = false;

    emit(UpdateTimesInitial());
  }

  Future<void> loadRegions() async {
    regionsLoading = true;
    regions = [];
    region = "";
    emit(UpdateTimesInitial());

    regions = await AddressService.getRegions(country, city);
    regions.sort();
    region = regions.first;
    regionsLoading = false;

    emit(UpdateTimesInitial());
  }

  Future<void> onChangeCountry(dynamic selectedCountry) async {
    if (countriesLoading) return;
    country = selectedCountry;
    citiesLoading = true;
    regionsLoading = true;
    await loadCities();
    await loadRegions();
  }

  Future<void> onChangeCity(dynamic selectedCity) async {
    if (countriesLoading || citiesLoading) return;
    city = selectedCity;
    regionsLoading = true;
    await loadRegions();
  }

  void onChangeRegion(dynamic selectedRegion) {
    if (countriesLoading || citiesLoading || regionsLoading) return;
    region = selectedRegion;
    emit(UpdateTimesInitial());
  }
}

abstract class UpdateTimesState {}

class UpdateTimesInitial extends UpdateTimesState {}
