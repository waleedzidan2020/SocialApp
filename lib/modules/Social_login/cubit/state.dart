abstract class ShopLogInStates {}

class ShopLoginInitialState extends ShopLogInStates {}

class PasswordVisibleState extends ShopLogInStates {}

class DataSuccessLoginState extends ShopLogInStates {
  String? uid;

  DataSuccessLoginState(this.uid);

}

class DataErrorState extends ShopLogInStates {}

class DataLoginLoadingState extends ShopLogInStates {}
