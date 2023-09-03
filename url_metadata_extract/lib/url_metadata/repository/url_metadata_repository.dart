import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:url_metadata_extract/url_metadata/url_metadata.dart';

/// {@template url_metadata_exception}
/// An exception class for the metadata extraction failures.
/// {@endtemplate}
class UrlMetadataException with EquatableMixin implements Exception {
  /// {@macro url_metadata_exception}
  const UrlMetadataException(this.error);

  /// The associated error code.
  final String error;

  @override
  List<Object?> get props => [error];
}

/// {@template url_metadata_repository}
/// Repository that fetches metadata from an URL
/// {@endtemplate}
class UrlMetadataRepository {
  UrlMetadataRepository({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<UrlMetadata> extractUrlMetadata({required String url}) async {
    Uri uri;

    try {
      uri = Uri.parse(url);
    } on FormatException catch (_) {
      throw const UrlMetadataException('Invalid URL Format');
    }

    http.Response response;

    try {
      Uri requestUrl = Uri.parse('https://jsonlink.io/api/extract?url=$uri');
      response = await _httpClient.get(requestUrl);
    } on Exception catch (error) {
      throw UrlMetadataException(error.toString());
    }

    Map<String, dynamic> body;

    try {
      body = json.decode(response.body) as Map<String, dynamic>;
    } on Exception catch (_) {
      throw const UrlMetadataException('Unable to decode the JSON response');
    }

    if (response.statusCode != 200) {
      throw const UrlMetadataException('HTTP Exception occurred');
    }

    UrlMetadata metadata;

    try {
      metadata = UrlMetadata.fromJson(body);
    } on Exception catch (_) {
      throw const UrlMetadataException('Error while de-serializing the response');
    }

    return metadata;
  }
}
