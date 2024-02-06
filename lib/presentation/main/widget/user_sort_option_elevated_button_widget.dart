import 'package:flutter/material.dart';
import 'package:pokedex_clean/presentation/main/main_view_model.dart';
import 'package:provider/provider.dart';

const List<Widget> collectionOptions = <Widget>[
  Text('전체'),
  Text('보유'),
  Text('미보유')
];
const List<Widget> directionOptions = <Widget>[
  Text('정방향'),
  Text('역방향'),
];


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

showSortingDialog(BuildContext context) {
  final MainViewModel viewModel = context.read();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
          content: SizedBox(
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
                  value: viewModel.state.gridCrossAxisCount.toDouble(),
                  min: 2.0,
                  max: 5.0,
                  divisions: 3,
                  label: viewModel.state.gridCrossAxisCount.toString(),
                  onChanged: (value) {
                    setState(() {
                      viewModel.updateGridColumnOption(value);
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
                  onPressed: (index) {
                    setState(() {
                      viewModel.updateCollectionOption(index);
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: Colors.green[700],
                  selectedColor: Colors.white,
                  fillColor: Colors.green[200],
                  color: Colors.green[400],
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 80.0,
                  ),
                  isSelected: viewModel.state.sortIsCollected,
                  children: collectionOptions,
                ),
                const DivideSizedBoxWidget(),
                const UserOptionTextWidget(title: '정렬 방향'),
                const SizedBox(height: 6.0),
                ToggleButtons(
                  direction: Axis.horizontal,
                  onPressed: (index) {
                    setState(() {
                      viewModel.updateDirectionOption(index);
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: Colors.blue[700],
                  selectedColor: Colors.white,
                  fillColor: Colors.blue[200],
                  color: Colors.blue[400],
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 80.0,
                  ),
                  isSelected: viewModel.state.sortDirection,
                  children: directionOptions,
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          )
        );
        },
      );
    },
  );
}