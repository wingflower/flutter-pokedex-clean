import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_clean/domain/model/type.dart';
import 'package:pokedex_clean/presentation/common/type_enum.dart';
import 'package:pokedex_clean/presentation/main/detail_screen/type/widget/type_page_view_container.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 1000),
      ),
    );
}

void showSimpleDialog(
  BuildContext context, {
  required String title,
  required String content,
  bool cancelable = true,
  bool isVisibleCancelButton = true,
  VoidCallback? confirmAction,
}) {
  showDialog(
      context: context,
      barrierDismissible: cancelable,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actionsAlignment: MainAxisAlignment.end,
          actions: [
            if (isVisibleCancelButton)
              TextButton(onPressed: context.pop, child: const Text('취소')),
            TextButton(
                onPressed: () {
                  context.pop();
                  confirmAction?.call();
                },
                child: const Text('확인'))
          ],
        );
      });
}

Color getColorFromString(String colorString) {
  switch (colorString) {
    case 'white':
      return Colors.white.withOpacity(0.3);
    case 'yellow':
      return Colors.yellow.withOpacity(0.3);
    case 'green':
      return Colors.green.withOpacity(0.3);
    case 'purple':
      return Colors.purple.withOpacity(0.3);
    case 'brown':
      return Colors.brown.withOpacity(0.3);
    case 'red':
      return Colors.red.withOpacity(0.3);
    case 'black':
      return Colors.black.withOpacity(0.3);
    case 'blue':
      return Colors.blue.withOpacity(0.3);
    case 'gray':
      return Colors.grey.withOpacity(0.3);
    case 'pink':
      return Colors.pink.withOpacity(0.3);
    default:
      return Colors.transparent; // 기본값 설정
  }
}

// 타입 중복 값 제거
List<String> removeTypeDuplicates(
    List<Map<String, dynamic>> list1, List<Map<String, dynamic>> list2) {
  Set<String> resultList = {};

  for (var entry in list1) {
    resultList.add(entry['id']);
  }

  for (var entry in list2) {
    resultList.add(entry['id']);
  }

  return resultList.toList();
}

// 타입 다이얼로그
Future<dynamic> typeEffectShowDialogFunction(
  BuildContext context,
  int index,
  TypeModel typeModel,
) {
  List<String> goodForType = removeTypeDuplicates(
      typeModel.double_damage_to, typeModel.half_damage_from);
  List<String> badForType = removeTypeDuplicates(
      typeModel.double_damage_from, typeModel.half_damage_to);
  List<String> noneForType =
      removeTypeDuplicates(typeModel.no_damage_to, typeModel.no_damage_from);
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  getTypeImagebyTypeId(typeModel.id),
                  width: 64.0,
                  height: 64.0,
                ),
                Text(
                  '${typeModel.name} 타입의 상성정보',
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close_outlined,
                size: 32.0,
              ),
            ),
          ],
        ),
        scrollable: true,
        content: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: PageView(
            children: [
              TypePageViewContainer(
                  title: '유리함', typeList: goodForType, color: Colors.blue),
              TypePageViewContainer(
                  title: '불리함', typeList: badForType, color: Colors.red),
              TypePageViewContainer(
                  title: '효과없음', typeList: noneForType, color: Colors.grey),
            ],
          ),
        ),
      );
    },
  );
}
