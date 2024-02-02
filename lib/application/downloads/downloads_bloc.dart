import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/core/failure/main_failure.dart';
import 'package:netflix_app/domain/downloads/i_downloads_repo.dart';
import 'package:netflix_app/domain/downloads/models/download.dart';

part 'downloads_event.dart';
part 'downloads_state.dart';
part 'downloads_bloc.freezed.dart';

@injectable
class DownloadsBloc extends Bloc<DownloadsEvent, DownloadsState> {
  final IDownloadsRepo _downloadsRepo;
  DownloadsBloc(this._downloadsRepo) : super(DownloadsState.intail()) {
    on<_getDownloadsImages>((event, emit) async {
      emit(
        state.copyWith(
          isloading: true,
          downloadsFailureOrSuccesionOption: none(),
        ),
      );
      final Either<MainFailure, List<Downloads>> downloadsOption =
          await _downloadsRepo.getDownloadsImages();
      log(downloadsOption.toString());
      emit(downloadsOption.fold(
          (failure) => state.copyWith(
              isloading: false,
              downloadsFailureOrSuccesionOption: some(
                left(failure),
              )),
          (success) => state.copyWith(
              isloading: false,
              downloads: success,
              downloadsFailureOrSuccesionOption: some(right(success)))));
    });
  }
}
