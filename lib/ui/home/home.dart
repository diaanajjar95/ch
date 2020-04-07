import 'package:ch/data/database/DatabaseHelper.dart';
import 'package:ch/ui/home/favorites/FavoritesScreen.dart';
import 'package:ch/ui/home/main_menu/MainMenuScreen.dart';
import 'package:ch/ui/home/offers/OffersScreen.dart';
import 'package:ch/ui/home/tables/TablesScreen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // vars
  var selectedPageIndex = 0;

  var pages = [
    MainMenuScreen(),
    TablesScreen(),
    OffersScreen(),
    FavoritesScreen(),
  ];

  var pagesTitle = [
    "Menu",
    "Tables",
    "Offers",
    "Favorites",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('home : initState');
  }

  @override
  Widget build(BuildContext context) {
    print('home : build');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(
          pagesTitle[selectedPageIndex],
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 16.0, 0.0),
            child: Icon(
              Icons.share,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: pages[selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            title: Text(
              '',
            ),
            icon: Icon(
              Icons.home,
              color: selectedPageIndex == 0 ? Colors.black : Colors.blueGrey,
            ),
          ),
          BottomNavigationBarItem(
            title: Text(
              '',
            ),
            icon: Icon(
              Icons.table_chart,
              color: selectedPageIndex == 1 ? Colors.black : Colors.blueGrey,
            ),
          ),
          BottomNavigationBarItem(
            title: Text(
              '',
            ),
            icon: Icon(
              Icons.local_offer,
              color: selectedPageIndex == 2 ? Colors.black : Colors.blueGrey,
            ),
          ),
          BottomNavigationBarItem(
            title: Text(
              '',
            ),
            icon: Icon(
              Icons.favorite,
              color: selectedPageIndex == 3 ? Colors.black : Colors.blueGrey,
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedPageIndex = index;
          });
        },
        currentIndex: selectedPageIndex,
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: ExactAssetImage('assets/splashimage.jpeg'),
                      minRadius: 40,
                      maxRadius: 40,
                    ),
                    SizedBox(height: 10,),
                    Text(
                      'Diaa Najjar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
            ListTile(
              title: Text('profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 0.5,
              color: Colors.grey,
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 0.5,
              color: Colors.grey,
            ),
            ListTile(
              title: Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 0.5,
              color: Colors.grey,
            ),
            ListTile(
              title: Text('About us'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 0.5,
              color: Colors.grey,
            ),
            ListTile(
              title: Text('Contact us'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 0.5,
              color: Colors.grey,
            ),
            ListTile(
              title: Text('Change Password'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 0.5,
              color: Colors.grey,
            ),
            ListTile(
              title: Text('Sign out'),
              onTap: () {
                // delete the user record in the data base and redirect the user to the login screen
                DatabaseHelper().deleteUser();
                Navigator.pop(context);
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
