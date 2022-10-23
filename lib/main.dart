import 'package:flutter/material.dart';

import 'app_route.dart';
import 'data/repository/characterRepository.dart';
import 'data/web_services/characters_webs_ervices.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BreakingBad(appRoute: AppRoute(),));
}

class BreakingBad extends StatelessWidget {
  AppRoute appRoute;
  BreakingBad({Key? key,required this.appRoute}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute:appRoute.generateRouute,
    );
  }
}

