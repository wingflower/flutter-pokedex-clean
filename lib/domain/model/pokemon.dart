import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Pokemon {
  String id;
  String imageurl;
  String description;
  bool isCollected;
  List<String> evolutions;
  List<Map<String, dynamic>> abilities;
  List<String> types;
  String weight;
  String height;
  String hp;
  String attack;
  String defense;
  String special_attack;
  String special_defense;
  String speed;

  Pokemon({
    required this.id,
    required this.imageurl,
    required this.description,
    this.isCollected = false,
    required this.evolutions,
    required this.abilities,
    required this.types,
    required this.weight,
    required this.height,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.special_attack,
    required this.special_defense,
    required this.speed,
  });

  Pokemon copyWith({
    String? id,
    String? imageurl,
    String? description,
    bool? isCollected,
    List<String>? evolutions,
    List<Map<String, dynamic>>? abilities,
    List<String>? types,
    String? weight,
    String? height,
    String? hp,
    String? attack,
    String? defense,
    String? special_attack,
    String? special_defense,
    String? speed,
  }) {
    return Pokemon(
      id: id ?? this.id,
      imageurl: imageurl ?? this.imageurl,
      description: description ?? this.description,
      isCollected: isCollected ?? this.isCollected,
      evolutions: evolutions ?? this.evolutions,
      abilities: abilities ?? this.abilities,
      types: types ?? this.types,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      hp: hp ?? this.hp,
      attack: attack ?? this.attack,
      defense: defense ?? this.defense,
      special_attack: special_attack ?? this.special_attack,
      special_defense: special_defense ?? this.special_defense,
      speed: speed ?? this.speed,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imageurl': imageurl,
      'description': description,
      'isCollected': isCollected,
      'evolutions': evolutions,
      'abilities': abilities,
      'types': types,
      'weight': weight,
      'height': height,
      'hp': hp,
      'attack': attack,
      'defense': defense,
      'special_attack': special_attack,
      'special_defense': special_defense,
      'speed': speed,
    };
  }

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    return Pokemon(
      id: map['id'] as String,
      imageurl: map['imageurl'] as String,
      description: map['description'] as String,
      isCollected: map['isCollected'] as bool,
      evolutions: List<String>.from((map['evolutions'] as List<dynamic>)
          .map((evolution) => evolution as String)),
      abilities: List<Map<String, dynamic>>.from(
          (map['abilities'] as List<dynamic>)
              .map((ability) => ability as Map<String, dynamic>)),
      types: List<String>.from((map['types'] as List<String>)),
      weight: map['weight'] as String,
      height: map['height'] as String,
      hp: map['hp'] as String,
      attack: map['attack'] as String,
      defense: map['defense'] as String,
      special_attack: map['special_attack'] as String,
      special_defense: map['special_defense'] as String,
      speed: map['speed'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pokemon.fromJson(String source) =>
      Pokemon.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pokemon(id: $id, imageurl: $imageurl, description: $description, isCollected: $isCollected, evolutions: $evolutions, abilities: $abilities, types: $types, weight: $weight, height: $height, hp: $hp, attack: $attack, defense: $defense, special_attack: $special_attack, special_defense: $special_defense, speed: $speed)';
  }

  @override
  bool operator ==(covariant Pokemon other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.imageurl == imageurl &&
        other.description == description &&
        other.isCollected == isCollected &&
        listEquals(other.evolutions, evolutions) &&
        listEquals(other.abilities, abilities) &&
        listEquals(other.types, types) &&
        other.weight == weight &&
        other.height == height &&
        other.hp == hp &&
        other.attack == attack &&
        other.defense == defense &&
        other.special_attack == special_attack &&
        other.special_defense == special_defense &&
        other.speed == speed;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        imageurl.hashCode ^
        description.hashCode ^
        isCollected.hashCode ^
        evolutions.hashCode ^
        abilities.hashCode ^
        types.hashCode ^
        weight.hashCode ^
        height.hashCode ^
        hp.hashCode ^
        attack.hashCode ^
        defense.hashCode ^
        special_attack.hashCode ^
        special_defense.hashCode ^
        speed.hashCode;
  }
}
