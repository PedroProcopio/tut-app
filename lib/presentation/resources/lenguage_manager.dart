enum LenguageType{
  ENGLISH,
  SPANISH
}

const String SPANISH = "es";
const String ENGLISH = "en";


extension LenguageTypeExtension on LenguageType{
  String getValue(){
    switch(this){
      case LenguageType.ENGLISH:
        return ENGLISH;
      case LenguageType.SPANISH:
        return SPANISH;
      default:
        return ENGLISH;
    }
  }

}