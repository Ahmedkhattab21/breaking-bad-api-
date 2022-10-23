
import 'dart:convert';

import 'package:http/http.dart' as http;

class CharacterWebServicess{

    Future<List<dynamic>> getAllCharacters()async{
        final url='https://www.breakingbadapi.com/api/characters';
        final response =await http.get(Uri.parse(url));
        if(response.statusCode==200){
          return json.decode(response.body);
        }else{
          throw "time out";
        }

  }

    Future<List<dynamic>> getAllQuetes(String charName)async{
      final url='https://www.breakingbadapi.com/api/quote?author=$charName';
      final response =await http.get(Uri.parse(url));
      if(response.statusCode==200){
        return json.decode(response.body);
      }else{
        throw "time out";
      }

    }
}