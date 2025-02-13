import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:typed/common/layout/default_layout.dart';
import 'package:typed/common/widgets/custom_app_bar.dart';
import 'package:typed/type/component/add_record_dialog.dart';
import 'package:typed/type/component/component.dart';

const dummyString =
    'Ad culpa irure anim tempor aliqua ea est elit aute excepteur ipsum nisi. Commodo proident id adipisicing dolor adipisicing proident magna dolore sit id eu do. Ut deserunt Lorem enim enim. Aliqua sint excepteur do fugiat aliquip do occaecat.';

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
        // topIconButton: GestureDetector(
        //   onTap: () {
        //     debugPrint('Notifications Icon Pressed');
        //   },
        //   child: const Icon(
        //     Icons.notifications,
        //     color: Colors.black,
        //   ),
        // ),
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
