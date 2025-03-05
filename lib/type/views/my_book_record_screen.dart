import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:typed/type/models/book_model.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/review/model/review_model.dart';
import 'package:typed/type/models/grid_item.dart';
import 'package:typed/type/views/layout/my_record_layout.dart';
import 'package:typed/type/views/component/search_text_button.dart';
import 'package:typed/config/env.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

final dummyReviews = [
  Review(
    id: 1,
    bookIsbn: '9788966262281',
    bookTitle:
        'exercitation est cupidatat consequat incididunt veniam reprehenderit pariatur sit proident adipisicing magna. Anim nisi nostrud cupidatat et eu voluptate tempor id. Do magna incididunt nostrud minim labore officia nulla esse enim.',
    content:
        '플러터가 처음이라 걱정했는데 이 책으로 기초부터 차근차근 배울 수 있었습니다. 예제가 많고 설명이 친절해서 좋았어요. 특히 상태 관리와 레이아웃 부분이 명확해서 도움이 많이 됐습니다.',
    isPublic: false, // 비공개
    createdAt: '2024-03-01T10:30:00',
    updatedAt: '2024-03-01T10:30:00',
    thumbnail:
        'https://i.pinimg.com/474x/df/f8/f3/dff8f3889738dffd7813aeaf2601e2dc.jpg',
  ),
  Review(
    id: 2,
    bookIsbn: '9788966262282',
    bookTitle: '리버팟 마스터하기',
    content:
        '리버팟 상태 관리에 대해 자세히 설명해주는 책입니다. 다양한 프로바이더 유형과 활용 방법을 알려주고 있어서 앱 구조 설계에 많은 도움이 됐어요. 특히 비동기 데이터 처리 부분이 인상적이었습니다.',
    isPublic: false, // 비공개
    createdAt: '2024-02-15T15:20:00',
    updatedAt: '2024-02-15T15:20:00',
    thumbnail:
        'https://i.pinimg.com/474x/02/87/c0/0287c0e99ef7d8e5558a2e30c5b79460.jpg',
  ),
  Review(
    id: 3,
    bookIsbn: '9788966262283',
    bookTitle: '모바일 앱 디자인 패턴',
    content:
        '이 책은 Flutter에서 적용할 수 있는 다양한 디자인 패턴을 소개하고 있습니다. MVVM, Repository 패턴부터 Clean Architecture까지 실전적인 코드와 함께 설명해주어 코드 구조를 개선하는데 큰 도움이 되었습니다.',
    isPublic: true, // 공개
    createdAt: '2024-01-20T09:10:00',
    updatedAt: '2024-01-20T09:10:00',
    thumbnail:
        'https://i.pinimg.com/474x/9a/2a/57/9a2a574f6ae34b54d8d32b5d407aa34e.jpg',
  ),
  Review(
    id: 4,
    bookIsbn: '9788966262284',
    bookTitle: '다트 프로그래밍',
    content:
        '다트 언어의 기초부터 고급 기능까지 체계적으로 설명하는 책입니다. 널 세이프티, 비동기 프로그래밍, 컬렉션 API 등을 잘 설명해줘서 플러터 개발에 큰 도움이 됩니다.',
    isPublic: true, // 공개
    createdAt: '2024-01-05T18:40:00',
    updatedAt: '2024-01-05T18:40:00',
    thumbnail: 'https://via.placeholder.com/150x200',
  ),
  Review(
    id: 5,
    bookIsbn: '9788966262285',
    bookTitle: '실전 플러터 앱 개발',
    content:
        '처음부터 끝까지 실제 앱을 만들어보는 과정을 담고 있어 매우 유익했다. 특히 상태 관리 부분에서 다양한 방법을 비교하며 설명하는 점이 좋았다.',
    isPublic: false,
    createdAt: '2024-03-10T09:15:00',
    updatedAt: '2024-03-10T09:15:00',
    thumbnail:
        'https://i.pinimg.com/474x/93/2a/2a/932a2ae69b7a98ef14cea688c73ce458.jpg',
  ),
  Review(
    id: 6,
    bookIsbn: '9788966262286',
    bookTitle: '플러터와 파이어베이스',
    content:
        '파이어베이스 연동 방법을 아주 자세히 설명하고 있다. 인증, 실시간 데이터베이스, 클라우드 함수 등 모든 영역을 다루고 있어서 백엔드 없이도 완성도 높은 앱을 만들 수 있게 됐다. 코드 예제도 최신 버전으로 업데이트되어 있어 바로 적용 가능하다.',
    isPublic: false,
    createdAt: '2024-02-28T14:20:00',
    updatedAt: '2024-02-28T14:20:00',
    thumbnail: 'https://via.placeholder.com/150x200',
  ),
  Review(
    id: 7,
    bookIsbn: '9788966262287',
    bookTitle: '플러터 UI 디자인',
    content: '다양한 UI 컴포넌트 구현 방법을 배울 수 있어 좋았다.',
    isPublic: false,
    createdAt: '2024-02-20T11:30:00',
    updatedAt: '2024-02-20T11:30:00',
    thumbnail:
        'https://i.pinimg.com/474x/92/b7/10/92b7103ca7aba930a09c3b55202e10cb.jpg',
  ),
  Review(
    id: 8,
    bookIsbn: '9788966262288',
    bookTitle: '플러터로 만드는 크로스플랫폼 앱',
    content:
        '안드로이드와 iOS 뿐만 아니라 웹, 데스크톱까지 한 번에 개발하는 방법을 설명하는 책이다. 플랫폼별 차이점과 대응 방법을 잘 설명해주어 멀티플랫폼 개발에 큰 도움이 된다.',
    isPublic: false,
    createdAt: '2024-02-18T16:45:00',
    updatedAt: '2024-02-18T16:45:00',
    thumbnail: 'https://via.placeholder.com/150x200',
  ),
  Review(
    id: 9,
    bookIsbn: '9788966262289',
    bookTitle: '플러터 상태 관리의 모든 것',
    content:
        'Provider, Riverpod, Bloc, GetX 등 다양한 상태 관리 라이브러리를 비교 분석하고 각각의 장단점과 적합한 사용 사례를 설명하고 있어 프로젝트에 맞는 상태 관리 방식을 선택하는데 큰 도움이 됐다. 특히 복잡한 앱 구조에서 각 라이브러리별 성능 비교 데이터가 있어 의사결정에 도움이 많이 됐다. 예제 코드도 깔끔해서 바로 적용해볼 수 있었다.',
    isPublic: false,
    createdAt: '2024-02-15T13:20:00',
    updatedAt: '2024-02-15T13:20:00',
    thumbnail:
        'https://i.pinimg.com/474x/79/b7/b2/79b7b21ae23ba9bf90fbf3a7989a7d4e.jpg',
  ),
  Review(
    id: 10,
    bookIsbn: '9788966262290',
    bookTitle: '플러터 성능 최적화',
    content: '앱 성능을 극대화하는 다양한 기법을 배울 수 있었다. 특히 빌드 메소드 최적화와 이미지 캐싱 부분이 유용했다.',
    isPublic: false,
    createdAt: '2024-02-10T10:10:00',
    updatedAt: '2024-02-10T10:10:00',
    thumbnail:
        'https://i.pinimg.com/474x/d8/bc/5d/d8bc5d82d63a0ed209c3df236744a9ea.jpg',
  ),
  Review(
    id: 11,
    bookIsbn: '9788966262291',
    bookTitle: '플러터 테스팅 가이드',
    content:
        '단위 테스트, 위젯 테스트, 통합 테스트를 체계적으로 작성하는 방법을 알려준다. 테스트 주도 개발(TDD)을 플러터에 적용하는 방법도 상세히 설명해주어 코드 품질을 높이는데 큰 도움이 됐다. 실무에서 바로 적용할 수 있는 실용적인 팁들이 많아서 좋았다.',
    isPublic: false,
    createdAt: '2024-02-05T09:30:00',
    updatedAt: '2024-02-05T09:30:00',
    thumbnail:
        'https://i.pinimg.com/474x/71/3b/05/713b05fc12d8cf1e26dc425462584e98.jpg',
  ),
  Review(
    id: 12,
    bookIsbn: '9788966262292',
    bookTitle: '다트 언어 심화',
    content:
        '다트 언어의 고급 기능인 제네릭, 컬렉션, 스트림, 직렬화 등을 자세히 다루고 있다. 특히 비동기 프로그래밍 부분이 실무에 많은 도움이 됐다.',
    isPublic: false,
    createdAt: '2024-01-25T14:50:00',
    updatedAt: '2024-01-25T14:50:00',
    thumbnail:
        'https://i.pinimg.com/474x/a2/d4/a2/a2d4a205e1ca38bbd098be93ef752c40.jpg',
  ),
  Review(
    id: 13,
    bookIsbn: '9788966262293',
    bookTitle: '플러터 애니메이션 마스터하기',
    content:
        '다양한 애니메이션 효과를 구현하는 방법을 배울 수 있어서 UI/UX를 크게 개선할 수 있었다. 기본 애니메이션부터 복잡한 히어로 애니메이션까지 단계별로 설명이 잘 되어있어 쉽게 따라할 수 있었다.',
    isPublic: false,
    createdAt: '2024-01-20T11:40:00',
    updatedAt: '2024-01-20T11:40:00',
    thumbnail:
        'https://i.pinimg.com/474x/f2/83/a7/f283a7b55a4085e7a9b9e206b0e4f4b8.jpg',
  ),
  Review(
    id: 14,
    bookIsbn: '9788966262294',
    bookTitle: '플러터와 클린 아키텍처',
    content:
        '클린 아키텍처 원칙을 플러터 프로젝트에 적용하는 방법을 상세히 설명하고 있다. 도메인 주도 설계(DDD)와 함께 실제 프로젝트 구조를 설계하는 과정이 매우 유익했다. 대규모 프로젝트를 위한 폴더 구조와 코드 구성 방법도 배울 수 있어 좋았다. SOLID 원칙을 플러터에 적용하는 실용적인 예제가 많아 코드 품질을 높이는데 큰 도움이 됐다.',
    isPublic: false,
    createdAt: '2024-01-15T15:30:00',
    updatedAt: '2024-01-15T15:30:00',
    thumbnail:
        'https://i.pinimg.com/474x/58/86/b7/5886b7da6c229e0774d8f8c69b96cc42.jpg',
  ),
  Review(
    id: 15,
    bookIsbn: '9788966262295',
    bookTitle: '플러터 2.0 완벽 가이드',
    content:
        '플러터 2.0의 새로운 기능과 변경사항을 체계적으로 설명하고 있다. 널 세이프티 적용 방법부터 웹 지원 기능까지 모든 내용을 다루고 있어 매우 유익했다. 특히 마이그레이션 가이드가 큰 도움이 됐다.',
    isPublic: true,
    createdAt: '2024-03-12T10:20:00',
    updatedAt: '2024-03-12T10:20:00',
    thumbnail:
        'https://i.pinimg.com/474x/49/c1/08/49c1087c7ceccc3623f174df88e8db9c.jpg',
  ),
  Review(
    id: 16,
    bookIsbn: '9788966262296',
    bookTitle: '플러터 네이티브 기능 연동하기',
    content:
        '플랫폼 채널을 활용해 네이티브 기능을 연동하는 방법을 배울 수 있었다. 카메라, 센서, 파일 시스템 등 다양한 예제로 설명해주어 이해하기 쉬웠다.',
    isPublic: true,
    createdAt: '2024-03-05T09:15:00',
    updatedAt: '2024-03-05T09:15:00',
    thumbnail:
        'https://i.pinimg.com/474x/31/6d/af/316daf65fbcbe09bd045cb3d1826f3cb.jpg',
  ),
  Review(
    id: 17,
    bookIsbn: '9788966262297',
    bookTitle: '플러터 고급 UI 패턴',
    content:
        '복잡한 UI 구현을 위한 다양한 디자인 패턴을 소개하고 있다. 반응형 레이아웃, 커스텀 페인팅, 제스처 처리 등 심화 내용을 다루고 있어 UI 개발 실력을 한 단계 높일 수 있었다. 특히 슬리버(Sliver) 위젯을 활용한 고급 스크롤 효과 구현 방법이 인상적이었다. 실무에서 자주 사용되는 복잡한 UI 구현 방법을 단계별로 설명해주어 매우 유용했다.',
    isPublic: true,
    createdAt: '2024-02-28T16:40:00',
    updatedAt: '2024-02-28T16:40:00',
    thumbnail:
        'https://i.pinimg.com/474x/ea/2e/9d/ea2e9d0945cbd8b2cc6cc864959a7bfb.jpg',
  ),
  Review(
    id: 18,
    bookIsbn: '9788966262298',
    bookTitle: '플러터 앱 출시 가이드',
    content:
        '앱 스토어와 구글 플레이 스토어에 앱을 출시하는 전 과정을 상세히 다루고 있다. 앱 서명, 심사 준비, 스크린샷 제작, ASO 최적화까지 필요한 모든 정보를 담고 있어 실제 출시에 큰 도움이 됐다.',
    isPublic: true,
    createdAt: '2024-02-25T11:30:00',
    updatedAt: '2024-02-25T11:30:00',
    thumbnail:
        'https://i.pinimg.com/474x/8d/72/c4/8d72c4de4f0459acc430b126fd8f590e.jpg',
  ),
  Review(
    id: 19,
    bookIsbn: '9788966262299',
    bookTitle: '플러터 머티리얼 디자인 3',
    content: '머티리얼 디자인 3을 플러터에 적용하는 방법을 배울 수 있었다. 테마 시스템과 다크 모드 지원이 특히 유용했다.',
    isPublic: true,
    createdAt: '2024-02-20T14:10:00',
    updatedAt: '2024-02-20T14:10:00',
    thumbnail:
        'https://i.pinimg.com/736x/3c/66/b9/3c66b972f6df9ae679aaad2acbc19799.jpg',
  ),
  Review(
    id: 20,
    bookIsbn: '9788966262300',
    bookTitle: '플러터 HTTP 통신과 REST API',
    content:
        '서버와의 통신을 위한 다양한 방법을 다루고 있다. HTTP 클라이언트 사용법부터 JWT 인증, 캐싱, 오류 처리까지 실무에 필요한 모든 내용을 배울 수 있었다. Dio 라이브러리를 활용한 예제가 특히 유용했다. REST API 디자인 패턴과 인터셉터 활용법도 상세히 설명해주어 서버 통신 코드의 품질을 크게 개선할 수 있었다.',
    isPublic: true,
    createdAt: '2024-02-15T10:50:00',
    updatedAt: '2024-02-15T10:50:00',
    thumbnail:
        'https://i.pinimg.com/474x/d5/09/a2/d509a27c5ce075737ee185f15f2dbabc.jpg',
  ),
  Review(
    id: 21,
    bookIsbn: '9788966262301',
    bookTitle: '플러터 CI/CD 구축하기',
    content:
        '지속적 통합/배포 파이프라인을 구축하는 방법을 배울 수 있었다. GitHub Actions, Codemagic, Fastlane 등 다양한 도구를 활용한 자동화 방법을 설명해주어 개발 생산성을 크게 높일 수 있었다.',
    isPublic: true,
    createdAt: '2024-02-10T13:20:00',
    updatedAt: '2024-02-10T13:20:00',
    thumbnail:
        'https://i.pinimg.com/474x/91/af/71/91af71562db11ff2cc7a17cfdfdade68.jpg',
  ),
  Review(
    id: 22,
    bookIsbn: '9788966262302',
    bookTitle: '플러터 상태 관리 실전 가이드',
    content:
        '실제 프로젝트에서 상태 관리를 어떻게 적용하는지 단계별로 설명하고 있다. 특히 대규모 앱에서의 상태 관리 아키텍처 설계가 매우 유익했다.',
    isPublic: true,
    createdAt: '2024-02-05T15:40:00',
    updatedAt: '2024-02-05T15:40:00',
    thumbnail:
        'https://i.pinimg.com/474x/83/6b/86/836b86762100f078fc013ac1354b4caf.jpg',
  ),
  Review(
    id: 23,
    bookIsbn: '9788966262303',
    bookTitle: '플러터로 만드는 반응형 웹',
    content:
        '플러터 웹을 활용해 반응형 웹사이트를 개발하는 방법을 상세히 다루고 있다. 다양한 화면 크기에 대응하는 레이아웃 설계부터 웹 최적화 기법까지 배울 수 있어 매우 유익했다. 특히 LayoutBuilder와 MediaQuery를 활용한 반응형 디자인 패턴이 실무에 큰 도움이 됐다. 웹 특화 위젯과 브라우저 API 활용법도 자세히 설명해주어 플러터 웹 개발 역량을 크게 키울 수 있었다.',
    isPublic: true,
    createdAt: '2024-01-25T09:30:00',
    updatedAt: '2024-01-25T09:30:00',
    thumbnail:
        'https://i.pinimg.com/474x/7f/9a/6d/7f9a6d50e04f6aee0f9042a138769da7.jpg',
  ),
  Review(
    id: 24,
    bookIsbn: '9788966262304',
    bookTitle: '플러터 데이터베이스 프로그래밍',
    content:
        'SQLite, Hive, Isar 등 다양한 로컬 데이터베이스를 플러터에서 활용하는 방법을 배울 수 있었다. 특히 복잡한 데이터 모델링과 CRUD 구현 예제가 실무에 바로 적용할 수 있어 유용했다.',
    isPublic: true,
    createdAt: '2024-01-20T14:15:00',
    updatedAt: '2024-01-20T14:15:00',
    thumbnail:
        'https://i.pinimg.com/474x/13/0e/ba/130eba89e7c4b1f4b3c2d8b67a81dc13.jpg',
  ),
];

class MyBookRecordScreen extends StatefulWidget {
  final GridItem? item;

  const MyBookRecordScreen({
    this.item,
    super.key,
  });

  @override
  State<MyBookRecordScreen> createState() => _MyBookRecordScreenState();
}

class _MyBookRecordScreenState extends State<MyBookRecordScreen> {
  static const String _apiKey = Env.kakaoRestApiKey;

  // TODO: - private
  List<Book> searchResults = [];
  bool isLoading = false;
  final searchController = TextEditingController();

  Book? selectedBook;
  List<Book> currentBooks = [];

  @override
  void initState() {
    super.initState();

    if (widget.item != null && widget.item!.isValid && widget.item!.isBook) {
      // TODO: - 타입을 다 만들어야 하나?
      final book = widget.item!.book!;
      selectedBook = book;
      currentBooks.add(book);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyRecordLayout(
      onBottomLeftWidgetPressed: () => Navigator.pop(context),
      onBottomRightWidgetPressed: () =>
          selectedBook != null ? pushMyTypeScreen() : null,
      bottomCenterWidget: _renderBottomCenterWidget(),
      body: [
  // TODO: - common으로 빼기
  Widget _buildPlaceholder() {
    return Center(
      child: Image.asset(
        'assets/images/grid_item_placeholder.png',
        width: MediaQuery.of(context).size.width * 0.1,
        height: MediaQuery.of(context).size.width * 0.1,
        fit: BoxFit.contain,
      ),
    );
  }

class BookReviewWidget extends StatelessWidget {
  final Review item;
  final VoidCallback onTap;
  final bool isSelected;
  final Widget placeholder;

  const BookReviewWidget({
    required this.item,
    required this.onTap,
    required this.isSelected,
    required this.placeholder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.borderBlack,
            // width: 0.3,
            // width: selectedBookIndex == index ? 0.6 : 0.3,
            width: isSelected ? 0.6 : 0.3,
          ),
          color: AppColors.backgroundTertiary,
        ),
        child: item.thumbnail != null
            ? Image.network(
                item.thumbnail!,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    // if (selectedBookIndex == index) {
                    if (isSelected) {
                      // TODO: - 썸네일 없는 경우
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          child,
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black26,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: AspectRatio(
                              aspectRatio: 1.2,
                              child: Container(
                                width: double.infinity,
                                color: Colors.white54,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.bookTitle,
                                        style: AppTheme.body1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Flexible(
                                        child: Text(
                                          item.content,
                                          style: AppTheme.body3.copyWith(
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return child;
                    }
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.borderBlack,
                      strokeWidth: 3,
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width * 0.06,
                        minHeight: MediaQuery.of(context).size.width * 0.06,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => placeholder,
              )
            : placeholder,
      ),
    );
  }
}
