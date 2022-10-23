import 'package:block_app/constant/my_colors.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';


import '../../constant/string.dart';
import '../../data/model/character.dart';

class CharacterItem extends StatelessWidget {
  Character character;
  CharacterItem({Key? key,required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(left: 8,right: 8,bottom: 8,top: 8),
      padding:const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, charactersDetailedRoute,arguments: character);
        },
        child: GridTile(
          footer: Hero(
            tag: character.charId!,
            child: Container(
              width: double.infinity,
              padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                "${character.name}",
                style:const TextStyle(
                  height:1.3,
                  fontSize: 16,
                  color: MyColors.myWhite,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child : Container(
            color: MyColors.myGrey,
            child: character.image!.isNotEmpty ?
            CachedNetworkImage(
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              imageUrl: character.image!,
              placeholder: (context, url) => Image.asset("assets/images/loading.gif"),
              errorWidget: (context, url, error) => Image.asset("assets/images/nophoto.jpeg"),
            )
                :Image.asset("assets/images/nophoto.jpeg"),
          ),
        ),
      ),
    );
  }
}
