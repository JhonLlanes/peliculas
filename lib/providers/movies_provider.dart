import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = "api.themoviedb.org";
  String _baseToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyYTJlYzg0NmFkOTg2NTljODE3YjRmNjJhMGU1NjJlMCIsInN1YiI6IjY1YWE5YjBlNjhhZmQ2MDEyNzUwZTYxOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.EPOq4c0M4PkWL6PCHuUv_P-lR20CLAqOKzWjqT2hqBM";
  String _languaje = "es-ES";
  Map<String, String> _headers = {};
  List<Movie> onDisplayMovies = [];
  List<Movie> onDisplayPopularMovies = [];

  MoviesProvider() {
    print("Movies providers inicializado");
    _headers = {
      'Authorization': 'Bearer $_baseToken',
    };

    this.getOneDisplayMovies();
    //this.getDisplayPopularMovies();
  }

  getOneDisplayMovies() async {
    print("getOndisplayMovies");
    var url = Uri.https(this._baseUrl, '3/movie/now_playing',
        {'language': _languaje, 'page': '1'}); //Paginación con The Movie DB API

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url, headers: _headers);
    if (response.statusCode == 200) {
      final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
      print(nowPlayingResponse.results[0].title);
      onDisplayMovies = nowPlayingResponse.results;
      notifyListeners();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  getDisplayPopularMovies() async {
    print("getDisplayPopularMovies");
    var url = Uri.https(this._baseUrl, '3/person/popular',
        {'language': _languaje, 'page': '1'});
    final responsePopular = await http.get(url, headers: _headers);
    if (responsePopular.statusCode == 200) {
      final nowPopularResponse = PopularResponse.fromJson(responsePopular.body);
      //print(nowPopularResponse.results[0].title);
      onDisplayPopularMovies = [...nowPopularResponse.results];
      notifyListeners();
    } else {
      print('Request failed with status: ${responsePopular.statusCode}.');
    }
  }
}
