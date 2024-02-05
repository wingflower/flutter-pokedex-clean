class UserInfo {
  final List<String> pokemons;

//<editor-fold desc="Data Methods">
  const UserInfo({
    required this.pokemons,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserInfo &&
          runtimeType == other.runtimeType &&
          pokemons == other.pokemons);

  @override
  int get hashCode => pokemons.hashCode;

  @override
  String toString() {
    return 'UserInfo{ pokemons: $pokemons,}';
  }

  UserInfo copyWith({
    List<String>? pokemons,
  }) {
    return UserInfo(
      pokemons: pokemons ?? this.pokemons,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pokemons': pokemons,
    };
  }

  factory UserInfo.fromJson(Map<String, dynamic> map) {
    return UserInfo(
      pokemons:
          (map['pokemons'] as List<dynamic>).map((e) => e.toString()).toList(),
    );
  }

//</editor-fold>
}
