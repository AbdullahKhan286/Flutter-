String nameCharacters({required String name}){
  List<String> names = name.split(" ");
  if(name.length == 1){
    return name[0].toUpperCase();
  }
  else{
    return (names[0][0] + names[1][0]).toUpperCase();
  }
}

String dataFromSeconds({required int seconds}){
  var dt = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
  return dt.toString();
}