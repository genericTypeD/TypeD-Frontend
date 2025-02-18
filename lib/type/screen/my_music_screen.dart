import 'package:flutter/material.dart';
import 'package:typed/common/const/app_bar_style.dart';
import 'package:typed/type/component/grid_text_item.dart';
import 'package:typed/common/const/app_themes.dart';
import 'package:typed/config/env.dart';
import 'package:typed/common/index.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotify/spotify.dart' hide Image;
import 'dart:io';

class MyMusicScreen extends StatefulWidget {
  const MyMusicScreen({super.key});

  @override
  State<MyMusicScreen> createState() => _MyMusicScreenState();
}

class _MyMusicScreenState extends State<MyMusicScreen> {
  SpotifyApi spotify = SpotifyApi(
    SpotifyApiCredentials(
      Env.spotifyClientId,
      Env.spotifyClientSecret,
    ),
  );
  List<Track> searchResults = [];
  bool isLoading = false;
  final searchController = TextEditingController();

  Track? selectedTrack;
  List<Track> currentTracks = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> searchMusic(String query) async {
    if (query.isEmpty) return;

    setState(
      () => isLoading = true,
    );

    try {
      var results = await spotify.search
          .get(
            query,
            types: [
              SearchType.track,
            ],
            market: Market.KR,
          )
          .first();

      var tracks = results.first.items ?? [];

      setState(
        () {
          searchResults = tracks.whereType<Track>().toList();
          isLoading = false;
        },
      );
    } catch (e) {
      debugPrint('$e');
      setState(
        () => isLoading = false,
      );
    }
  }

  Widget renderBottomSheetContainer() {
    return SafeArea(
      child: Column(
        children: [
          TextField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: '노래, 아티스트 또는 앨범을 검색하세요.',
              prefixIcon: Icon(Icons.search),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 0.3,
                  color: Color(0xffF3F3F2),
                ),
                borderRadius: BorderRadius.zero,
              ),
            ),
            onChanged: (value) {
              Future.delayed(const Duration(milliseconds: 500), () {
                if (value == searchController.text) {
                  searchMusic(value);
                }
              });
            },
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final track = searchResults[index];
                      return ListTile(
                        leading: track.album?.images?.isNotEmpty ?? false
                            ? Image.network(
                                track.album!.images!.first.url!,
                                width: 50,
                                height: 50,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.music_note),
                              )
                            : const Icon(Icons.music_note),
                        title: Text(track.name ?? 'Unknown Track'),
                        subtitle: Text(
                          '${track.artists?.first.name ?? 'Unknown Artist'} - ${track.album?.name ?? 'Unknown Album'}',
                        ),
                        onTap: () {
                          setState(
                            () {
                              selectedTrack = track;
                              currentTracks.insert(0, track);
                            },
                          );
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
