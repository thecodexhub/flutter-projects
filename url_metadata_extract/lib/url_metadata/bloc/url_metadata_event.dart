part of 'url_metadata_bloc.dart';

class UrlMetadataEvent extends Equatable {
  const UrlMetadataEvent();

  @override
  List<Object> get props => [];
}

class UrlChanged extends UrlMetadataEvent {
  const UrlChanged(this.value);
  final String value;

  @override
  List<Object> get props => [value];
}

class UrlMetadataSearched extends UrlMetadataEvent {
  const UrlMetadataSearched();
}
