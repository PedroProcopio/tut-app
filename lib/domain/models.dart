class SliderObject{
  final String title;
  final String subTitle;
  final String image;
  

  SliderObject({required this.title, required this.subTitle, required this.image});
}


class Customer{
  final String id;
  final String name;
  final int numOfNotifications;

  Customer({required this.id, required this.name, required this.numOfNotifications});
}

class Contacts{
  final String email;
  final String phone;
  final String link;

  Contacts({required this.email, required this.phone, required this.link});
}

class Authentication{
  Customer customer;
  Contacts contacts;
 

  Authentication({required this.customer,required this.contacts});
}