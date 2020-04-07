import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  // const
  static const String ABOUT_US_KEY = 'about_us';
  static const String PHONE_NUMBER_KEY = 'phone_number';
  static const String FACEBOOK_LINK_KEY = 'facebook_link';

  // add Data
  static Future<void> addStringToSF(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  /*static addIntToSF(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static addDoubleToSF(String key, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }

  static addBoolToSF(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }*/

  // read data
  static Future<String> getStringValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString(key);
    print('stringValue $stringValue');
    return stringValue;
  }

  /*static getBoolValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool boolValue = prefs.getBool(key);
    return boolValue;
  }

  static getIntValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int intValue = prefs.getInt(key);
    return intValue;
  }

  static getDoubleValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return double
    double doubleValue = prefs.getDouble(key);
    return doubleValue;
  }*/

  // remove data
  static removeValues(String kay) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(kay);
  }
}
