import 'package:flutter/material.dart';
import 'package:typed/common/layout/default_layout.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:typed/type/component/add_record_dialog.dart';
import 'package:typed/type/component/component.dart';
import 'package:typed/common/widgets/custom_app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplitViewState {
  final List<List<double>> horizontalFlexValues;
  final List<double> verticalFlexValues;
  SplitViewState({
    required this.horizontalFlexValues,
    required this.verticalFlexValues,
  });

  factory SplitViewState.initial() {
    return SplitViewState(
      horizontalFlexValues: List.generate(3, (_) => [1.0, 1.0]),
      verticalFlexValues: List.generate(3, (_) => 1.0),
    );
  }
}

class SplitViewNotifier extends StateNotifier<SplitViewState> {
  SplitViewNotifier() : super(SplitViewState.initial()) {
    _loadFlex();
  }

  Future<void> _loadFlex() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final savedVerticalFlex = prefs.getStringList('vertical_flex');
      final List<List<double>> horizontalFlex = [];
      for (var i = 0; i < 3; i++) {
        final savedHorizontalFlex = prefs.getStringList('horizontal_flex_$i');
        if (savedHorizontalFlex != null) {
          horizontalFlex
              .add(savedHorizontalFlex.map((s) => double.parse(s)).toList());
        }
      }

      if (savedVerticalFlex != null && horizontalFlex.length == 3) {
        state = SplitViewState(
          verticalFlexValues:
              savedVerticalFlex.map((s) => double.parse(s)).toList(),
          horizontalFlexValues: horizontalFlex,
        );
      }
    } catch (e) {
      debugPrint('[Loading Flex Error] $e');
    }
  }

  Future<void> updateVerticalFlex(List<double> flexValues) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
        'vertical_flex',
        flexValues.map((f) => f.toString()).toList(),
      );

      state = SplitViewState(
        horizontalFlexValues: state.horizontalFlexValues,
        verticalFlexValues: flexValues,
      );
    } catch (e) {
      debugPrint('[Updating Vertical Flex Error] $e');
    }
  }

  Future<void> updateHorizontalFlex(int index, List<double> flexValues) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
        'horizontal_flex_$index',
        flexValues.map((f) => f.toString()).toList(),
      );

      final newHorizontalFlex =
          List<List<double>>.from(state.horizontalFlexValues);
      newHorizontalFlex[index] = flexValues;

      state = SplitViewState(
        horizontalFlexValues: newHorizontalFlex,
        verticalFlexValues: state.verticalFlexValues,
      );
    } catch (e) {
      debugPrint('[Saving Horizontal Flex Error] $e');
    }
  }
}

final splitViewProvider =
    StateNotifierProvider<SplitViewNotifier, SplitViewState>((ref) {
  return SplitViewNotifier();
});

class MyType extends StatefulWidget {
  const MyType({super.key});

  @override
  State<MyType> createState() => _MyTypeState();
}

class _MyTypeState extends State<MyType> {
  final List<MultiSplitViewController> _horizontalControllers =
      List.generate(3, (_) => MultiSplitViewController());
  final MultiSplitViewController _verticalController =
      MultiSplitViewController();

  bool _initialized = false;

  List<String> dropDownList = [
    '이주의 나',
    '이달의 나',
    '올해의 나',
  ];
  late String currentDropDown;

  @override
  void initState() {
    super.initState();
    currentDropDown = dropDownList.first;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      _verticalController.areas = List.generate(
        3,
        (index) => Area(
          data: index,
          min: 0.6,
        ),
      );

      for (var i = 0; i < 3; i++) {
        _horizontalControllers[i].areas = List.generate(
          2,
          (index) => Area(
            // data: rockGenres[i * 2 + index],
            min: 0.6,
          ),
        );
      }
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _verticalController.dispose();
    for (var controller in _horizontalControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return DefaultLayout(
      appBar: CustomAppBar(
        topIconButton: GestureDetector(
          onTap: () {
            debugPrint('Notifications Icon Pressed');
          },
          child: const Icon(
            Icons.notifications_none_outlined,
            color: Colors.black,
          ),
        ),
        bottomLeftWidget: DropdownButton(
          alignment: Alignment.centerLeft,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
          dropdownColor: Colors.white,
          elevation: 0,
          icon: Container(),
          underline: Container(),
          value: currentDropDown,
          padding: EdgeInsets.zero,
          items: dropDownList
              .map(
                (dropDownValue) => DropdownMenuItem(
                  value: dropDownValue,
                  child: Text(
                    dropDownValue,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(
              () {
                if (value != null) {
                  currentDropDown = value;
                }
              },
            );
          },
        ),
        bottomRightWidget: TextButton(
          onPressed: showAddDialog,
          child: const Text(
            '추가하기',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              height: 1,
            ),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 8,
        ),
        child: MultiSplitViewTheme(
          data: MultiSplitViewThemeData(
            dividerThickness: 5,
            dividerPainter: DividerPainter(
              backgroundColor: Colors.transparent,
              highlightedBackgroundColor: const Color(0xFFF3F3F2),
              animationEnabled: false,
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
                  return GridTextItem(
                    key: ValueKey('${verticalIndex}_${horizontalArea.index}'),
                    // content: horizontalArea.data as String,
                    content: dummyString,
                    width: screenWidth / 2,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void showAddDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddRecordDialog();
      },
    );
  }
}
