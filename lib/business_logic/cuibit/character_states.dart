
import '../../data/model/character.dart';
import '../../data/model/qoute.dart';

abstract class characterStates{}

class initialState extends characterStates{}

class characterLoaded extends characterStates{
  List<Character> characters;
  characterLoaded(this.characters);
}
class queteLoaded extends characterStates{
  List<Quete> quetes;
  queteLoaded(this.quetes);
}