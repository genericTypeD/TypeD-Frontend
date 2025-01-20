import 'package:flutter/material.dart';
import 'package:typed/common/layout/default_layout.dart';
import 'package:typed/common/const/app_colors.dart';
import 'package:typed/common/const/app_themes.dart';
import 'package:multi_split_view/multi_split_view.dart';

final List<String> rockGenres = [
  '하드록(Hard Rock): 강력한 기타 리프와 파워풀한 드럼이 특징이며, Led Zeppelin, Deep Purple 등이 대표적인 밴드입니다. 하드록은 블루스와 록앤롤의 영향을 받아 탄생했으며, 기타 솔로와 헤비한 드럼 비트가 핵심입니다. 대표곡으로는 Led Zeppelin의 "Stairway to Heaven", Deep Purple의 "Smoke on the Water"가 있습니다.',
  '프로그레시브 록(Progressive Rock): 복잡한 곡 구조와 긴 연주 시간이 특징이며, Pink Floyd, Yes 등이 이 장르를 대표합니다. 클래식 음악과 재즈의 영향을 받은 프로그레시브 록은 개념 앨범과 테마 중심의 곡들이 많습니다. Pink Floyd의 "The Dark Side of the Moon"과 Yes의 "Close to the Edge"가 대표적인 예입니다.',
  '펑크 록(Punk Rock): 단순하고 거친 사운드와 반항적인 가사가 특징이며, Ramones, Sex Pistols가 대표적입니다. 펑크 록은 1970년대 중반에 등장하여 사회적 불만과 청년 문화의 반항심을 표현했습니다. Ramones의 "Blitzkrieg Bop"과 Sex Pistols의 "Anarchy in the UK"가 잘 알려져 있습니다.',
  '그런지(Grunge): 90년대 시애틀에서 시작된 장르로, 무겁고 어두운 사운드가 특징이며 Nirvana, Pearl Jam이 유명합니다. 그런지는 하드록과 펑크의 융합으로 탄생했으며, 감정적으로 솔직한 가사와 왜곡된 기타 톤이 두드러집니다. Nirvana의 "Smells Like Teen Spirit"과 Pearl Jam의 "Alive"가 대표곡으로 꼽힙니다.',
  '글램 록(Glam Rock): 화려한 의상과 메이크업, 캐치한 멜로디가 특징이며 David Bowie, T.Rex가 대표적입니다. 글램 록은 1970년대 초반에 등장하여 무대 위 퍼포먼스와 시각적 화려함에 중점을 두었습니다. David Bowie의 "Ziggy Stardust"와 T.Rex의 "Get It On"이 이 장르의 상징적인 곡들입니다.',
  '얼터너티브 록(Alternative Rock): 메인스트림 록에서 벗어난 실험적인 사운드가 특징이며, R.E.M., Radiohead 등이 있습니다. 1980년대와 1990년대에 걸쳐 주목받은 이 장르는 전통적인 록에 대한 독창적인 변형으로 가득합니다. R.E.M.의 "Losing My Religion"과 Radiohead의 "Creep"이 대표곡입니다.',
  '포스트 록(Post-Rock): 전통적인 록의 구조를 벗어나 실험적이고 대기적인 사운드를 추구하며, Godspeed You! Black Emperor가 대표적입니다. 포스트 록은 보컬보다 악기 연주에 초점을 맞추며, 종종 긴 곡의 형식을 띕니다. Godspeed You! Black Emperor의 "Storm"과 Explosions in the Sky의 "Your Hand in Mine"이 유명합니다.',
  '사이키델릭 록(Psychedelic Rock): 환각적이고 몽환적인 사운드가 특징이며, Pink Floyd 초기작과 Jefferson Airplane이 유명합니다. 이 장르는 1960년대의 히피 문화와 밀접하게 관련되어 있으며, 독특한 스튜디오 효과와 긴 즉흥 연주가 포함됩니다. Pink Floyd의 "Interstellar Overdrive"와 Jefferson Airplane의 "White Rabbit"이 대표적입니다.',
  '서던 록(Southern Rock): 미국 남부의 정서가 담긴 블루스 기반 록으로, Lynyrd Skynyrd, The Allman Brothers Band가 대표적입니다. 서던 록은 강렬한 기타 연주와 블루스, 컨트리 음악의 영향을 결합한 장르입니다. Lynyrd Skynyrd의 "Sweet Home Alabama"과 The Allman Brothers Band의 "Ramblin’ Man"이 이 장르의 대표곡입니다.',
  '가라지 록(Garage Rock): 거칠고 로우파이한 사운드가 특징이며, The White Stripes, The Strokes 등이 현대적 해석을 보여줍니다. 1960년대의 미국에서 시작된 가라지 록은 DIY 정신이 강하며, 간단한 코드 진행과 에너지 넘치는 퍼포먼스가 특징입니다. The White Stripes의 "Seven Nation Army"과 The Strokes의 "Last Nite"가 이 장르의 상징적인 곡들입니다.',
];

class MyType extends StatefulWidget {
  @override
  State<MyType> createState() => _MyTypeState();
}

class _MyTypeState extends State<MyType> {
  final MultiSplitViewController _verticalController =
      MultiSplitViewController();
  final List<MultiSplitViewController> _horizontalControllers =
      List.generate(3, (_) => MultiSplitViewController());
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      final double screenWidth = MediaQuery.of(context).size.width;
      final double contentHeight = MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top -
          kToolbarHeight -
          kBottomNavigationBarHeight -
          MediaQuery.of(context).padding.bottom;

      _verticalController.areas = List.generate(
        3,
        (index) => Area(
          data: index,
          size: contentHeight / 3,
          min: contentHeight * 0.2,
          max: contentHeight * 0.5,
        ),
      );

      for (var i = 0; i < 3; i++) {
        _horizontalControllers[i].areas = List.generate(
          2,
          (index) => Area(
            data: rockGenres[i * 2 + index],
            size: (screenWidth - 16) / 2,
            min: screenWidth * 0.3,
            max: screenWidth * 0.7,
          ),
        );
      }
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return DefaultLayout(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: MultiSplitViewTheme(
            data: MultiSplitViewThemeData(
              dividerThickness: 5,
              dividerPainter: DividerPainter(
                backgroundColor: Colors.transparent,
                highlightedBackgroundColor: AppColors.LineTertiary,
                animationEnabled: true,
              ),
            ),
            child: MultiSplitView(
              controller: _verticalController,
              axis: Axis.vertical,
              resizable: true,
              antiAliasingWorkaround: true,
              builder: (context, verticalArea) {
                final verticalIndex = verticalArea.data as int;
                return MultiSplitView(
                  controller: _horizontalControllers[verticalIndex],
                  resizable: true,
                  antiAliasingWorkaround: true,
                  builder: (context, horizontalArea) {
                    return _GridTextElement(
                      key: ValueKey('${verticalIndex}_${horizontalArea.index}'),
                      title: '올해의 문장',
                      content: horizontalArea.data as String,
                      width: horizontalArea.size ?? screenWidth / 2,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _verticalController.dispose();
    for (var controller in _horizontalControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

class _GridTextElement extends StatelessWidget {
  final String title;
  final String content;
  final double width;

  const _GridTextElement({
    required this.title,
    required this.content,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.blackPrimary,
          ),
        ),
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: AppTheme.heading3,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    content,
                    style: AppTheme.body3,
                    overflow: TextOverflow.clip,
                    softWrap: true,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GridImageElement extends StatelessWidget {
  final String title;

  const _GridImageElement({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundTertiary,
          borderRadius: BorderRadius.circular(16),
        ),
        height: double.infinity,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                title,
                style: AppTheme.heading3,
              ),
              // Expanded(
              //   child: Text(
              //     '${content}',
              //     style: AppTheme.body3,
              //     // overflow: TextOverflow.ellipsis,
              //   ),
              // ),
              Image.asset('assets/images/sample_book_image.png'),
            ],
          ),
        ),
      ),
    );
  }
}
