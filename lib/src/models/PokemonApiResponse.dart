class PokemonApiResponse {
  String name;
  String id;
  PokemonApiResponse({
    required this.name,
    required this.id,
  });

  factory PokemonApiResponse.fromJson(Map<dynamic, dynamic> json) {
    return PokemonApiResponse(
      name: json['name'] ?? '',
      id: json['id'] ?? '',
    );
  }
}
