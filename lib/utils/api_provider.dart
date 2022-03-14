import 'package:dio/dio.dart';
import 'package:movie_app/utils/interceptor.dart';
import 'package:movie_app/models/movie_detail_response.dart';
import 'package:movie_app/models/movie_response.dart';

class ApiProvider {
  final Dio _dio = Dio(
    BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3',
        connectTimeout: 5000,
        receiveTimeout: 3000),
  );

  ApiProvider() {
    _dio.interceptors.add(Logging());
  }

  Future<MovieResponse?> getUpcomingMovie() async {
    MovieResponse? movieResponse;

    try {
      final response = await _dio.get(
          '/movie/upcoming?api_key=6dd04502cb6dddf5bb7c93bf6f5174d4&page=1');
      movieResponse = MovieResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw 'Error sending request ${e.message}!';
    }

    return movieResponse;
  }

  Future<MovieResponse?> getUpcomingTv() async {
    MovieResponse? movieResponse;

    try {
      final response = await _dio.get(
          '/tv/airing_today?api_key=6dd04502cb6dddf5bb7c93bf6f5174d4&page=1');
      movieResponse = MovieResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw 'Error sending request ${e.message}!';
    }

    return movieResponse;
  }

  Future<MovieResponse?> getTrendingMovie() async {
    MovieResponse? movieResponse;

    try {
      final response = await _dio.get(
          '/movie/popular?api_key=6dd04502cb6dddf5bb7c93bf6f5174d4&page=1');
      movieResponse = MovieResponse.fromJson(response.data);
    } on DioError catch (e) {
      // ignore: avoid_print
      throw 'Error sending request ${e.message}!';
    }

    return movieResponse;
  }

  Future<MovieResponse?> getTrendingTv() async {
    MovieResponse? movieResponse;

    try {
      final response = await _dio
          .get('/tv/popular?api_key=6dd04502cb6dddf5bb7c93bf6f5174d4&page=1');
      movieResponse = MovieResponse.fromJson(response.data);
    } on DioError catch (e) {
      // ignore: avoid_print
      throw 'Error sending request ${e.message}!';
    }

    return movieResponse;
  }

  Future<MovieResponse?> getTopRatedMovie() async {
    MovieResponse? movieResponse;

    try {
      final response = await _dio.get(
          '/movie/top_rated?api_key=6dd04502cb6dddf5bb7c93bf6f5174d4&page=1');
      movieResponse = MovieResponse.fromJson(response.data);
    } on DioError catch (e) {
      // ignore: avoid_print
      throw 'Error sending request ${e.message}!';
    }

    return movieResponse;
  }

  Future<MovieResponse?> getTopRatedTv() async {
    MovieResponse? movieResponse;

    try {
      final response = await _dio
          .get('/tv/top_rated?api_key=6dd04502cb6dddf5bb7c93bf6f5174d4&page=1');
      movieResponse = MovieResponse.fromJson(response.data);
    } on DioError catch (e) {
      // ignore: avoid_print
      throw 'Error sending request ${e.message}!';
    }

    return movieResponse;
  }

  Future<MovieDetailResponse?> getMovieDetail(int movieId) async {
    MovieDetailResponse? movieDetailResponse;

    try {
      final response = await _dio.get(
          '/movie/$movieId?api_key=6dd04502cb6dddf5bb7c93bf6f5174d4&page=1');
      movieDetailResponse = MovieDetailResponse.fromJson(response.data);
    } on DioError catch (e) {
      // ignore: avoid_print
      throw 'Error sending request ${e.message}!';
    }

    return movieDetailResponse;
  }

  Future<MovieDetailResponse?> getTvDetail(int tvId) async {
    MovieDetailResponse? movieDetailResponse;

    try {
      final response = await _dio
          .get('/tv/$tvId?api_key=6dd04502cb6dddf5bb7c93bf6f5174d4&page=1');
      movieDetailResponse = MovieDetailResponse.fromJson(response.data);
    } on DioError catch (e) {
      // ignore: avoid_print
      throw 'Error sending request ${e.message}!';
    }

    return movieDetailResponse;
  }
}
