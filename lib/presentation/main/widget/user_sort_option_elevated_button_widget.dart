import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/presentation/main/main_state.dart';
import 'package:pokedex_clean/presentation/main/main_view_model.dart';

const List<Widget> collectionOptions = <Widget>[
  Text('전체'),
  Text('보유'),
  Text('미보유')
];
const List<Widget> directionOptions = <Widget>[
  Text('정방향'),
  Text('역방향'),
];

class UserSortOptionElevatedButtonWidget extends StatefulWidget {
  // final MainState mainState;
  final MainViewModel mainViewModel;

  const UserSortOptionElevatedButtonWidget({
    super.key,
    // required this.mainState, required MainViewModel viewModel, required MainViewModel mainViewModel,
    required this.mainViewModel,
  });

  @override
  State<UserSortOptionElevatedButtonWidget> createState() =>
      _UserSortOptionElevatedButtonWidgetState();
}

class _UserSortOptionElevatedButtonWidgetState
    extends State<UserSortOptionElevatedButtonWidget> {
  late MainState mainState;
  late List<bool> selectedCollectionOptions;
  late List<bool> selectedDirectionOptions;
  late double currentSliderValue;

  @override
  void initState() {
    super.initState();
    mainState = widget.mainViewModel.state;
    selectedCollectionOptions = List.from(mainState.sortIsCollected);
    selectedDirectionOptions = List.from(mainState.sortDirection);
    currentSliderValue = mainState.gridCrossAxisCount.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(content: StatefulBuilder(
              builder: (BuildContext context, setState) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            '사용자 옵션',
                            style: TextStyle(
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                      ),
                      const DivideSizedBoxWidget(),
                      const UserOptionTextWidget(title: '메인 열 수'),
                      Slider(
                        value: currentSliderValue,
                        min: 2,
                        max: 5,
                        divisions: 3,
                        label: currentSliderValue.round().toString(),
                        onChanged: (double value) {
                          // widget.mainViewModel.updateGridColumnOption(value);
                          setState(() {
                            currentSliderValue = value;
                          });
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('2'),
                            Text('3'),
                            Text('4'),
                            Text('5'),
                          ],
                        ),
                      ),
                      const DivideSizedBoxWidget(),
                      const UserOptionTextWidget(title: '컬렉션 보유'),
                      ToggleButtons(
                        direction: Axis.horizontal,
                        onPressed: (int index) {
                          // widget.mainViewModel.updateCollectionOption(                              selectedCollectionOptions, index);
                          setState(() {
                            for (int i = 0;
                                i < selectedCollectionOptions.length;
                                i++) {
                              selectedCollectionOptions[i] = i == index;
                            }
                          });
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        selectedBorderColor: Colors.green[700],
                        selectedColor: Colors.white,
                        fillColor: Colors.green[200],
                        color: Colors.green[400],
                        constraints: const BoxConstraints(
                          minHeight: 40.0,
                          minWidth: 80.0,
                        ),
                        isSelected: selectedCollectionOptions,
                        children: collectionOptions,
                      ),
                      const DivideSizedBoxWidget(),
                      const UserOptionTextWidget(title: '정렬 방향'),
                      const SizedBox(height: 6.0),
                      ToggleButtons(
                        direction: Axis.horizontal,
                        onPressed: (int index) {
                          // widget.mainViewModel.updateDirectionOption(                              selectedDirectionOptions, index);
                          setState(() {
                            for (int i = 0;
                                i < selectedDirectionOptions.length;
                                i++) {
                              selectedDirectionOptions[i] = i == index;
                            }
                          });
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        selectedBorderColor: Colors.blue[700],
                        selectedColor: Colors.white,
                        fillColor: Colors.blue[200],
                        color: Colors.blue[400],
                        constraints: const BoxConstraints(
                          minHeight: 40.0,
                          minWidth: 80.0,
                        ),
                        isSelected: selectedDirectionOptions,
                        children: directionOptions,
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          widget.mainViewModel.updateUserOption(
                            selectedCollectionOptions,
                            selectedDirectionOptions,
                            currentSliderValue.toInt(),
                          );

                          context.pop();
                        },
                        child: const Text(
                          '확인',
                        ),
                      ),
                    ],
                  ),
                );
              },
            ));
          },
        );
      },
      child: const Icon(
        Icons.sort,
      ),
    );
  }
}

class UserOptionTextWidget extends StatelessWidget {
  final String title;
  const UserOptionTextWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16.0,
        ),
      ),
    );
  }
}

class DivideSizedBoxWidget extends StatelessWidget {
  const DivideSizedBoxWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 16.0,
      child: const Divider(
        color: Colors.grey,
      ),
    );
  }
}
