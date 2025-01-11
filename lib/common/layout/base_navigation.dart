import 'package:flutter/material.dart';

class BaseNavigation extends StatefulWidget {
  final int initialIndex;
  final List<Widget> pages;
  final List<BottomNavigationBarItem> navItems;
  final String Function(int) appBarTitle;

  const BaseNavigation({
    required this.initialIndex,
    required this.pages,
    required this.navItems,
    required this.appBarTitle,
    Key? key,
  }) : super(key: key);

  @override
  _BaseNavigationState createState() => _BaseNavigationState();
}

class _BaseNavigationState extends State<BaseNavigation> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.appBarTitle(_selectedIndex),
          style: const TextStyle(fontSize: 18),
        ),
        backgroundColor: const Color(0xFFF3F3F2),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: widget.pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFF3F3F2),
        items: widget.navItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
