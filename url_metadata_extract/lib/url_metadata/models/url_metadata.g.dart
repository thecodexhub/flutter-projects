// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UrlMetadata _$UrlMetadataFromJson(Map<String, dynamic> json) => UrlMetadata(
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrls:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      duration: json['duration'] as int,
      domain: json['domain'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$UrlMetadataToJson(UrlMetadata instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'images': instance.imageUrls,
      'duration': instance.duration,
      'domain': instance.domain,
      'url': instance.url,
    };
