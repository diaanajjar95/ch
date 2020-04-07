import 'package:ch/data/models/MenuItem.dart';
import 'package:ch/ui/menuItemsList/MenuItemListPresenter.dart';
import 'package:ch/ui/menuItemsList/menuItemListView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuItemListScreen extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  MenuItemListScreen(this.categoryId, this.categoryName);

  @override
  _MenuItemListScreenState createState() => _MenuItemListScreenState(
      categoryId: categoryId, categoryName: categoryName);
}

class _MenuItemListScreenState extends State<MenuItemListScreen>
    implements menuItemListView {
  // const
  static const TAG = "MenuItemListScreen";

  // vars
  final int categoryId;
  final String categoryName;
  MenuItemListPresenter presenter;
  var menuItemsList = List<MenuItem>();

  _MenuItemListScreenState(
      {Key key, @required this.categoryId, @required this.categoryName});

  @override
  void initState() {
    super.initState();
    print("$TAG , initState categoryID : $categoryId");
    presenter = MenuItemListPresenter();
    presenter.attachView(this);
    if (categoryId != null) {
      // we call here the getMenuItems API
      print("$TAG , getMenuItemsByCategoryId called from the presenter");
      presenter.getMenuItemsByCategoryId(categoryId);
    } else {
      // show message to the user tell him that there is no items her.
    }
  }

  @override
  void dispose() {
    super.dispose();
    print("$TAG , dispose");
  }

  @override
  Widget build(BuildContext context) {
    print("$TAG , build");
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: Colors.grey[900],
        title: Text(
          categoryName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            letterSpacing: 1,
          ),
        ),
      ),
      backgroundColor: Colors.grey[900],
      body: ListView.builder(
        itemBuilder: (context, position) {
          MenuItem menuItem = menuItemsList[position];
          return getMenuItem(menuItem);
        },
        itemCount: menuItemsList.length,
      ),
    );
  }

  Widget getMenuItem(MenuItem menuItem) {
    return GestureDetector(
      onTap: () => onMenuItemClick(menuItem.id),
      child: Padding(
        padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  height: 120,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/placeholder.png',
                      image: menuItem.imgUrl,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        menuItem.subTitle,
                        style: TextStyle(
                          color: Colors.grey,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    Text(
                      menuItem.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  hideProgress() {
    print("$TAG , hideProgrees");
  }

  @override
  void onNoMenuItemsFounded() {
    print("$TAG , onNoMenuItemsFounded");
  }

  @override
  void renderMenuItems(List<MenuItem> menuItemsList) {
    print("$TAG , renderMenuItems : ${menuItemsList.toString()}");
    this.menuItemsList.clear();
    setState(() {
      this.menuItemsList = menuItemsList;
    });
  }

  @override
  showMessage(String message) {
    print("$TAG , showMessage");
  }

  @override
  showProgress() {
    print("$TAG , showProgress");
  }

  onMenuItemClick(int id) {

  }
}
