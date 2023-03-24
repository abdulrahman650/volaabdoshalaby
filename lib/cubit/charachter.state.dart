import 'package:flutter/material.dart';

import '../data/model/character_model.dart';

@immutable
abstract class CharactersState {
  const CharactersState();
}

class CharactersInitial extends CharactersState {
  CharactersInitial();
}

class CharactersLoading extends CharactersState {
  CharactersLoading();
}

class CharactersLoaded extends CharactersState {
  final List<CharacterModel> listCharacters;

  const CharactersLoaded({required this.listCharacters});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is CharactersLoaded && other.listCharacters == listCharacters;
  }

  @override
  int get hashCode => listCharacters.hashCode;
}

class CharactersError extends CharactersState {
  final String message;
  const CharactersError({required this.message});
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CharactersError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
