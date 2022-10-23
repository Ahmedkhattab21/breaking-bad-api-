
import 'package:block_app/presentation/screens/characters_detailed.dart';
import 'package:block_app/presentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/cuibit/character_cuibit.dart';
import 'constant/string.dart';
import 'data/model/character.dart';
import 'data/repository/characterRepository.dart';
import 'data/web_services/characters_webs_ervices.dart';


class AppRoute{
  late CharacterRepository characterRepository;
  late CharactersCuibit charactersCuibit;
  AppRoute(){
    characterRepository=CharacterRepository(CharacterWebServicess());
    charactersCuibit=CharactersCuibit(characterRepository);
  }
  Route? generateRouute(RouteSettings settings){
    switch(settings.name){
      case charactersScreenRoute:
        return MaterialPageRoute(builder: (_)=>BlocProvider(
            create:(BuildContext context)=>charactersCuibit,
          child: characterScreen(),
        ),);
      case charactersDetailedRoute:
        final character= settings.arguments as Character ;
        return MaterialPageRoute(builder: (_)=> BlocProvider.value(
          value:CharactersCuibit(characterRepository),
            child: characterDetailed(
              character: character,),
        )
        );
    }
  }
}