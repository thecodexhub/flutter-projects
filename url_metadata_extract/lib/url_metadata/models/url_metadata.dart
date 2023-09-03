import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'url_metadata.g.dart';

/// {@template url_metadata}
/// URL Metadata model.
/// {@endtemplate}
@JsonSerializable()
class UrlMetadata extends Equatable {
  /// {@macro url_metadata}
  const UrlMetadata({
    required this.title,
    required this.description,
    required this.imageUrls,
    required this.duration,
    required this.domain,
    required this.url,
  });

  /// Converts Map<String, dynamic> into an instance of [UrlMetadata].
  factory UrlMetadata.fromJson(Map<String, dynamic> json) =>
      _$UrlMetadataFromJson(json);

  /// Title extracted from the URL
  final String title;

  /// Description extracted from the URL
  final String description;

  /// Image URL extracted from the URL
  @JsonKey(name: 'images')
  final List<String> imageUrls;

  /// Time taken in milliseconds to extract the metadata from URL
  final int duration;

  /// Domain name extracted from the URL
  final String domain;

  /// URL for which the metadata has been extracted
  final String url;

  @override
  List<Object?> get props => [
        title,
        description,
        imageUrls,
        duration,
        domain,
        url,
      ];
}
