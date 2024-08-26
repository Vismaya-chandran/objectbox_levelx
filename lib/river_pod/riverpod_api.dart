import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_project/river_pod/models.dart';

class RiverpodApiView extends ConsumerWidget {
  RiverpodApiView({super.key});
  final albumProvider = FutureProvider<Album>((ref) async {
    return fetchAlbum();
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albumAsyncValue = ref.watch(albumProvider);
    return albumAsyncValue.when(
      data: (album) => Text('Album title: ${album.title}'),
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}

Future<Album> fetchAlbum() async {
  final dio = Dio();
  try {
    final response =
        await dio.get("https://jsonplaceholder.typicode.com/albums/1");
    if (response.statusCode == 200) {
      final decode = jsonDecode(response.data) as Map<String, dynamic>;
      return Album.fromJson(decode);
    } else {
      throw Exception("failed to load album");
    }
  } catch (e) {
    throw Exception("failed to load album${e.toString()}");
  }
}
