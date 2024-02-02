import 'package:dartz/dartz.dart';
import 'package:netflix_app/domain/core/failure/main_failure.dart';
import 'package:netflix_app/domain/hot_and_new_resp/model/hot_and_new_resp.dart';

abstract class HotAndNewService {
  Future<Either<MainFailure, HotAndNewResp>> getHotAndNewMovieData();
    Future<Either<MainFailure, HotAndNewResp>> getHotAndNewTvData();
}
