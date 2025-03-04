import 'package:flutter/material.dart';
import 'package:typed/common/index.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/type/models/period_type.dart';
import 'package:typed/type/views/component/grid_item_widget.dart';
import 'package:typed/type/viewmodels/split_view_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_split_view/multi_split_view.dart';

class MyType extends ConsumerStatefulWidget {
  const MyType({super.key});

  @override
  ConsumerState<MyType> createState() => _MyTypeState();
}

class _MyTypeState extends ConsumerState<MyType> {
  late final List<MultiSplitViewController> _horizontalControllers;
  late final MultiSplitViewController _verticalController;

  late PeriodType _selectedPeriod;

  @override
  void initState() {
    super.initState();
    _selectedPeriod = PeriodType.weekly;

    final splitViewState = ref.read(splitViewProvider);

    _verticalController = MultiSplitViewController(
      areas: List.generate(
        3,
        (index) => Area(
          data: index,
          min: 0.6,
          flex: splitViewState.verticalFlexValues[index],
        ),
      ),
    );

    _horizontalControllers = List.generate(
      3,
      (index) => MultiSplitViewController(
        areas: List.generate(
          2,
          (index2) => Area(
            min: 0.6,
            flex: splitViewState.horizontalFlexValues[index][index2],
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    ref.watch(splitViewProvider);

    return DefaultLayout(
      backgroundColor: AppColors.backgroundSecondary,
      appBar: CustomAppBar(
        bottomLeftWidget: DropdownButton(
          alignment: Alignment.centerLeft,
          style: AppTheme.title3,
          dropdownColor: Colors.white,
          elevation: 0,
          icon: Container(),
          underline: Container(),
          value: _selectedPeriod,
          padding: EdgeInsets.zero,
          items: PeriodType.allCases
              .map(
                (dropDownValue) => DropdownMenuItem(
                  value: dropDownValue,
                  child: Text(
                    dropDownValue.engName,
                    style: AppTheme.title3,
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(
              () {
                if (value != null) {
                  _selectedPeriod = value;
                }
              },
            );
          },
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
            key: const ValueKey('vertical_split'),
            controller: _verticalController,
            axis: Axis.vertical,
            resizable: true,
            antiAliasingWorkaround: true,
            onDividerDragUpdate: (dividerIndex) {
              final flexValues = _verticalController.areas
                  .map((area) => area.flex ?? 1.0)
                  .toList();
              ref
                  .read(splitViewProvider.notifier)
                  .updateVerticalFlex(flexValues);
            },
            builder: (context, verticalArea) {
              final verticalIndex = verticalArea.data as int;
              return MultiSplitView(
                key: ValueKey('horizontal_split_$verticalIndex'),
                controller: _horizontalControllers[verticalIndex],
                resizable: true,
                antiAliasingWorkaround: true,
                onDividerDragUpdate: (dividerIndex) {
                  final flexValues = _horizontalControllers[verticalIndex]
                      .areas
                      .map((area) => area.flex ?? 1.0)
                      .toList();
                  ref
                      .read(splitViewProvider.notifier)
                      .updateHorizontalFlex(verticalIndex, flexValues);
                },
                builder: (context, horizontalArea) {
                  return GridItemWidget(
                    key: ValueKey('${verticalIndex}_${horizontalArea.index}'),
                    verticalIndex: verticalIndex,
                    horizontalIndex: horizontalArea.index,
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
}
