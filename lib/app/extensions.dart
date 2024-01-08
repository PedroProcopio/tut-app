

// extension para el string

extension NonNullString on String?{
  String orEmpty(){
    if (this == null)
    {
      return "";
    }
    return this!;
  }
}


extension NonNullInt on int?{
  int orZero(){
    if (this == null)
    {
      return 0;
    }
    return this!;
  }
}

