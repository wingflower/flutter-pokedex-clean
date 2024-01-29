class Type {
  String id;
  String name;
  String imageurl;
  List<Map<String, dynamic>> double_damage_to;
  List<Map<String, dynamic>> double_damage_from;
  List<Map<String, dynamic>> half_damage_to;
  List<Map<String, dynamic>> half_damage_from;
  List<Map<String, dynamic>> no_damage_to;
  List<Map<String, dynamic>> no_damage_from;

  Type({
    required this.id,
    required this.name,
    required this.imageurl,
    required this.double_damage_to,
    required this.double_damage_from,
    required this.half_damage_to,
    required this.half_damage_from,
    required this.no_damage_to,
    required this.no_damage_from,
  });

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      id: json['id'],
      name: json['name'],
      imageurl: json['imageurl'],
      double_damage_to:
          List<Map<String, dynamic>>.from(json['double_damage_to']),
      double_damage_from:
          List<Map<String, dynamic>>.from(json['double_damage_from']),
      half_damage_to: List<Map<String, dynamic>>.from(json['half_damage_to']),
      half_damage_from:
          List<Map<String, dynamic>>.from(json['half_damage_from']),
      no_damage_to: List<Map<String, dynamic>>.from(json['no_damage_to']),
      no_damage_from: List<Map<String, dynamic>>.from(json['no_damage_from']),
    );
  }
}
