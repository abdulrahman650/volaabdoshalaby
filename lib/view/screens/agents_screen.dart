import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/charachter.state.dart';
import '../../cubit/charachter_cubit.dart';
import '../../data/model/character_model.dart';
import '../widgets/agent_list.dart';

class AgentsScreen extends StatefulWidget {
  const AgentsScreen({Key? key}) : super(key: key);

  @override
  State<AgentsScreen> createState() => _AgentsScreenState();
}

class _AgentsScreenState extends State<AgentsScreen> {
  List<CharacterModel> characters = [];

  @override
  Widget build(BuildContext context) {
    return agentsList(data: characters, count: 2);
  }

  @override
  void initState() {
    // context.read<CharactersCubit>().getCharacters();
    final cubiData = context.read<CharachterCubit>();
    if (cubiData.state is CharactersLoaded) {
      characters = (cubiData.state as CharactersLoaded).listCharacters;
      // print(characters);
    }
    super.initState();
  }
}
