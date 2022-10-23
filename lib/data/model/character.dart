class Character{
  int? charId;
  String? name;
  String? nickname;
  String? birthday;
  String? image;
  List<dynamic>? jobs;
  String? statusIfDeadOrAlive;
  List<dynamic>? appearanceOfSeasons;
  String? actorName;
  String? categoryForTwoSeries;
  List<dynamic>? betterCallSaulAppearance;

  Character({
    required this.charId,
    required this.name,
    required this.nickname,
    required this.birthday,
    required this.image,
    required  this.jobs,
    required this.statusIfDeadOrAlive,
    required this.appearanceOfSeasons,
    required this.actorName,
    required this.categoryForTwoSeries,
    required this.betterCallSaulAppearance
});

  Character.fromJson(Map<String,dynamic> json){
    charId=json['char_id'];
    name = json['name'];
    nickname = json['nickname'];
    birthday = json['birthday'];
    image = json['img'];
    jobs = json['occupation'];
    statusIfDeadOrAlive = json['status'];
    appearanceOfSeasons = json['appearance'];
    actorName = json['portrayed'];
    categoryForTwoSeries = json['category'];
    betterCallSaulAppearance=json['better_call_saul_appearance'];
  }

}