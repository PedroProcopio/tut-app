import 'package:tut_app/app/extensions.dart';



import 'package:tut_app/data/responses/responses.dart';

extension CustomerResponseMapper on CustomerResponse?{
  CustomerResponse toDomain(){
    return CustomerResponse(
      id: this?.id.orEmpty(),
      name: this?.name.orEmpty(),
      numOfNotifications: this?.numOfNotifications.orZero()
    );
  }
}

extension ContactsResponseMapper on ContactsResponse?{
  ContactsResponse toDomain(){
    return ContactsResponse(
      email: this?.email.orEmpty(),
      phone: this?.phone.orEmpty(),
      link: this?.link.orEmpty()
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse?{
  AuthenticationResponse toDomain(){
    return AuthenticationResponse(
      customer: this?.customer?.toDomain(),
      contacts: this?.contacts?.toDomain()
    );
  }
}