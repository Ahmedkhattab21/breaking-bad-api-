import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:block_app/constant/my_colors.dart';
import 'package:block_app/data/model/qoute.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cuibit/character_cuibit.dart';
import '../../business_logic/cuibit/character_states.dart';
import '../../data/model/character.dart';

class characterDetailed extends StatelessWidget {
  Character character;
   characterDetailed({Key? key,required this.character}) : super(key: key);

 Widget buildSliverAppBar(){
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
        flexibleSpace:FlexibleSpaceBar(
          title: Text(
            character.nickname!,
            style:const TextStyle(
              color: MyColors.myWhite,
            ),
          ),
          background: Hero(
            tag: character.charId!,
            child:  CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: character.image!,
              placeholder: (context, url) => Image.asset("assets/images/loading.gif"),
              errorWidget: (context, url, error) => Image.asset("assets/images/nophoto.jpeg"),
            ),
            // Image.network(character.image!,fit: BoxFit.cover,),
          ),
        ),
    );
  }
 Widget characterInfo(String title ,String value){
   return RichText(
     maxLines: 1,
       overflow:TextOverflow.ellipsis ,
       text: TextSpan(
         children: [
           TextSpan(
             text: title,
             style: TextStyle(
               color: MyColors.myWhite,
               fontWeight: FontWeight.bold,
               fontSize: 18,
             ),
           ),
           TextSpan(
             text: value,
             style: TextStyle(
               color: MyColors.myWhite,
               fontSize: 16,
             ),
           ),
         ]
       ),
   );
  }
Widget buildDivider(double endIndent){
   return Divider(
     height:30,
     endIndent: endIndent,
     color: MyColors.myYellow,
     thickness: 2,
   );
}

 Widget checkIfQuoteAreLoaded(characterStates state){
   if(state is queteLoaded){
     return displayRandomQuoteOrEmptySpace(state);
   }else{
     return showProgressIndecator();
   }
 }
  Widget displayRandomQuoteOrEmptySpace(state){
   List<Quete> quote=state.quetes;
   if(quote.length != 0){
     int randomQuoteIndex = Random().nextInt(quote.length);
     return DefaultTextStyle(
       textAlign: TextAlign.center,
         style:const TextStyle(
           fontSize: 20,
           color: MyColors.myWhite,
           shadows: [
             Shadow(
               blurRadius: 7.0,
               color: MyColors.myYellow,
               offset: Offset(0, 0),
             ),
           ],
         ),
         child:  AnimatedTextKit(
           repeatForever: true,
           animatedTexts: [
             FlickerAnimatedText(quote[randomQuoteIndex].quete),
           ],
         ),
     );
   }else{
     return Container();
   }


  }
  Widget showProgressIndecator(){
   return const Center(
     child: CircularProgressIndicator(
       color: MyColors.myYellow,
     ),
   );
  }
  @override
  Widget build(BuildContext context) {
    CharactersCuibit.get(context).getAllQuetes(character.name.toString());
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding:EdgeInsets.all(8),
                    margin:EdgeInsets.fromLTRB(14, 14, 14, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        characterInfo("Jobs : ", character.jobs!.join(" / ")),
                        buildDivider(300),
                        characterInfo("Apeared in : ", character.categoryForTwoSeries!),
                        buildDivider(250),
                        characterInfo("Seasons : ", character.appearanceOfSeasons!.join(" / ")),
                        buildDivider(270),
                        characterInfo("Status  : ", character.statusIfDeadOrAlive!),
                        buildDivider(280),
                        character.betterCallSaulAppearance!.isEmpty?Container():
                        characterInfo("Better call saul Seasons  : ", character.betterCallSaulAppearance!.join(" / ")),
                        character.betterCallSaulAppearance!.isEmpty?Container():
                        buildDivider(120),
                        characterInfo("Actor /Actress  : ", character.actorName!),
                        buildDivider(215),
                        SizedBox(height: 20,),
                        BlocConsumer<CharactersCuibit,characterStates>(
                            builder: (BuildContext context,characterStates state)=>checkIfQuoteAreLoaded(state),
                            listener: (BuildContext context, state){},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 500,),
                ]
          )),
        ],
      ),
    );
  }
}
