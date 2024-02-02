import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/core/failure/main_failure.dart';
import 'package:netflix_app/domain/hot_and_new_resp/hot_and_new_service.dart';
import 'package:netflix_app/domain/hot_and_new_resp/model/hot_and_new_resp.dart';

part 'hotandnew_event.dart';
part 'hotandnew_state.dart';
part 'hotandnew_bloc.freezed.dart';

@injectable
class HotandnewBloc extends Bloc<HotandnewEvent, HotandnewState> {
  final HotAndNewService _hotAndNewService;
  HotandnewBloc(this._hotAndNewService) : super(HotandnewState.initial()) {
    //get and new movie data
    on<LoadDataInComingSoon>((event, emit) async {
      //send loading to ui
      emit(const HotandnewState(
          comingSoonList: [],
          EveryOneWathingList: [],
          isLoading: true,
          hasError: false));
      //get data from remote
      final _result = await _hotAndNewService.getHotAndNewMovieData();
      //data to state
      final newState = _result.fold(
        (MainFailure failure) {
          return const HotandnewState(
            comingSoonList: [],
            EveryOneWathingList: [],
            isLoading: false,
            hasError: true,
          );
        },
        (HotAndNewResp resp) {
          return HotandnewState(
            comingSoonList: resp.results ?? [],
            EveryOneWathingList: state.EveryOneWathingList,
            isLoading: false,
            hasError: false,
          );
        },
      );
      emit(newState);
    });
    on<LoadDataInEveryoneIsWatchingSoon>((event, emit) async {
      emit(const HotandnewState(
          comingSoonList: [],
          EveryOneWathingList: [],
          isLoading: true,
          hasError: false));
      //get data from remote
      final _result = await _hotAndNewService.getHotAndNewTvData();
      //data to state
      final newState = _result.fold(
        (MainFailure failure) {
          return const HotandnewState(
            comingSoonList: [],
            EveryOneWathingList: [],
            isLoading: false,
            hasError: true,
          );
        },
        (HotAndNewResp resp) {
          return HotandnewState(
            comingSoonList:state.comingSoonList,
            EveryOneWathingList:resp.results ?? [],
            isLoading: false,
            hasError: false,
          );
        },
      );
      emit(newState);
    });
  }
}
