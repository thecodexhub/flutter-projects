import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_metadata_extract/url_metadata/url_metadata.dart';

class UrlMetadataPage extends StatelessWidget {
  const UrlMetadataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UrlMetadataBloc>(
      create: (context) => UrlMetadataBloc(
        urlMetadataRepository: context.read<UrlMetadataRepository>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Extract Metadata from URL'),
        ),
        body: const Center(
          child: _UrlMetadataView(),
        ),
      ),
    );
  }
}

class _UrlMetadataView extends StatelessWidget {
  const _UrlMetadataView();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 45),
      margin: const EdgeInsets.all(20),
      constraints: const BoxConstraints(maxWidth: 750),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Extract Metadata from URL',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 46, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const FractionallySizedBox(
            widthFactor: 0.75,
            child: Text(
              'Paste an URL and hit extract button to get the metadata from the link. '
              'Display a website url preview easily. Follow @thecodexhub for more content like this.',
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 16, color: Colors.black54, height: 1.48),
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder<UrlMetadataBloc, UrlMetadataState>(
            buildWhen: (previous, current) => previous.url != current.url,
            builder: (context, state) {
              return TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  hintText: 'Paste an URL here...',
                ),
                onChanged: (value) => context.read<UrlMetadataBloc>().add(
                      UrlChanged(value),
                    ),
              );
            },
          ),
          const SizedBox(height: 12),
          const SizedBox(
            height: 60,
            child: _ExtractMetadataSubmitButton(),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.purple),
            ),
            child: const _MetadataInfoView(),
          ),
        ],
      ),
    );
  }
}

class _MetadataInfoView extends StatelessWidget {
  const _MetadataInfoView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UrlMetadataBloc, UrlMetadataState>(
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        if (state is UrlMetadataSuccess) {
          return Row(
            children: [
              SizedBox(
                height: 140,
                width: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(state.metadata.imageUrls[0]),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      state.metadata.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.metadata.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.metadata.domain,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Time taken to Extract Metadata: ${state.metadata.duration}ms',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        if (state is UrlMetadataFailure) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 70),
            child: Text(
              'ERROR!!! ${state.failure}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                height: 1.45,
              ),
            ),
          );
        }

        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 60, vertical: 70),
          child: Text(
            'Paste an URL on the text field above and hit the Extract Metadata button',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.black45, height: 1.45),
          ),
        );
      },
    );
  }
}

class _ExtractMetadataSubmitButton extends StatelessWidget {
  const _ExtractMetadataSubmitButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UrlMetadataBloc, UrlMetadataState>(
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state is! UrlMetadataLoading
              ? () => context.read<UrlMetadataBloc>().add(
                    const UrlMetadataSearched(),
                  )
              : null,
          child: state is UrlMetadataLoading
              ? const CircularProgressIndicator()
              : const Text('Extract Metadata from URL'),
        );
      },
    );
  }
}
