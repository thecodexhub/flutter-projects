import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:url_metadata_extract/url_metadata/url_metadata.dart';

part 'url_metadata_event.dart';
part 'url_metadata_state.dart';

class UrlMetadataBloc extends Bloc<UrlMetadataEvent, UrlMetadataState> {
  UrlMetadataBloc({required UrlMetadataRepository urlMetadataRepository})
      : _urlMetadataRepository = urlMetadataRepository,
        super(const UrlMetadataInitial()) {
    on<UrlChanged>(_onUrlChanged);
    on<UrlMetadataSearched>(_onUrlMetadataSearched);
  }

  final UrlMetadataRepository _urlMetadataRepository;

  FutureOr<void> _onUrlChanged(
    UrlChanged event,
    Emitter<UrlMetadataState> emit,
  ) async {
    emit(UrlInUpdate(event.value));
  }

  FutureOr<void> _onUrlMetadataSearched(
    UrlMetadataSearched event,
    Emitter<UrlMetadataState> emit,
  ) async {
    emit(UrlMetadataLoading(state.url));

    try {
      final metadata = await _urlMetadataRepository.extractUrlMetadata(
        url: state.url,
      );
      emit(UrlMetadataSuccess(state.url, metadata));
    } on UrlMetadataException catch (e) {
      emit(UrlMetadataFailure(state.url, e.error));
    } catch (_) {
      emit(UrlMetadataFailure(state.url, 'Something unexpected occurred'));
    }
  }
}
