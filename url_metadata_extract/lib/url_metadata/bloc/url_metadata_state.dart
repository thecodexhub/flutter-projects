part of 'url_metadata_bloc.dart';

abstract class UrlMetadataState extends Equatable {
  const UrlMetadataState(this.url);
  final String url;

  @override
  List<Object> get props => [url];
}

class UrlMetadataInitial extends UrlMetadataState {
  const UrlMetadataInitial() : super('');
}

class UrlInUpdate extends UrlMetadataState {
  const UrlInUpdate(this.value) : super(value);
  final String value;

  @override
  List<Object> get props => [value];
}

class UrlMetadataLoading extends UrlMetadataState {
  const UrlMetadataLoading(super.url);
}

class UrlMetadataSuccess extends UrlMetadataState {
  const UrlMetadataSuccess(super.url, this.metadata);
  final UrlMetadata metadata;

  @override
  List<Object> get props => [metadata];
}

class UrlMetadataFailure extends UrlMetadataState {
  const UrlMetadataFailure(super.url, this.failure);
  final String failure;

  @override
  List<Object> get props => [failure];
}
