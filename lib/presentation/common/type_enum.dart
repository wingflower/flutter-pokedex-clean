enum TypeEnum {
  none,
  normal,
  fighting,
  flying,
  poison,
  ground,
  rock,
  bug,
  ghost,
  steel,
  fire,
  water,
  grass,
  electric,
  psychic,
  ice,
  dragon,
  dark,
  fairy,
}

String getTypeImagebyTypeId(String typeId) {
  return 'assets/images/types/${TypeEnum.values[int.parse(typeId)].toString().split('.').last}_type.png';
}

String getTypeDoubleImagebyTypeId(String typeId) {
  return 'assets/images/types/${TypeEnum.values[int.parse(typeId)].toString().split('.').last}_type_2x.png';
}
