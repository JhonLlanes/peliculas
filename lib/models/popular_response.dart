import 'dart:convert';
import 'package:peliculas/models/models.dart';

class PopularResponse {
  int page;
  List<MoviePopular> results;
  int totalPages;
  int totalResults;

  PopularResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory PopularResponse.fromJson(String str) =>
      PopularResponse.fromMap(json.decode(str));

  factory PopularResponse.fromMap(Map<String, dynamic> json) => PopularResponse(
        page: json["page"],
        results: List<MoviePopular>.from(
            json["results"].map((x) => MoviePopular.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
