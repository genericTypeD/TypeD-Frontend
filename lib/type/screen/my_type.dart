import 'package:flutter/material.dart';
import 'package:typed/common/layout/default_layout.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:typed/type/component/add_record_dialog.dart';
import 'package:typed/type/component/component.dart';
import 'package:typed/common/widgets/custom_app_bar.dart';

const dummyString =
    'Ad culpa irure anim tempor aliqua ea est elit aute excepteur ipsum nisi. Commodo proident id adipisicing dolor adipisicing proident magna dolore sit id eu do. Ut deserunt Lorem enim enim. Aliqua sint excepteur do fugiat aliquip do occaecat. Enim nisi et occaecat proident proident voluptate voluptate nostrud fugiat non. Aliquip irure ad occaecat eiusmod dolore ipsum proident aliqua duis elit qui commodo deserunt. Consequat non dolor sit irure Lorem anim consectetur ea aliqua consequat nulla aliqua. Pariatur sint nulla deserunt dolore sint proident cupidatat eiusmod labore quis nostrud. Id dolore ex dolore elit amet pariatur occaecat nisi voluptate ex et. Nostrud nulla labore deserunt dolore occaecat. Adipisicing irure ullamco sit do sit minim officia culpa mollit elit id. Enim elit dolore cupidatat ad excepteur. Sit culpa officia do nulla enim. Magna aliqua irure ipsum nostrud qui consectetur aliqua sit cillum quis voluptate enim. Fugiat pariatur amet enim proident duis excepteur reprehenderit adipisicing est in qui. Incididunt veniam amet ut magna minim dolore fugiat consequat exercitation velit laborum aliquip et. Nostrud nulla duis adipisicing qui Lorem anim elit tempor officia nisi aliquip magna. Est duis exercitation cupidatat dolore dolore ullamco. Fugiat et veniam eu irure elit nostrud non laboris irure proident id. Culpa ex duis et quis. Dolor ex elit sit cupidatat officia elit enim cillum culpa amet. Exercitation officia dolore non mollit. Dolor sint anim consequat commodo eu elit officia. Do ipsum ut deserunt non ut. Ipsum elit anim proident labore fugiat amet sit exercitation adipisicing. Dolor dolore excepteur sit aliqua irure irure labore. Irure tempor labore non excepteur non ut adipisicing anim pariatur quis exercitation nisi qui Lorem. Non aliquip commodo sunt cupidatat sit ullamco fugiat proident amet deserunt laboris nisi exercitation qui. Duis Lorem consectetur elit labore et fugiat. Amet excepteur consectetur nulla quis velit. Nulla dolore elit qui dolore. Qui ut qui voluptate dolor. Lorem proident labore nisi pariatur. Minim reprehenderit aliqua occaecat occaecat ipsum in amet veniam. Sit culpa est ut pariatur ullamco amet veniam. Elit duis nisi esse fugiat reprehenderit voluptate anim cillum mollit. Ut fugiat eu ullamco non do deserunt culpa esse occaecat. Minim irure commodo occaecat et aute consectetur. Cillum aliqua ad cillum nulla aliqua labore exercitation pariatur aliquip proident. Quis occaecat sit sint non tempor sunt. Adipisicing nulla cupidatat dolor proident amet excepteur eiusmod. Laborum excepteur cupidatat deserunt dolor nostrud. In ipsum ut laboris voluptate proident ea quis ex irure. Id esse fugiat enim consectetur laboris mollit laboris excepteur do. Dolor ea dolore ut consectetur laborum aute ad magna quis sit do est ad. Enim magna voluptate nostrud ex. Velit duis cupidatat nisi dolor quis fugiat minim eiusmod. Dolor aliqua minim sunt anim. Non excepteur proident mollit veniam consectetur consequat ex aute officia veniam excepteur. Consequat magna eiusmod elit aliquip commodo. Ut ipsum fugiat nostrud deserunt qui veniam ut excepteur. Cillum aliquip eu est amet culpa nostrud sit. Deserunt officia tempor deserunt sit id ullamco laboris anim in culpa quis aute.';

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
