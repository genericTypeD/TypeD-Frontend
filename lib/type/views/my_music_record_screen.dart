import 'package:flutter/material.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/common/index.dart';
import 'package:typed/config/env.dart';
import 'package:typed/type/models/grid_item.dart';
import 'package:spotify/spotify.dart' hide Image;
import 'package:uuid/uuid.dart';

class MyMusicRecordScreen extends StatefulWidget {
  final GridItem? item;

  const MyMusicRecordScreen({
    this.item,
    super.key,
  });

  @override
  State<MyMusicRecordScreen> createState() => _MyMusicRecordScreenState();
}

class _MyMusicRecordScreenState extends State<MyMusicRecordScreen> {
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

    if (widget.item != null && widget.item!.isValid && widget.item!.isMusic) {
      final track = widget.item!.track!;
      selectedTrack = track;
      currentTracks.add(track);
    }
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
      setState(() {
        isLoading = false;
        searchResults = [];
      });
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
            onSubmitted: (value) {
              debugPrint('onSubmitted: ${value}');
              searchMusic(value);
              // }
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return DefaultLayout(
      appBar: CustomAppBar(
        bottomLeftWidget: TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
          ),
          child: Text(
            '뒤로 가기',
            textAlign: TextAlign.left,
            style: AppTheme.title3.copyWith(
              height: 1,
            ),
          ),
        ),
        bottomCenterWidget: TextButton(
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Colors.white,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              barrierColor: Colors.black54,
              useSafeArea: true,
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          setState(() {
                            searchController.text = '';
                            searchResults = [];
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          '취소',
                          style: AppTheme.title3,
                        ),
                      ),
                      TextField(
                        autocorrect: false,
                        controller: searchController,
                        cursorColor: Colors.black54,
                        cursorWidth: 1,
                        style: AppTheme.body1,
                        decoration: InputDecoration(
                          hintText: '노래, 아티스트 또는 앨범 검색을 검색하세요.',
                          hintStyle: AppTheme.body1,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 0.3,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.zero,
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) {
                          if (value == searchController.text) {
                            searchMusic(value);
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              )
                            : ListView.builder(
                                itemCount: searchResults.length,
                                itemBuilder: (context, index) {
                                  final track = searchResults[index];
                                  return ListTile(
                                    leading: track.album?.images?.isNotEmpty ??
                                            false
                                        ? Image.network(
                                            track.album!.images!.first.url!,
                                            width: 50,
                                            height: 50,
                                            errorBuilder: (context, error,
                                                    stackTrace) =>
                                                const Icon(Icons.music_note),
                                          )
                                        : const Icon(Icons.music_note),
                                    title: Text(track.name ?? 'Unknown Track'),
                                    subtitle: Text(
                                      '${track.artists?.first.name ?? 'Unknown Artist'} - ${track.album?.name ?? 'Unknown Album'}',
                                    ),
                                    onTap: () {
                                      setState(() {
                                        selectedTrack = track;
                                        debugPrint(
                                            'selectedTrack?.album?.name: ${selectedTrack?.album?.name}');
                                        currentTracks.insert(0, track);
                                        searchController.text = '';
                                        searchResults = [];
                                      });
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Text(
            '검색하기',
            style: AppTheme.title3.copyWith(
              height: 1,
            ),
          ),
        ),
        bottomRightWidget: TextButton(
          onPressed: selectedTrack != null
              ? () async {
                  try {
                    if (selectedTrack != null) {
                      final result = GridItem.music(
                        id: Uuid().v4(),
                        track: selectedTrack!,
                      );
                      Navigator.pop(context, result);
                    }
                  } catch (e) {
                    debugPrint('[Saving Image Error] $e');
                    // TODO: - 에러 처리 UI 구현
                  }
                }
              : null,
          child: Text(
            '기록하기',
            style: AppTheme.title3.copyWith(
              height: 1,
            ),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: AppBarStyle.borderContainerWidth,
            decoration: const BoxDecoration(
              color: Color(0xffF3F3F2),
              border: Border(right: AppBarStyle.borderStyle),
            ),
            child: Column(
              children: [
                Expanded(
                  child: SafeArea(
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(bottom: AppBarStyle.borderStyle),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xffF3F3F2),
              child: SafeArea(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: AppBarStyle.borderStyle),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          width: double.infinity,
                          height: screenHeight * 0.22,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 0.3,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        flex: 8,
                                        child: Text(
                                          selectedTrack?.name ?? '',
                                          style: AppTheme.title2,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 5,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Flexible(
                                        flex: 3,
                                        child: Text(
                                          selectedTrack?.artists?.first.name ??
                                              '',
                                          style: AppTheme.body3.copyWith(
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: screenHeight * 0.22,
                                height: screenHeight * 0.22,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    left: BorderSide(
                                      color: Colors.black,
                                      width: 0.3,
                                    ),
                                  ),
                                ),
                                child: (selectedTrack != null &&
                                        selectedTrack!.album != null &&
                                        selectedTrack!.album!.images != null &&
                                        selectedTrack!
                                            .album!.images!.isNotEmpty &&
                                        selectedTrack!
                                                .album!.images!.first.url !=
                                            null)
                                    ? Image.network(
                                        selectedTrack!
                                            .album!.images!.first.url!,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(Icons.music_note,
                                                    size: 50),
                                      )
                                    : Container(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 0.3,
                              ),
                            ),
                            child: GridView.builder(
                              physics: const ClampingScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisExtent: screenWidth * 0.22,
                              ),
                              itemCount: currentTracks.length,
                              itemBuilder: (context, index) {
                                final currentTrack = currentTracks[index];
                                return GestureDetector(
                                  onTap: () {
                                    setState(
                                      () {
                                        selectedTrack = currentTrack;
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.black,
                                          width: 0.3,
                                        ),
                                      ),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(
                                                border: Border(
                                                  right: BorderSide(
                                                    color: Colors.black,
                                                    width: 0.3,
                                                  ),
                                                ),
                                              ),
                                              // child: Image.network(
                                              //   currentTrack.album!.images!
                                              //           .first.url ??
                                              //       '',
                                              //   width: screenWidth * 0.22,
                                              // ),
                                              child: (currentTrack.album !=
                                                          null &&
                                                      currentTrack
                                                              .album!.images !=
                                                          null &&
                                                      currentTrack.album!
                                                          .images!.isNotEmpty &&
                                                      currentTrack
                                                              .album!
                                                              .images!
                                                              .first
                                                              .url !=
                                                          null)
                                                  ? Image.network(
                                                      currentTrack
                                                              .album!
                                                              .images!
                                                              .first
                                                              .url ??
                                                          '',
                                                      width: screenWidth * 0.22,
                                                    )
                                                  : Container(),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        currentTrack.name ?? '',
                                                        style: AppTheme.title3,
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 2),
                                                    Flexible(
                                                      child: Text(
                                                        currentTrack.artists
                                                                ?.map((e) =>
                                                                    e.name ??
                                                                    '')
                                                                .toList()
                                                                .join(', ') ??
                                                            'Unknown Artist',
                                                        style: AppTheme.body3
                                                            .copyWith(
                                                          color: Colors.black,
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            debugPrint('pin');
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.08,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.08,
                                            decoration: BoxDecoration(
                                              color: index % 2 != 0
                                                  ? Colors.white
                                                  : const Color(0xffF3F3F2),
                                              border: const Border(
                                                bottom: BorderSide(
                                                  color: Colors.black,
                                                  width: 0.3,
                                                ),
                                                left: BorderSide(
                                                  color: Colors.black,
                                                  width: 0.3,
                                                ),
                                              ),
                                            ),
                                            child: () {
                                              if (index % 2 == 0) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Image.asset(
                                                    'assets/images/grid_item_placeholder.png',
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.06,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.06,
                                                  ),
                                                );
                                              } else {
                                                return Container();
                                              }
                                            }(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: AppBarStyle.borderContainerWidth,
            decoration: const BoxDecoration(
              color: Color(0xffF3F3F2),
              border: Border(left: AppBarStyle.borderStyle),
            ),
            child: Column(
              children: [
                Expanded(
                  child: SafeArea(
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(bottom: AppBarStyle.borderStyle),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
