import 'package:block_app/data/model/character.dart';
import 'package:block_app/data/model/qoute.dart';

import '../web_services/characters_webs_ervices.dart';

class CharacterRepository{
  CharacterWebServicess characterWebServicess;
  CharacterRepository(this.characterWebServicess);

  Future<List<Character>> getAllCharacters()async{
    try{
      final characters =await characterWebServicess.getAllCharacters();
      return characters.map((element)=>Character.fromJson(element)).toList();
    }catch(e){
      print(e);
      return [];
    }
  }
  Future<List<Quete>> getAllQuetes(String charName)async{
    try{
      final quetes =await characterWebServicess.getAllQuetes(charName);
      return quetes.map((element)=>Quete.fromJson(element)).toList();
    }catch(e){
      print(e);
      return [];
    }
  }
}