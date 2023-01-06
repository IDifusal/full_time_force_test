// To parse this JSON data, do
//
//     final pokemonModel = pokemonModelFromMap(jsonString);

import 'dart:convert';

class PokemonModel {
  PokemonModel({
    required this.abilities,
    required this.baseExperience,
    required this.height,
    required this.heldItems,
    required this.id,
    required this.isDefault,
    required this.moves,
    required this.name,
    required this.order,
    required this.pastTypes,
    required this.stats,
    required this.types,
    required this.weight,
  });

  List<AbilityElement> abilities;
  int baseExperience;
  int height;
  List<dynamic> heldItems;
  int id;
  bool isDefault;
  List<Move> moves;
  String name;
  int order;
  List<dynamic> pastTypes;
  List<Stat> stats;
  List<Type> types;
  int weight;

  factory PokemonModel.fromJson(String str) =>
      PokemonModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PokemonModel.fromMap(Map<String, dynamic> json) => PokemonModel(
        abilities: List<AbilityElement>.from(
            json["abilities"].map((x) => AbilityElement.fromMap(x))),
        baseExperience: json["base_experience"],
        height: json["height"],
        heldItems: List<dynamic>.from(json["held_items"].map((x) => x)),
        id: json["id"],
        isDefault: json["is_default"],
        moves: List<Move>.from(json["moves"].map((x) => Move.fromMap(x))),
        name: json["name"],
        order: json["order"],
        pastTypes: List<dynamic>.from(json["past_types"].map((x) => x)),
        stats: List<Stat>.from(json["stats"].map((x) => Stat.fromMap(x))),
        types: List<Type>.from(json["types"].map((x) => Type.fromMap(x))),
        weight: json["weight"],
      );

  Map<String, dynamic> toMap() => {
        "abilities": List<dynamic>.from(abilities.map((x) => x.toMap())),
        "base_experience": baseExperience,
        "height": height,
        "held_items": List<dynamic>.from(heldItems.map((x) => x)),
        "id": id,
        "is_default": isDefault,
        "moves": List<dynamic>.from(moves.map((x) => x.toMap())),
        "name": name,
        "order": order,
        "past_types": List<dynamic>.from(pastTypes.map((x) => x)),
        "stats": List<dynamic>.from(stats.map((x) => x.toMap())),
        "types": List<dynamic>.from(types.map((x) => x.toMap())),
        "weight": weight,
      };
}

class AbilityElement {
  AbilityElement({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  MoveClass ability;
  bool isHidden;
  int slot;

  factory AbilityElement.fromJson(String str) =>
      AbilityElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AbilityElement.fromMap(Map<String, dynamic> json) => AbilityElement(
        ability: MoveClass.fromMap(json["ability"]),
        isHidden: json["is_hidden"],
        slot: json["slot"],
      );

  Map<String, dynamic> toMap() => {
        "ability": ability.toMap(),
        "is_hidden": isHidden,
        "slot": slot,
      };
}

class MoveClass {
  MoveClass({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory MoveClass.fromJson(String str) => MoveClass.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MoveClass.fromMap(Map<String, dynamic> json) => MoveClass(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
      };
}

class Move {
  Move({
    required this.move,
    required this.versionGroupDetails,
  });

  MoveClass move;
  List<VersionGroupDetail> versionGroupDetails;

  factory Move.fromJson(String str) => Move.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Move.fromMap(Map<String, dynamic> json) => Move(
        move: MoveClass.fromMap(json["move"]),
        versionGroupDetails: List<VersionGroupDetail>.from(
            json["version_group_details"]
                .map((x) => VersionGroupDetail.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "move": move.toMap(),
        "version_group_details":
            List<dynamic>.from(versionGroupDetails.map((x) => x.toMap())),
      };
}

class VersionGroupDetail {
  VersionGroupDetail({
    required this.levelLearnedAt,
    required this.moveLearnMethod,
    required this.versionGroup,
  });

  int levelLearnedAt;
  MoveClass moveLearnMethod;
  MoveClass versionGroup;

  factory VersionGroupDetail.fromJson(String str) =>
      VersionGroupDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VersionGroupDetail.fromMap(Map<String, dynamic> json) =>
      VersionGroupDetail(
        levelLearnedAt: json["level_learned_at"],
        moveLearnMethod: MoveClass.fromMap(json["move_learn_method"]),
        versionGroup: MoveClass.fromMap(json["version_group"]),
      );

  Map<String, dynamic> toMap() => {
        "level_learned_at": levelLearnedAt,
        "move_learn_method": moveLearnMethod.toMap(),
        "version_group": versionGroup.toMap(),
      };
}

class Stat {
  Stat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  int baseStat;
  int effort;
  MoveClass stat;

  factory Stat.fromJson(String str) => Stat.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Stat.fromMap(Map<String, dynamic> json) => Stat(
        baseStat: json["base_stat"],
        effort: json["effort"],
        stat: MoveClass.fromMap(json["stat"]),
      );

  Map<String, dynamic> toMap() => {
        "base_stat": baseStat,
        "effort": effort,
        "stat": stat.toMap(),
      };
}

class Type {
  Type({
    required this.slot,
    required this.type,
  });

  int slot;
  MoveClass type;

  factory Type.fromJson(String str) => Type.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Type.fromMap(Map<String, dynamic> json) => Type(
        slot: json["slot"],
        type: MoveClass.fromMap(json["type"]),
      );

  Map<String, dynamic> toMap() => {
        "slot": slot,
        "type": type.toMap(),
      };
}
