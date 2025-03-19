import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spotify/spotify.dart';
import 'package:typed/review/data/models/review_model.dart';
import 'package:typed/sentence/model/sentence_model.dart';
import 'package:typed/type/models/grid_data.dart';
import 'package:typed/type/models/grid_item.dart';
import 'package:typed/type/models/grid_item_type.dart';
import 'package:typed/type/models/grid_state.dart';
import 'package:typed/type/models/period_type.dart';

final gridProvider = StateNotifierProvider<GridViewModel, GridState>((ref) {
  return GridViewModel();
});

class GridViewModel extends StateNotifier<GridState> {
  GridViewModel() : super(GridState.initial());

  PeriodType _currentPeriodType = PeriodType.weekly; // 현재 선택된 PeriodType
  DateTime _currentDateTime = DateTime.now(); // 현재 선택된 날짜

  /// PeriodType 및 날짜 변경 시 호출
  Future<void> loadForPeriodAndDate(
      PeriodType periodType, DateTime dateTime) async {
    try {
      _currentPeriodType = periodType;
      _currentDateTime = dateTime;

      await _loadFromHive(); // Hive에서 데이터 로드
    } catch (error) {
      // 오류 발생 시 기본값 사용
      state = GridState.initial();
      debugPrint('[PeriodType/날짜 변경 중 오류] error: $error');
    }
  }

  /// 그리드 아이템 업데이트
  void updateGridItem(int verticalIndex, int horizontalIndex, GridItem data) {
    final newItems = List<List<GridItem>>.from(
      state.items.map((row) => List<GridItem>.from(row)),
    ); // 새로운 그리드 아이템 목록 생성

    newItems[verticalIndex][horizontalIndex] = data; // 해당 위치의 아이템 업데이트

    state = state.copyWith(items: newItems); // 상태 업데이트

    _saveToHive(); // Hive에 저장
  }

  /// Hive에 현재 상태 저장
  Future<void> _saveToHive() async {
    try {
      final box = Hive.box<GridData>('grid'); // Grid 박스 열기

      final key =
          GridData.createKey(_currentPeriodType, _currentDateTime); // 저장할 키 생성

      // GridItem 타입별 데이터를 JSON으로 변환
      final gridItemsJson = state.items.map((row) {
        return row.map((item) {
          try {
            final json = {
              'id': item.id,
              'type': item.type.index,
            };

            switch (item.type) {
              case GridItemType.sentence:
                if (item.sentence != null) {
                  json['sentenceId'] = item.sentence!.id;
                  json['sentenceContent'] = item.sentence!.content;
                  json['sentenceIsPublic'] = item.sentence!.isPublic;
                  json['sentenceCreatedAt'] = item.sentence!.createdAt;
                  json['sentenceUpdatedAt'] = item.sentence!.updatedAt;
                }
                break;

              case GridItemType.bookReview:
                if (item.bookReview != null) {
                  json['reviewId'] = item.bookReview!.id;
                  json['bookIsbn'] = item.bookReview!.bookIsbn;
                  json['bookTitle'] = item.bookReview!.bookTitle;
                  json['reviewContent'] = item.bookReview!.content;
                  json['reviewIsPublic'] = item.bookReview!.isPublic;
                  // json['bookThumbnail'] = item.bookReview!.thumbnail;
                  if (item.bookReview!.thumbnail != null) {
                    json['bookThumbnail'] = item.bookReview!.thumbnail!;
                  }
                  json['reviewCreatedAt'] = item.bookReview!.createdAt;
                  json['reviewUpdatedAt'] = item.bookReview!.updatedAt;
                }
                break;

              case GridItemType.music:
                if (item.track != null) {
                  if (item.track!.id != null) {
                    json['trackId'] = item.track!.id!;
                  }
                  if (item.track!.name != null) {
                    json['trackName'] = item.track!.name!;
                  }
                  if (item.track!.uri != null) {
                    json['trackUri'] = item.track!.uri!;
                  }

                  if (item.track!.album != null &&
                      item.track!.album!.images != null &&
                      item.track!.album!.images!.isNotEmpty &&
                      item.track!.album!.images![0].url != null) {
                    final image = item.track!.album!.images![0];
                    if (image.url != null) {
                      json['albumImageUrl'] = image.url!;
                    }
                  }
                }
                break;

              // TODO: - 매핑 수정
              case GridItemType.image:
                if (item.imagePath != null) {
                  json['imagePath'] = item.imagePath!;
                }
                break;

              case GridItemType.empty:
                break;
            }

            return json;
          } catch (error) {
            debugPrint('[GridItem JSON 변환 중 오류] error: $error');
            // 오류 발생 시에는 기본 정보만 포함
            return {
              'id': item.id,
              'type': item.type.index,
            };
          }
        }).toList();
      }).toList();

      // 저장할 데이터 생성
      final data = GridData(
        periodTypeStr: _currentPeriodType.name,
        dateTime: _currentDateTime,
        gridItemsJson: gridItemsJson,
      );

      await box.put(key, data); // 박스에 저장
      debugPrint('[Grid 데이터 저장 완료] key: $key');
    } catch (error) {
      debugPrint('[Grid 데이터 저장 실패] error: $error');
    }
  }

  /// Hive에서 상태 로드
  Future<void> _loadFromHive() async {
    final box = Hive.box<GridData>('grid'); // Grid 박스 열기

    final key =
        GridData.createKey(_currentPeriodType, _currentDateTime); // 로드할 키 생성

    final data = box.get(key); // 데이터 로드

    // 데이터가 null이 아닐 때, JSON에서 GridItem으로 변환
    if (data != null) {
      try {
        final items = List.generate(
          data.gridItemsJson.length,
          (vertIndex) => List.generate(
            data.gridItemsJson[vertIndex].length,
            (horizIndex) {
              try {
                final itemJson = data.gridItemsJson[vertIndex][horizIndex];
                final id = itemJson['id'] as String;
                final typeIndex = itemJson['type'] as int;

                // 타입 인덱스 유효성 검사
                if (typeIndex < 0 || typeIndex >= GridItemType.values.length) {
                  return GridItem.empty(id: id);
                }

                final type = GridItemType.values[typeIndex];

                // 타입에 따른 GridItem 반환
                switch (type) {
                  case GridItemType.empty:
                    return GridItem.empty(id: id);

                  case GridItemType.sentence:
                    if (itemJson.containsKey('sentenceContent')) {
                      return GridItem.sentence(
                        id: id,
                        sentence: Sentence(
                          id: itemJson['sentenceId'] ?? 0,
                          content: itemJson['sentenceContent'] ?? '',
                          isPublic: itemJson['sentenceIsPublic'] ?? false,
                          createdAt: itemJson['sentenceCreatedAt'] ??
                              DateTime.now().toIso8601String(),
                          updatedAt: itemJson['sentenceUpdatedAt'] ??
                              DateTime.now().toIso8601String(),
                        ),
                      );
                    }
                    break;

                  case GridItemType.bookReview:
                    if (itemJson.containsKey('bookReviewData')) {
                      final reviewData =
                          itemJson['bookReviewData'] as Map<String, dynamic>;
                      return GridItem.bookReview(
                        id: id,
                        bookReview: Review(
                          id: reviewData['id'] ?? 0,
                          bookIsbn: reviewData['bookIsbn'] ?? '',
                          bookTitle: reviewData['bookTitle'] ?? '',
                          content: reviewData['content'] ?? '',
                          isPublic: reviewData['isPublic'] ?? false,
                          createdAt: reviewData['createdAt'] ??
                              DateTime.now().toIso8601String(),
                          updatedAt: reviewData['updatedAt'] ??
                              DateTime.now().toIso8601String(),
                          thumbnail: reviewData['thumbnail'],
                        ),
                      );
                    } else if (itemJson.containsKey('bookIsbn') &&
                        itemJson.containsKey('bookTitle')) {
                      // 대체 형식 지원
                      return GridItem.bookReview(
                        id: id,
                        bookReview: Review(
                          id: itemJson['reviewId'] ?? 0,
                          bookIsbn: itemJson['bookIsbn'] ?? '',
                          bookTitle: itemJson['bookTitle'] ?? '',
                          content: itemJson['reviewContent'] ?? '',
                          isPublic: itemJson['reviewIsPublic'] ?? false,
                          thumbnail: itemJson['bookThumbnail'],
                        ),
                      );
                    }
                    break;

                  case GridItemType.music:
                    if (itemJson.containsKey('trackData')) {
                      try {
                        final trackData =
                            itemJson['trackData'] as Map<String, dynamic>;
                        final track = Track.fromJson(trackData);
                        return GridItem.music(id: id, track: track);
                      } catch (error) {
                        debugPrint('[Track 변환 오류] error: $error');

                        // 에러 발생 시 기본 정보로 설정
                        final track = Track();
                        if (itemJson.containsKey('trackName')) {
                          track.name = itemJson['trackName'];
                        }
                        if (itemJson.containsKey('trackId')) {
                          track.id = itemJson['trackId'];
                        }
                        if (itemJson.containsKey('trackUri')) {
                          track.uri = itemJson['trackUri'];
                        }

                        return GridItem.music(id: id, track: track);
                      }
                    } else if (itemJson.containsKey('trackName')) {
                      // 대체 형식 지원
                      final track = Track();
                      track.name = itemJson['trackName'];
                      track.id = itemJson['trackId'];
                      track.uri = itemJson['trackUri'];

                      if (itemJson.containsKey('albumImageUrl')) {
                        track.album = AlbumSimple();
                        track.album!.images = [];
                        track.album!.images![0].url = itemJson['albumImageUrl'];
                      }

                      return GridItem.music(id: id, track: track);
                    }
                    break;

                  case GridItemType.image:
                    if (itemJson.containsKey('imagePath')) {
                      try {
                        final imagePath = itemJson['imagePath'] as String;
                        return GridItem.image(
                          id: id,
                          imagePath: imagePath,
                        );
                      } catch (error) {
                        debugPrint('[imagePath 생성 오류] error: $error');
                      }
                    }
                    break;
                }

                // 타입별 처리가 실패하면 GridItem empty로 기본값 반환
                return GridItem.empty(id: id);
              } catch (error) {
                debugPrint('[그리드 아이템 변환 오류] error: $error');
                // 변환 오류 발생 시 기본값 반환
                return GridItem.empty(
                  id: 'item_${vertIndex}_$horizIndex',
                );
              }
            },
          ),
        );

        state = GridState(items: items); // 상태 업데이트
        debugPrint('[Grid 데이터 로드 완료] key: $key');
      } catch (error) {
        state = GridState.initial(); // 변환 오류 발생 시 기본값 사용
        debugPrint('[Grid 데이터 변환 중 오류 발생 -> 로드 실패] error: $error');
      }
    } else {
      state = GridState.initial(); // 해당 PeriodType/날짜의 데이터가 없으면 기본값 사용
      debugPrint('[Grid 데이터 없을 때 기본 데이터 사용] key: $key');
    }
  }

  /// 문장 타입으로 변경 및 데이터 설정
  void setSentence(int verticalIndex, int horizontalIndex, Sentence sentence) {
    final currentItem = state.items[verticalIndex][horizontalIndex];
    final updatedItem = currentItem.copyWith(
      type: GridItemType.sentence,
      sentence: sentence,
    );
    updateGridItem(verticalIndex, horizontalIndex, updatedItem);
  }

  /// 책 타입으로 변경 및 데이터 설정
  void setBook(int verticalIndex, int horizontalIndex, Review bookReview) {
    final currentItem = state.items[verticalIndex][horizontalIndex];
    final updatedItem = currentItem.copyWith(
      type: GridItemType.bookReview,
      bookReview: bookReview,
    );
    updateGridItem(verticalIndex, horizontalIndex, updatedItem);
  }

  /// 음악 타입으로 변경 및 데이터 설정
  void setMusic(int verticalIndex, int horizontalIndex, Track track) {
    final currentItem = state.items[verticalIndex][horizontalIndex];
    final updatedItem = currentItem.copyWith(
      type: GridItemType.music,
      track: track,
    );
    updateGridItem(verticalIndex, horizontalIndex, updatedItem);
  }

  /// 이미지 타입으로 변경 및 데이터 설정
  void setImage(int verticalIndex, int horizontalIndex, String imagePath) {
    final currentItem = state.items[verticalIndex][horizontalIndex];
    final updatedItem = currentItem.copyWith(
      type: GridItemType.image,
      imagePath: imagePath,
    );
    updateGridItem(verticalIndex, horizontalIndex, updatedItem);
  }

  /// 그리드 아이템 초기화
  void clearItem(int verticalIndex, int horizontalIndex) {
    final id = state.items[verticalIndex][horizontalIndex].id;

    updateGridItem(
      verticalIndex,
      horizontalIndex,
      GridItem.empty(id: id),
    );
  }
}
