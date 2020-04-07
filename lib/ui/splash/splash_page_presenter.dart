import 'dart:convert';

import 'package:ch/base/base_presenter.dart';
import 'package:ch/common/NetworkUtils.dart';
import 'package:ch/common/SharedPreferencesUtils.dart';
import 'package:ch/data/database/DatabaseHelper.dart';
import 'package:ch/data/network/api_helper.dart';
import 'package:ch/ui/splash/splash_page_view.dart';

class SplashPresenter extends BasePresenter<SplashPageView> {

  // vars
  var db = DatabaseHelper();

  Future getAppInfo() async {

    checkViewAttached();
    var response = await ApiHelper().fetchAppInfo();
    if (NetworkUtils.isReqSuccess(response)) {
      // get AppInfo as a Map
      Map appInfoMap = jsonDecode(response.body);
      // get ContactUs as a Map
      Map contactUsMap = appInfoMap['ContactUs'];
      print('appInfoMap $appInfoMap');
      print('contactUsMap $contactUsMap');
      SharedPreferencesUtils.addStringToSF(SharedPreferencesUtils.ABOUT_US_KEY, appInfoMap['AboutUs']);
      SharedPreferencesUtils.addStringToSF(SharedPreferencesUtils.FACEBOOK_LINK_KEY, appInfoMap['FacebookLink']);
      isViewAttached ? getView().onAppInfoRetrieved() : null;
    } else {
      isViewAttached ? getView().onFailLoadAppInfo() : null;
    }

  }

  Future<bool> isLoggedIn() async{
    return await db.isLoggedInUser();
  }

}
