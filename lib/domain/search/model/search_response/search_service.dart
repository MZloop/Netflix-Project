import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netflix_app/domain/core/failure/main_failure.dart';
import 'package:netflix_app/domain/search/model/search_response/search_response.dart';

abstract class SearchService {
  Future<Either<MainFailure, SearchResponse>> searchMovies({
    required String movieQuery,
  });
}
