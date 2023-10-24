import 'package:dio/dio.dart';

class AddressService {
  static Future<List<String>> getCountries() async {
    Response r = await Dio().get("https://namaz-vakti.vercel.app/api/countries");
    return List<String>.from((r.data as Iterable).map((e) => e["name"]));
  }

  static Future<List<String>> getCities(String country) async {
    Response r = await Dio().get("https://namaz-vakti.vercel.app/api/regions?country=$country");
    return List<String>.from((r.data as Iterable).map((e) => e.toString()));
  }

  static Future<List<String>> getRegions(String country, String city) async {
    Response r =
        await Dio().get("https://namaz-vakti.vercel.app/api/cities?country=$country&region=$city");
    return List<String>.from((r.data as Iterable).map((e) => e.toString()));
  }
}
