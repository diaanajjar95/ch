import 'package:ch/ui/splash/splash_page_presenter.dart';
import 'package:ch/ui/splash/splash_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> implements SplashPageView {
  SplashPresenter presenter;

  @override
  void initState() {
    // TODO: implement initState
    print('initState');
    super.initState();
    presenter = SplashPresenter();
    presenter.attachView(this);
    presenter.getAppInfo();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/splashimage.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SpinKitPulse(
                color: Colors.white,
                size: 100.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Coffee House',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                  letterSpacing: 2.0,
                  fontFamily: 'FjallaOne-Regular',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  onAppInfoRetrieved() {
    print('retrived');
    // redirect the user to the Login Screen.
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  onFailLoadAppInfo() {
    print('fail');
  }
}
