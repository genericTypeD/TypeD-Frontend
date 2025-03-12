import 'package:flutter/material.dart';
import 'package:typed/common/index.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/type/models/period_type.dart';
import 'package:typed/type/utils/date_formatter.dart';
import 'package:typed/type/viewmodels/grid_viewmodel.dart';
import 'package:typed/type/viewmodels/period_datetime_viewmodel.dart';
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
  late List<MultiSplitViewController> _horizontalControllers;
  late MultiSplitViewController _verticalController;

  late PeriodType _selectedPeriod;
  late DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();

    // Provider의 초기값을 선택된 기간과 날짜 변수에 동기화
    final periodDateState = ref.read(periodDateProvider);
    _selectedPeriod = periodDateState.periodType;
    _selectedDateTime = periodDateState.dateTime;

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

    // 선택된 기간과 날짜에 해당하는 데이터 로드 요청
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadSplitViewData();
    });
  }

  /// 현재 기간과 날짜에 맞는 데이터 로드
  Future<void> _loadSplitViewData() async {
    final periodDateState = ref.read(periodDateProvider);

    // SplitView 데이터 로드
    await ref.read(splitViewProvider.notifier).loadForPeriodAndDate(
        periodDateState.periodType, periodDateState.dateTime);

    // Grid 데이터 로드
    await ref.read(gridProvider.notifier).loadForPeriodAndDate(
        periodDateState.periodType, periodDateState.dateTime);

    // 로드된 데이터로 컨트롤러 업데이트
    _updateControllersFromState();
  }

  /// 로드된 데이터로 컨트롤러 업데이트
  void _updateControllersFromState() {
    final splitViewState = ref.read(splitViewProvider);

    // 기존 컨트롤러 해제
    _verticalController.dispose();
    // 새로운 vertical 컨트롤러 생성
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

    // horizontal 컨트롤러도 동일한 방식으로 해제 후 새로 생성
    for (int i = 0; i < _horizontalControllers.length; i++) {
      _horizontalControllers[i].dispose();
      _horizontalControllers[i] = MultiSplitViewController(
        areas: List.generate(
          2,
          (j) => Area(
            min: 0.6,
            flex: splitViewState.horizontalFlexValues[i][j],
          ),
        ),
      );
    }

    // 화면 갱신
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    try {
      _verticalController.dispose();
      for (var controller in _horizontalControllers) {
        controller.dispose();
      }
    } catch (error) {
      debugPrint('[컨트롤러 해제 중 오류] error: $error');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // 현재 선택된 기간/날짜 상태 변경 감지
    ref.listen(periodDateProvider, (previous, next) {
      if (previous?.periodType != next.periodType ||
          previous?.dateTime.day != next.dateTime.day ||
          previous?.dateTime.month != next.dateTime.month ||
          previous?.dateTime.year != next.dateTime.year) {
        _loadSplitViewData();
      }
    });

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
