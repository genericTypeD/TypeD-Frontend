import 'package:flutter/material.dart';
import 'package:typed/common/layout/default_layout.dart';
import 'package:typed/feed/screen/feed_list_page.dart';
import 'package:typed/menu/screen/my_account.dart';
import 'package:typed/review/screen/reading_empty_page.dart';
import 'package:typed/sentence/screen/empty_page.dart';
import 'package:typed/type/screen/my_type.dart';

class HomeTab extends StatefulWidget {
  static String get routeName => 'home';

  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  late TabController controller;
  int index = 0;

  final List<Widget> _pages = [
    MyType(),
    ReadingEmptyPage(),
    EmptyPage(),
    FeedListPage(),
    MyAccount(),
  ];

  final List<String> _titles = [
    'My Type',
    '서평 메모',
    '문장 수집',
    '취향 탐색',
    '나의 계정',
  ];

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 5, vsync: this);
    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    controller.dispose();
    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: _titles[index],
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFF3F3F2),
        selectedFontSize: 10,
        unselectedFontSize: 10,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          controller.animateTo(index);
        },
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'My type'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: '서평 메모'),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: '문장 수집'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '취향 탐색'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '나의 계정'),
        ],
      ),
    );
  }
}
