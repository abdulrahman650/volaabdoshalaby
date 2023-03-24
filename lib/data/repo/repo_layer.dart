import 'package:volaabdoshalaby/data/web_service/web_service.dart';

class CharactersRepository{
  final WebService apiProvider;

  CharactersRepository({required this.apiProvider});

  Future<dynamic> getListCharacters()async{

  return apiProvider.getAgent();
  }
}