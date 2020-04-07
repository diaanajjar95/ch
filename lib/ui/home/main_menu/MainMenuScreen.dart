import 'package:ch/data/models/Category.dart';
import 'package:ch/ui/home/main_menu/MainMenuPresenter.dart';
import 'package:ch/ui/menuItemsList/menu_item_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MainMenuView.dart';

class MainMenuScreen extends StatefulWidget {
  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen>
    implements MainMenuView {
  // const
  static const String TAG = "MainMenuScreen";

  // vars
  var categoriesList = List<Category>();
  MainMenuPresenter presenter;

  @override
  void initState() {
    super.initState();
    print("$TAG initState");
    presenter = MainMenuPresenter();
    presenter.attachView(this);
    presenter.getCategories();
  }

  @override
  void dispose() {
    super.dispose();
    print("$TAG dispose");
  }

  @override
  Widget build(BuildContext context) {
    print("$TAG build");
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: ListView.builder(
        itemBuilder: (context, position) {
          Category category = categoriesList[position];
          return getCategoryItem(category);
        },
        itemCount: categoriesList.length,
      ),
    );
  }

  @override
  hideProgress() {}

  @override
  showMessage(String message) {}

  @override
  showProgress() {}

  @override
  void renderCategories(List<Category> categories) {
    print("$TAG renderCategories Fired");
    print("$TAG Categories Retrived : ${categories.toString()}");
    // first of all we clear the categories list just in case, then put the retrieved values from Server
    setState(() {
      categoriesList = categories;
    });
  }

  @override
  void onNoCategoriesFounded() {}

  Widget getCategoryItem(Category category) {
    return GestureDetector(
      onTap: () => onCategoryClick(category.id, category.name),
      child: Padding(
        padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
        child: Stack(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 260.0,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/placeholder.png',
                        image: category.imgUrl,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  category.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onCategoryClick(int categoryId, String categoryName) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MenuItemListScreen(
            categoryId,
            categoryName,
          ),
        ));
  }
}
