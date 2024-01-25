class Pokemon {
  final String id;
  final String imageurl;
  final PokemonDescription description;
  final List<String> evolutions;
  final List<PokemonAbility> abilities;
  final List<String> types;
  final String weight;
  final String height;
  final String hp;
  final String attack;
  final String defense;
  final String special_attack;
  final String special_defense;
  final String speed;
  final bool isCollected;

  Pokemon({
    required this.id,
    required this.imageurl,
    required this.description,
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
    this.isCollected = false,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'] as String,
      imageurl: json['imageurl'] as String,
      description: PokemonDescription.fromJson(
          json['description'] as Map<String, dynamic>),
      evolutions: List<String>.from(json['evolutions'] as List<dynamic>),
      abilities: List<PokemonAbility>.from((json['abilities'] as List<dynamic>)
          .map((ability) =>
              PokemonAbility.fromJson(ability as Map<String, dynamic>))),
      types: List<String>.from(json['types'] as List<dynamic>),
      weight: json['weight'] as String,
      height: json['height'] as String,
      hp: json['hp'] as String,
      attack: json['attack'] as String,
      defense: json['defense'] as String,
      special_attack: json['special_attack'] as String,
      special_defense: json['special_defense'] as String,
      speed: json['speed'] as String,
      isCollected: json['isCollected'] as bool? ?? false,
    );
  }
}

class PokemonDescription {
  final String name;
  final String flavor_text;

  PokemonDescription({
    required this.name,
    required this.flavor_text,
  });

  factory PokemonDescription.fromJson(Map<String, dynamic> json) {
    return PokemonDescription(
      name: json['name'] as String,
      flavor_text: json['flavor_text'] as String,
    );
  }
}

class PokemonAbility {
  final String ability_id;
  final String name;
  final String flavor_text;

  PokemonAbility({
    required this.ability_id,
    required this.name,
    required this.flavor_text,
  });

  factory PokemonAbility.fromJson(Map<String, dynamic> json) {
    return PokemonAbility(
      ability_id: json['ability_id'] as String,
      name: json['name'] as String? ?? '',
      flavor_text: json['flavor_text'] as String? ?? '',
    );
  }
}
