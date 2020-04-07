import 'dart:async';
import 'dart:convert';
import 'package:ch/data/models/Category.dart';
import 'package:ch/data/models/MenuItem.dart';
import 'package:ch/data/models/user_response.dart';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';

/*Singleton Class*/
class ApiHelper {
  static final ApiHelper _instance = ApiHelper._internal();
  final String BASE_URL = 'http://chapi.chonline.co/api/';

  factory ApiHelper() {
    return _instance;
  }

  ApiHelper._internal();

  Future fetchAppInfo() async {
    String url = BASE_URL + 'AppInfoController/GetAppInfo';
    var response = await http.get(url);
    return response;
  }

  Future<UserResponse> login({String email, String password}) async {
    String url = BASE_URL + 'Account/Login';
    Map body = {'UserName': email, 'Password': password};
    var response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      return UserResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user ');
    }
  }

  Future<List<Category>> getCategories() async {
    String url = BASE_URL + "Menu/GetCategories";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print("api_hepelr ${response.body}");
      var categories = List<Category>();
      Iterable list = json.decode(response.body);
      categories = list.map((model) => Category.fromJson(model)).toList();
      return categories;
    } else {
      throw Exception("Failed to load Categories");
    }
  }

  Future<List<MenuItem>> getMenuItemsByCategoryId(int categoryId) async {
    String url = BASE_URL + "Menu/GetMenuItem?Id=$categoryId";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print("api_hepelr ${response.body}");
      var menuItems = List<MenuItem>();
      Iterable list = json.decode(response.body);
      menuItems = list.map((model) => MenuItem.fromJson(model)).toList();
      return menuItems;
    } else {
      print("api_hepelr ${response.body}");
      throw Exception("Failed to load MenuItems");
    }
  }
}
