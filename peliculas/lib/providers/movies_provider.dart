import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/helpers/debouncer.dart';
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = "api.themoviedb.org";
  String _baseToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyYTJlYzg0NmFkOTg2NTljODE3YjRmNjJhMGU1NjJlMCIsInN1YiI6IjY1YWE5YjBlNjhhZmQ2MDEyNzUwZTYxOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.EPOq4c0M4PkWL6PCHuUv_P-lR20CLAqOKzWjqT2hqBM";
  String _languaje = "es-ES";
  Map<String, String> _headers = {};
  List<Movie> onDisplayMovies = [];
  List<Movie> onDisplayPopularMovies = [];
  int _popularPage = 0;
  Map<int, List<Cast>> moviesCast = {};

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
  );

  final StreamController<List<Movie>> _suggestionStreamContoller =
      new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream =>
      this._suggestionStreamContoller.stream;

  MoviesProvider() {
    print("Movies providers inicializado");
    _headers = {
      'Authorization': 'Bearer $_baseToken',
    };

    this.getOneDisplayMovies();
    this.getDisplayPopularMovies();
  }

  getOneDisplayMovies() async {
    final getRespuestaData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(getRespuestaData);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getDisplayPopularMovies() async {
    _popularPage++;
    final getRespuestaData =
        await _getJsonData('3/movie/popular', _popularPage);
    final nowPopularResponse = PopularResponse.fromJson(getRespuestaData);
    onDisplayPopularMovies = [
      ...onDisplayPopularMovies,
      ...nowPopularResponse.results
    ];
    notifyListeners();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url =
        Uri.https(_baseUrl, endpoint, {'language': _languaje, 'page': '$page'});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url, headers: _headers);
    return response.body;
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    final jsonData = await this._getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(
        _baseUrl, '3/search/movie', {'language': _languaje, 'query': query});

    final response = await http.get(url, headers: _headers);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      // print('Tenemos valor a buscar: $value');
      final results = await this.searchMovies(value);
      this._suggestionStreamContoller.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }
}
