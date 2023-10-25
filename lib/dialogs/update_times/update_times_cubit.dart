import 'package:asal/services/address_service.dart';
import 'package:asal/services/config_service.dart';
import 'package:asal/services/praytimes_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UpdateTimesCubit extends Cubit<UpdateTimesState> {
  UpdateTimesCubit(this.context) : super(UpdateTimesInitial()) {
    loadCountries();
  }

  BuildContext context;

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

  Future<bool> onBack() async {
    Navigator.pop(context, false);
    return true;
  }

  Future<void> updateTimes() async {
    if (country == "" || city == "" || region == "") {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Lütfen konum bilgilerini girin.")));
      return;
    }

    EasyLoading.show(
        status: "Vakitler güncelleniyor", dismissOnTap: false, maskType: EasyLoadingMaskType.black);
    DateTime now = DateTime.now();
    await ConfigService.saveCalendar(
        await PrayTimeService.getTimes(now.year, now.month, country, city, region));
    EasyLoading.dismiss();
    Future.microtask(() => Navigator.pop(context, true));
  }
}

abstract class UpdateTimesState {}

class UpdateTimesInitial extends UpdateTimesState {}
