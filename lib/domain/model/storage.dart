class Storage {
  final String email;
  final List<String> pokemons;

//<editor-fold desc="Data Methods">
  const Storage({
    required this.email,
    required this.pokemons,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Storage &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          pokemons == other.pokemons);

  @override
  int get hashCode => email.hashCode ^ pokemons.hashCode;

  @override
  String toString() {
    return 'Storage{' + ' email: $email,' + ' pokemons: $pokemons,' + '}';
  }

  Storage copyWith({
    String? email,
    List<String>? pokemons,
  }) {
    return Storage(
      email: email ?? this.email,
      pokemons: pokemons ?? this.pokemons,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': this.email,
      'pokemons': this.pokemons,
    };
  }

  factory Storage.fromJson(Map<String, dynamic> map) {
    return Storage(
      email: map['email'] as String,
      pokemons: map['pokemons'] as List<String>,
    );
  }

//</editor-fold>
}