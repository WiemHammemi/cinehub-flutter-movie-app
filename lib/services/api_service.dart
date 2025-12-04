
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cine_hub/models/movie.dart';

class ApiService {
  static const String apiKey = '9d81f228c40023ae863d831a8ba5614f';
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String language = 'fr-FR';

  // Récupérer les films actuellement au cinéma
  Future<List<Movie>> getNowPlayingMovies() async {
    try {
      final url = Uri.parse(
        '$baseUrl/movie/now_playing?api_key=$apiKey&language=$language&page=1');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Movie> movies = (data['results'] as List)
            .map((movie) => Movie.fromJson(movie))
            .toList();
        return movies;
      } else {
        throw Exception('Erreur ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

  // Récupérer les films à venir
  Future<List<Movie>> getUpcomingMovies() async {
    try {
      final url = Uri.parse('$baseUrl/movie/upcoming?api_key=$apiKey&language=$language&page=1');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Movie> movies = (data['results'] as List)
            .map((movie) => Movie.fromJson(movie))
            .toList();
        return movies;
      } else {
        throw Exception('Erreur ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

  // Récupérer les films populaires
  Future<List<Movie>> getPopularMovies() async {
    try {
      final url = Uri.parse('$baseUrl/movie/popular?api_key=$apiKey&language=$language&page=1');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Movie> movies = (data['results'] as List)
            .map((movie) => Movie.fromJson(movie))
            .toList();
        return movies;
      } else {
        throw Exception('Erreur ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

  // Récupérer les films les mieux notés
  Future<List<Movie>> getTopRatedMovies() async {
    try {
      final url = Uri.parse('$baseUrl/movie/top_rated?api_key=$apiKey&language=$language&page=1');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Movie> movies = (data['results'] as List)
            .map((movie) => Movie.fromJson(movie))
            .toList();
        return movies;
      } else {
        throw Exception('Erreur ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }
}