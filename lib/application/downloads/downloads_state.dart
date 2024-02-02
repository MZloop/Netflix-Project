part of 'downloads_bloc.dart';

@freezed
class DownloadsState with _$DownloadsState {
  const factory DownloadsState({
    required bool isloading,
    required List<Downloads>? downloads,
    required Option<Either<MainFailure, List<Downloads>>>
        downloadsFailureOrSuccesionOption,
  }) = _DownloadsState;
  factory DownloadsState.intail() {
    return const DownloadsState(
      isloading: true,
      downloadsFailureOrSuccesionOption: None(),
      downloads: [],
    );
  }
}
