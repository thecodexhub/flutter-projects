import 'package:flutter/material.dart';
import 'package:url_metadata_extract/app.dart';
import 'package:url_metadata_extract/url_metadata/url_metadata.dart';

void main() {
  final urlMetadataRepository = UrlMetadataRepository();
  runApp(
    App(urlMetadataRepository: urlMetadataRepository),
  );
}
