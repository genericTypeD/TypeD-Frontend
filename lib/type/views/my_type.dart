import 'package:flutter/material.dart';
import 'package:typed/common/index.dart';
import 'package:typed/common/const/index.dart';
import 'package:typed/type/models/grid_item.dart';
import 'package:typed/type/models/period_type.dart';
import 'package:typed/type/utils/date_formatter.dart';
import 'package:typed/type/viewmodels/grid_viewmodel.dart';
import 'package:typed/type/viewmodels/period_datetime_viewmodel.dart';
import 'package:typed/type/views/component/add_record_dialog.dart';
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

    // 초기 SplitView 설정
    final splitViewState = ref.read(splitViewProvider);

    // SplitView 컨트롤러 초기화
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
                  setState(() {
                    _selectedPeriod = value;
                  });

                  // 기간 변경 시 데이터 로드
                  ref.read(periodDateProvider.notifier).updatePeriodType(value);
                }
              },
            );
          },
        ),
        bottomRightWidget: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: TextButton(
            onPressed: () async {
              final result = await showDatePicker(
                context: context,
                initialDate: _selectedDateTime,
                firstDate:
                    DateTime.now().subtract(const Duration(days: 365 * 3)),
                lastDate: DateTime.now(),
                helpText: '기록에 대한 날짜를 선택하세요',
                cancelText: '취소',
                confirmText: '확인',
                barrierColor: Colors.black54,
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: Theme.of(context).colorScheme.copyWith(
                            primary: AppColors.borderBlack,
                          ),
                      datePickerTheme: DatePickerThemeData(
                        backgroundColor: AppColors.backgroundTertiary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side: BorderSide(
                            color: AppColors.borderBlack,
                            width: 0.3,
                          ),
                        ),
                        headerBackgroundColor: AppColors.backgroundTertiary,
                        headerForegroundColor: AppColors.textPrimary,
                        dividerColor: AppColors.dividerBlack,
                        cancelButtonStyle: ButtonStyle(
                          foregroundColor: WidgetStatePropertyAll(
                            AppColors.textPrimary,
                          ),
                        ),
                        confirmButtonStyle: ButtonStyle(
                          foregroundColor: WidgetStatePropertyAll(
                            AppColors.textPrimary,
                          ),
                        ),
                        todayBackgroundColor: WidgetStateProperty.fromMap(
                          {
                            WidgetState.selected:
                                AppColors.backgroundQuaternary,
                            WidgetState.disabled: Colors.transparent,
                          },
                        ),
                        dayForegroundColor: WidgetStateProperty.fromMap(
                          {
                            WidgetState.disabled: AppColors.textTertiary,
                            WidgetState.selected: Colors.white,
                          },
                        ),
                        dayBackgroundColor: WidgetStateProperty.fromMap(
                          {
                            WidgetState.selected:
                                AppColors.backgroundQuaternary,
                            WidgetState.disabled: Colors.transparent,
                          },
                        ),
                        dayOverlayColor: WidgetStateProperty.fromMap({
                          WidgetState.selected | WidgetState.focused:
                              Colors.transparent,
                        }),
                        dayShape: WidgetStateProperty.resolveWith(
                          (states) {
                            return RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide(
                                color: states.contains(WidgetState.selected)
                                    ? AppColors.borderBlack
                                    : Colors.transparent,
                                width: 0.3,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              setState(() {
                if (result != null) {
                  _selectedDateTime = result;

                  // 날짜 변경 시 데이터 로드
                  ref.read(periodDateProvider.notifier).updateDateTime(result);
                }
              });
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              overlayColor: Colors.transparent,
            ),
            child: Text(
              DateFormatter.formatByPeriodType(
                  _selectedPeriod, _selectedDateTime),
              textAlign: TextAlign.left,
              style: AppTheme.title3.copyWith(
                height: 1,
              ),
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
            key: const ValueKey('vertical_split'),
            controller: _verticalController,
            axis: Axis.vertical,
            resizable: true,
            antiAliasingWorkaround: true,
            onDividerDragUpdate: (dividerIndex) {
              // 분할 영역 조정 시마다 Provider와 Hive에 저장
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
                  // 분할 영역 조정 시마다 Provider와 Hive에 저장
                  final flexValues = _horizontalControllers[verticalIndex]
                      .areas
                      .map((area) => area.flex ?? 1.0)
                      .toList();
                  ref
                      .read(splitViewProvider.notifier)
                      .updateHorizontalFlex(verticalIndex, flexValues);
                },
                builder: (context, horizontalArea) {
                  final gridState = ref.watch(gridProvider);
                  final item =
                      gridState.items[verticalIndex][horizontalArea.index];

                  return GridItemContainer(
                    item: item,
                    onTap: () async {
                      final result = await showDialog<GridItem>(
                        context: context,
                        builder: (context) => AddRecordDialog(item: item),
                      );

                      if (result != null) {
                        ref.read(gridProvider.notifier).updateGridItem(
                            verticalIndex, horizontalArea.index, result);
                      }
                    },
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
