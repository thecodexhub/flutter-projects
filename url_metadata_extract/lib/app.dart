import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_metadata_extract/url_metadata/url_metadata.dart';

class App extends StatelessWidget {
  const App({
    required UrlMetadataRepository urlMetadataRepository,
    super.key,
  }) : _urlMetadataRepository = urlMetadataRepository;

  final UrlMetadataRepository _urlMetadataRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<UrlMetadataRepository>.value(
      value: _urlMetadataRepository,
      child: const _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'URL Metadata Extract',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: UrlMetadataPage(),
    );
  }
}
