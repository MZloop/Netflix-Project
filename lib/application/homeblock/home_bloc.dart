import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/core/failure/main_failure.dart';
import 'package:netflix_app/domain/hot_and_new_resp/hot_and_new_service.dart';
import 'package:netflix_app/domain/hot_and_new_resp/model/hot_and_new_resp.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HotAndNewService _homeService;
  HomeBloc(this._homeService) : super(HomeState.initial()) {
    //event
    on<GetHomeScreenData>(
      (event, emit) async {
        //send loading to ui
        emit(state.copyWith(isLoading: true, hasError: false));

        //get data
        final _movieResult = await _homeService.getHotAndNewMovieData();
        final _tvResult = await _homeService.getHotAndNewTvData();
        //transorm data
        final _state1 = _movieResult.fold(
          (MainFailure failure) {
            return  HomeState(
               stateId: DateTime.now().millisecondsSinceEpoch.toString(),
                pastYearMovieList: [],
                trendingMovieList: [],
                tensedramasMovieList: [],
                southIndianMovieList: [],
                trendingTvList: [],
                isLoading: false,
                hasError: true);
          },
          (HotAndNewResp resp) {
            final pastYear = resp.results;
            final trending = resp.results;
            final dramas = resp.results;
            final southIndian = resp.results;

            pastYear!.shuffle();
            trending!.shuffle();
            dramas!.shuffle();
            southIndian!.shuffle();
            return HomeState(
               stateId: DateTime.now().millisecondsSinceEpoch.toString(),
                pastYearMovieList: pastYear,
                trendingMovieList: trending,
                tensedramasMovieList: dramas,
                southIndianMovieList: southIndian,
                trendingTvList: state.trendingTvList,
                isLoading: false,
                hasError: false);
          },
        );
        emit(_state1);

        final _state2 = _tvResult.fold(
          (MainFailure failure) {
            return  HomeState(
               stateId: DateTime.now().millisecondsSinceEpoch.toString(),
                pastYearMovieList: [],
                trendingMovieList: [],
                tensedramasMovieList: [],
                southIndianMovieList: [],
                trendingTvList: [],
                isLoading: false,
                hasError: true);
          },
          (HotAndNewResp resp) {
            final to10List = resp.results;
            to10List!.shuffle();
            return HomeState(
              pastYearMovieList: state.pastYearMovieList,
              trendingMovieList: to10List,
              tensedramasMovieList: state.tensedramasMovieList,
              southIndianMovieList: state.southIndianMovieList,
              trendingTvList: to10List,
              isLoading: false,
              hasError: false,
              stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            );
          },
        );
        //send Ui
        emit(_state2);
      },
    );
  }
}
