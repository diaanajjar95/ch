import 'package:ch/base/base_presenter.dart';
import 'package:ch/data/database/DatabaseHelper.dart';
import 'package:ch/data/models/user_response.dart';
import 'package:ch/data/network/api_helper.dart';
import 'package:ch/ui/login/login_view.dart';

class LoginPresenter extends BasePresenter<LoginPageView> {
  // vars
  var db = DatabaseHelper();

  Future login({String email, String password}) async {
    isViewAttached ? getView().showProgress() : null;
    try {
      UserResponse userResponse =
          await ApiHelper().login(email: email, password: password);
      print('login presenter ${userResponse.data.accessToken}');
      if (userResponse != null) {
        if (userResponse.status == 200) {
          print('userResponse.status = 200 (${userResponse.status})');
          // change the flag of the user is logged in and save the user data into data base offline
          // save the user to sqflite data base
          int savedUserId = await db.saveUser(userResponse.data);
          print("savedUserId : $savedUserId");
          isViewAttached ? getView().hideProgress() : null;
          isViewAttached ? getView().onLoginSuccess() : null;
        } else {
          print('userResponse.status = ${userResponse.status}');
          isViewAttached ? getView().hideProgress() : null;
          isViewAttached ? getView().onLoginFailed() : null;
        }
      } else {
        print('userResponse is null');
        isViewAttached ? getView().hideProgress() : null;
        isViewAttached ? getView().onLoginFailed() : null;
      }
    } catch (e) {
      print('exception has occur : ' + e.toString());
      isViewAttached ? getView().hideProgress() : null;
      isViewAttached ? getView().onLoginFailed() : null;
    }
  }

  Future<bool> isLoggedIn() async{
    return await db.isLoggedInUser();
  }
}
