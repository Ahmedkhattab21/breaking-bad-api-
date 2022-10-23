
import 'package:bloc/bloc.dart';
import 'package:block_app/data/model/character.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/characterRepository.dart';
import 'character_states.dart';

class CharactersCuibit extends Cubit<characterStates>
{
  CharacterRepository characterRepository;
   List<Character> characters=[];
  CharactersCuibit(this.characterRepository):super(initialState());

 List<Character> getAllCharacters(){
    characterRepository.getAllCharacters().then((characters) {
      emit(characterLoaded(characters));
      this.characters=characters;
    });
    return characters;
  }
 void getAllQuetes(String charName){
    characterRepository.getAllQuetes(charName).then((quetes) {
      emit(queteLoaded(quetes));
    });

  }
  static CharactersCuibit get(context)=>BlocProvider.of(context);
  
}