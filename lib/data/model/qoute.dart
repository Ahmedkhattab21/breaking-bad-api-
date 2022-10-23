class Quete{
  late String quete;
  Quete.fromJson(Map<String,dynamic>json){
    quete=json['quote'];
  }
}