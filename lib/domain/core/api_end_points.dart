import 'package:netflix_app/core/colors/strings.dart';
import 'package:netflix_app/infrastructure/api_key.dart';

class ApiEndPoints {
  static const downloads = "$kBaseUrl/trending/all/day?api_key=$ApiKey";
  static const search = "$kBaseUrl/search/movie?api_key=$ApiKey";
  static const hotAndNewMovie = "$kBaseUrl/discover/movie?api_key=$ApiKey";
    static const hotAndNewTv = "$kBaseUrl/discover/tv?api_key=$ApiKey";

}
