// Sentence 클래스의 더미 데이터 생성
import 'package:typed/sentence/model/sentence_model.dart';

final List<Sentence> dummySentences = [
  // 한국어 문장 - 다양한 길이
  Sentence(
    content: '오늘은 날씨가 좋다.',
    isPublic: true,
    createdAt: DateTime(2023, 1, 15, 9, 30),
  ),
  Sentence(
    content: '플러터 개발은 재미있다.',
    isPublic: false,
    createdAt: DateTime(2023, 2, 20, 14, 45),
  ),
  Sentence(
    content: '매우 짧은 글.',
    isPublic: true,
    createdAt: DateTime(2023, 3, 5, 18, 10),
  ),
  Sentence(
    content:
        '이것은 한국어로 작성된 매우 긴 문장입니다. 문장의 길이가 극단적으로 길게 작성되어 있으며, 이런 경우 UI 렌더링이나 텍스트 줄바꿈 처리 등을 테스트할 수 있습니다. 실제 앱에서는 이렇게 긴 텍스트가 어떻게 보여지는지, 스크롤은 어떻게 동작하는지 등을 확인하는 데 유용할 수 있습니다. 특히 모바일 기기에서는 화면 크기가 제한적이기 때문에 긴 텍스트의 표시 방법이 중요한 UX 요소 중 하나입니다.',
    isPublic: false,
    createdAt: DateTime(2023, 4, 10, 11, 25),
  ),
  Sentence(
    content: '내일 회의가 있다.',
    isPublic: true,
    createdAt: DateTime(2023, 5, 22, 16, 30),
  ),

  // 영어 문장 - 다양한 길이
  Sentence(
    content: 'Hello, world!',
    isPublic: false,
    createdAt: DateTime(2023, 6, 3, 8, 15),
  ),
  Sentence(
    content: 'Flutter is a cross-platform framework.',
    isPublic: true,
    createdAt: DateTime(2023, 7, 14, 19, 50),
  ),
  Sentence(
    content: 'A', // 극단적으로 짧은 문장
    isPublic: false,
    createdAt: DateTime(2023, 8, 18, 7, 40),
  ),
  Sentence(
    content:
        'This is an extremely long sentence written in English. It is designed to test how the application handles very long text content in different screen sizes and orientations. When developing mobile applications, it is important to consider how text wrapping, scrolling, and overall layout behave with content of varying lengths. This dummy text can help identify potential UI issues before they affect real users. Text rendering performance can also be a concern with very long strings, especially on lower-end devices or when combined with complex animations and other resource-intensive operations.',
    isPublic: true,
    createdAt: DateTime(2023, 9, 29, 13, 5),
  ),
  Sentence(
    content: 'The meeting is scheduled for tomorrow.',
    isPublic: false,
    createdAt: DateTime(2023, 10, 7, 15, 35),
  ),

  // 일본어 문장 - 다양한 길이
  Sentence(
    content: 'こんにちは。',
    isPublic: true,
    createdAt: DateTime(2023, 11, 12, 10, 20),
  ),
  Sentence(
    content: '東京は大きい都市です。',
    isPublic: false,
    createdAt: DateTime(2023, 12, 25, 23, 59),
  ),
  Sentence(
    content: 'あ', // 극단적으로 짧은 문장
    isPublic: true,
    createdAt: DateTime(2024, 1, 1, 0, 0),
  ),
  Sentence(
    content:
        'これは日本語で書かれた非常に長い文章です。文章の長さが極端に長く書かれており、このような場合、UIレンダリングやテキストの折り返し処理などをテストすることができます。実際のアプリでは、このように長いテキストがどのように表示されるか、スクロールはどのように動作するかなどを確認するのに役立ちます。特にモバイル機器では画面サイズが限られているため、長いテキストの表示方法は重要なUX要素の一つです。さまざまな言語をサポートすることは国際的なアプリケーションにとって不可欠であり、特に日本語のような非ラテン文字は特有のレイアウトの課題をもたらすことがあります。',
    isPublic: false,
    createdAt: DateTime(2024, 2, 14, 12, 30),
  ),
  Sentence(
    content: '明日は雨が降るでしょう。',
    isPublic: true,
    createdAt: DateTime(2024, 3, 20, 6, 45),
  ),

  // 혼합된 언어와 특수 문자
  Sentence(
    content: 'Hello 안녕 こんにちは 123!',
    isPublic: false,
    createdAt: DateTime(2024, 4, 5, 17, 22),
  ),
  Sentence(
    content: '特殊記号: !@#\$%^&*()_+{}[]|\\:;"\'<>,.?/~`',
    isPublic: true,
    createdAt: DateTime(2024, 5, 16, 21, 15),
  ),
  Sentence(
    content: 'Flutter & Dart programming 프로그래밍 プログラミング',
    isPublic: false,
    createdAt: DateTime(2024, 6, 30, 4, 50),
  ),
  Sentence(
    content: 'Emojis: 😀🚀💻🎉🔥👍👎🎯🌍💡',
    isPublic: true,
    createdAt: DateTime(2022, 7, 9, 9, 0), // 과거 날짜
  ),
  Sentence(
    content: 'URL: https://flutter.dev and email: example@flutter.io',
    isPublic: false,
    createdAt: DateTime(2022, 8, 17, 13, 40), // 과거 날짜
  ),

  // 최신 및 미래 날짜
  Sentence(
    content: '이것은 가장 최근에 작성된 문장입니다.',
    isPublic: true,
    createdAt: DateTime.now(),
  ),
  Sentence(
    content: 'This is scheduled for the future.',
    isPublic: false,
    createdAt: DateTime.now().add(Duration(days: 30)), // 미래 날짜
  ),

  // 공백과 특수 케이스
  Sentence(
    content: '   앞에 공백이 있는 문장   ',
    isPublic: true,
    createdAt: DateTime(2023, 9, 3, 15, 10),
  ),
  Sentence(
    content: '\n줄바꿈이\n포함된\n문장\n',
    isPublic: false,
    createdAt: DateTime(2023, 10, 22, 8, 5),
  ),
  Sentence(
    content: '', // 빈 문자열
    isPublic: true,
    createdAt: DateTime(2023, 11, 30, 19, 25),
  ),

  // 다양한 시간대의 데이터
  Sentence(
    content: '심야에 작성된 문장',
    isPublic: false,
    createdAt: DateTime(2024, 1, 15, 3, 21), // 새벽 3시
  ),
  Sentence(
    content: 'Sentence created at noon',
    isPublic: true,
    createdAt: DateTime(2024, 2, 28, 12, 0), // 정오
  ),

  // 더 다양한 경우
  Sentence(
    content: '숫자만: 12345678900987654321',
    isPublic: false,
    createdAt: DateTime(2022, 3, 8, 14, 30), // 더 오래된 날짜
  ),
  Sentence(
    content: 'HTML태그: <h1>제목</h1><p>내용</p>',
    isPublic: true,
    createdAt: DateTime(2022, 4, 18, 11, 11), // 더 오래된 날짜
  ),
  Sentence(
    content: 'JSON형식: {"name":"Flutter","version":"3.0"}',
    isPublic: false,
    createdAt: DateTime(2022, 5, 24, 16, 50), // 더 오래된 날짜
  ),
  Sentence(
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    isPublic: true,
    createdAt: DateTime(2022, 6, 12, 20, 40), // 더 오래된 날짜
  ),

  // 추가 데이터로 총 40개 맞추기
  Sentence(
    content: '실전 Flutter 개발에서는 상태 관리가 매우 중요하다.',
    isPublic: false,
    createdAt: DateTime(2023, 11, 5, 17, 30),
  ),
  Sentence(
    content: 'Developer experience matters.',
    isPublic: true,
    createdAt: DateTime(2024, 2, 10, 9, 45),
  ),
  Sentence(
    content: 'アプリ開発は楽しいです。',
    isPublic: false,
    createdAt: DateTime(2024, 1, 7, 14, 20),
  ),
  Sentence(
    content: '오늘의 할 일: 1. 코딩 2. 테스트 3. 배포',
    isPublic: true,
    createdAt: DateTime(2023, 8, 30, 8, 0),
  ),
  Sentence(
    content: 'The quick brown fox jumps over the lazy dog.',
    isPublic: false,
    createdAt: DateTime(2023, 6, 19, 19, 15),
  ),
  Sentence(
    content: '百聞は一見に如かず。',
    isPublic: true,
    createdAt: DateTime(2023, 4, 3, 12, 50),
  ),
  Sentence(
    content: '이 문장은 정확히 40자로 이루어진 한국어 문장입니다......',
    isPublic: false,
    createdAt: DateTime(2023, 2, 8, 15, 25),
  ),
  Sentence(
    content: 'This is exactly a forty-character sentence..',
    isPublic: true,
    createdAt: DateTime(2022, 12, 4, 11, 35),
  ),
];
