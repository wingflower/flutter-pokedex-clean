import 'package:flutter/material.dart';

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
  const UserSortOptionElevatedButtonWidget({
    super.key,
  });

  @override
  State<UserSortOptionElevatedButtonWidget> createState() =>
      _UserSortOptionElevatedButtonWidgetState();
}

class _UserSortOptionElevatedButtonWidgetState
    extends State<UserSortOptionElevatedButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final List<bool> selectedCollectionOptions = <bool>[true, false, false];
    final List<bool> selectedDirectionOptions = <bool>[true, false];
    double currentSliderValue = 2.0;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(content: StatefulBuilder(
              builder: (BuildContext context,
                  void Function(void Function()) setState) {
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 16.0,
                        child: const Divider(
                          color: Colors.grey,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '메인 열 수',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Slider(
                        value: currentSliderValue,
                        min: 2,
                        max: 5,
                        divisions: 3,
                        label: currentSliderValue.round().toString(),
                        onChanged: (double value) {
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 16.0,
                        child: const Divider(
                          color: Colors.grey,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '컬렉션 보유',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      ToggleButtons(
                        direction: Axis.horizontal,
                        onPressed: (int index) {
                          setState(() {
                            for (int i = 0;
                                i < selectedCollectionOptions.length;
                                i++) {
                              selectedCollectionOptions[i] = i == index;
                              // print('qwerasdf ${selectedCollectionOptions[i]}');
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 16.0,
                        child: const Divider(
                          color: Colors.grey,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '정렬 방향',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      ToggleButtons(
                        direction: Axis.horizontal,
                        onPressed: (int index) {
                          setState(() {
                            for (int i = 0;
                                i < selectedDirectionOptions.length;
                                i++) {
                              selectedDirectionOptions[i] = i == index;
                              // print('qwerasdf ${selectedDirectionOptions[i]}');
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
