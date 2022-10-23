
import 'package:block_app/constant/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';


import '../../business_logic/cuibit/character_cuibit.dart';
import '../../business_logic/cuibit/character_states.dart';
import '../../data/model/character.dart';
import '../widgets/character_item.dart';



class characterScreen extends StatefulWidget {
  const characterScreen({Key? key}) : super(key: key);

  @override
  State<characterScreen> createState() => _characterScreenState();
}

class _characterScreenState extends State<characterScreen> {
 late List<Character> allCharacters;
 late List<Character> searchForCharacters=[];
 bool isSearching=false;
 TextEditingController _searchController=TextEditingController();


 Widget _buildSearchField(){
   return TextField(
     controller: _searchController,
     cursorColor: MyColors.myGrey,
     decoration:const InputDecoration(
       hintText: "Find a character ...",
       border: InputBorder.none,
       hintStyle: TextStyle(fontSize: 18,color: MyColors.myGrey),
     ),
     style:const TextStyle(fontSize: 18,color: MyColors.myGrey),
     onChanged: (searchedCharacter){
       addSearchedForItemsToSearchedList(searchedCharacter);
     },
   );
 }
 void addSearchedForItemsToSearchedList(String searchedCharacter){
   searchForCharacters=allCharacters.where((character) =>character.name!.toLowerCase().startsWith(searchedCharacter.toLowerCase())).toList();
   setState(() {
   });
 }
 List<Widget> _buildAppBarActions(){
   if(isSearching){
     return[
       IconButton(onPressed: (){
         _clearSearch();
         Navigator.pop(context);
       }, icon: Icon(Icons.clear),
         color:MyColors.myGrey ,
       ),
     ];
   }else{
     return[
       IconButton(onPressed:()=>_startSearch()
       , icon: Icon(Icons.search,
           color:MyColors.myGrey,
           )),
     ];
   }
 }
 void _startSearch(){
   ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
   setState(() {
     isSearching=true;
   });
 }
 void _stopSearching(){
   _clearSearch();
   setState(() {
     isSearching=false;
   });
 }
 void _clearSearch(){
   setState(() {
     _searchController.clear();
   });
 }

 @override
  void initState() {
    super.initState();
    CharactersCuibit.get(context).getAllCharacters();
  }

 Widget buildBlocWidget(){
   return BlocConsumer<CharactersCuibit,characterStates>(
       builder: (context ,state){
         if(state is characterLoaded){
           allCharacters=state.characters;
           return buildLoadedListWidgets();
         }else{
           return showLoadinIndicator();
         }
       },
       listener:  (context ,state){},
   );
 }

 Widget buildLoadedListWidgets(){
   return SingleChildScrollView(
     child: Container(
       color: MyColors.myGrey,
       child: Column(
         children: [
           buidCharacterListWidget(),
         ],
       ),
     ),
   );
 }
 Widget buidCharacterListWidget(){
   return GridView.builder(
     shrinkWrap: true,
       physics: const ClampingScrollPhysics(),
       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
         crossAxisCount:2 ,
         mainAxisSpacing:1 ,
         crossAxisSpacing:1 ,
         childAspectRatio: 2/3,
       ),
       itemBuilder:(contx,index){
       return CharacterItem(character:_searchController.text.isNotEmpty? searchForCharacters[index]: allCharacters[index],);
       },
     itemCount:_searchController.text.isNotEmpty? searchForCharacters.length: allCharacters.length,
   );
 }

 Widget showLoadinIndicator(){
   return const Center(
     child: CircularProgressIndicator(
       color: MyColors.myYellow,
     ),);
 }

 Widget _buileAppBarTitle(){
   return Text("Characters",
     style: TextStyle(color: MyColors.myGrey),
   );
 }

 Widget buildNoInternetWidget(){
   return Center(
     child: Container(
       color: MyColors.myWhite,
       child: SingleChildScrollView(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children:  [
             Text(
               "Can't connect ... check the internet",
               style: TextStyle(
                 fontSize: 22,
                 color: MyColors.myGrey
               ),
             ),
             SizedBox(height: 20,),
              Image.asset("assets/images/ii.png",fit: BoxFit.cover,),
           ],
         ),
       ),
     ),
   );
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:MyColors.myYellow ,
        leading:isSearching? BackButton(color: MyColors.myGrey,):Container(),
        title: isSearching?_buildSearchField():_buileAppBarTitle(),
        actions: _buildAppBarActions(),
        centerTitle: false,
      ),
       body:
      OfflineBuilder(
      connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child){
        final bool connected = connectivity != ConnectivityResult.none;
        if(connected){
          return buildBlocWidget();
        }else{
          return buildNoInternetWidget();
        }
      },
        child:showLoadinIndicator(),

      )
    );
  }
}
