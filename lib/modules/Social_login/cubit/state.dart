abstract class ShopLogInStates {}

class ShopLoginInitialState extends ShopLogInStates {}

class PasswordVisibleState extends ShopLogInStates {}

class DataSuccessLoginState extends ShopLogInStates {
  String? uid;

  DataSuccessLoginState(this.uid);

}

class DataErrorState extends ShopLogInStates {}

class DataLoginLoadingState extends ShopLogInStates {}


//Create Acount in FireBase
class DataCreateLoadingByGmailState extends ShopLogInStates {}
class DataCreateSuccessByGmailState extends ShopLogInStates {

  String? uid;

  DataCreateSuccessByGmailState(this.uid);
}
class DataCreateErorrByGmailState extends ShopLogInStates {}


class FireBaseAuthenticationSuccess extends ShopLogInStates {}
class FireBaseAuthenticationErorr extends ShopLogInStates {}