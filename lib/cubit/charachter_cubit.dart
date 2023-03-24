import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:volaabdoshalaby/data/model/character_model.dart';
import '../data/repo/repo_layer.dart';
import 'charachter.state.dart';

class CharachterCubit extends Cubit<CharactersState> {
  CharachterCubit(this.charactersRepository) : super(CharactersInitial());

  final CharactersRepository charactersRepository;
Future<void> getCharachter() async {
  try{
    emit(CharactersLoading());
    final listOfCharacterModel= await requestCharachters();
    emit(CharactersLoaded(listCharacters: listOfCharacterModel));

  }catch(e){
    emit(CharactersError(message: e.toString(),));
  }

  emit(state);
  emit(state);
}
  Future<List<CharacterModel>> requestCharachters() async {
    try {
      final response = await charactersRepository.getListCharacters();
      if (response == null) {
        return [];
      }
      final listOfCharacters = json.decode(response.body);
      final owo = listOfCharacters["data"] as List<dynamic>;
      final list = owo.map((dynamic e) {
        // role serl
        final roles = e["role"] ?? {};
        final roleInfo = RoleModel(
          description: roles["description"]?? '',
          displayIcon: roles["displayIcon"]?? '',
          displayName: roles["displayName"]?? '',
          id: roles["uuid"] ?? "",
        );
        //   ability
        final abilities = e["abilities"] as List<dynamic>;
        final abilitiesInfo = abilities
            .map((dynamic a) => AbilityModel(

            description: a["description"],
            displayIcon: a["displayIcon"],
            displayName: a["displayName"],
            slot: a["slot"] ?? "",
          )
        ).toList();
        abilitiesInfo.retainWhere((x) => x.displayIcon.isNotEmpty);
        // voice line
        final voiceLine = e["voiceLine"] ?? {};
        final voiceMediaList = voiceLine['mediaList'] as List;
        final voiceMedia = VoiceLineModel(
          voiceLine: voiceMediaList[0]["wave"], voiceline: null);
        return CharacterModel(
          displayName: e['displayName'] ?? '',
          description: e['description'] ?? '',
          background: e['background'] ?? '',
          fullPortrait: e['fullPortrait'] ?? '',
            abilitie: abilitiesInfo,
            voiceLine: voiceMedia,
          role: roleInfo,);
        
      }).toSet().toList();

      list.retainWhere((x) => x.fullPortrait.isNotEmpty);
      return list;
    } catch ( e) {
if (kDebugMode) {
  print(e);
}
throw Exception(e.toString());


    }
  }
}
