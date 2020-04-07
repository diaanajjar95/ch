import 'package:ch/common/AppUtils.dart';
import 'package:ch/data/database/DatabaseHelper.dart';
import 'package:ch/ui/home/home.dart';
import 'package:ch/ui/login/login_presenter.dart';
import 'package:ch/ui/login/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> implements LoginPageView {
  // vars
  LoginPresenter presenter;

  // widgets
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print('login : initState');
    presenter = LoginPresenter();
    presenter.attachView(this);
    // check if the user is logged in so remove this page immediately
    presenter.isLoggedIn().then((value) {
      if(value){
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      }
    });
  }

  @override
  void dispose() {
    print('login : dispose');
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('login : build');
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [Colors.grey[900], Colors.grey[800], Colors.grey[400]]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "welcome back ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(60))),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ]),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey[200],
                                ),
                              ),
                            ),
                            child: TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey[200],
                                ),
                              ),
                            ),
                            child: TextField(
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        // make login request.
                        String emailInputText = emailController.text.trim();
                        String passwordInputText =
                            passwordController.text.trim();
                        if (emailInputText.isEmpty) {
                          print('email is empty');
                          return;
                        }
                        if (passwordInputText.isEmpty) {
                          print('password is empty');
                          return;
                        }
                        if (!AppUtils.isValidEmail(emailInputText)) {
                          // show message
                          print('in valid email');
                          return;
                        }
                        if (!AppUtils.isValidPassword(passwordInputText)) {
                          // show message
                          print('in valid password');
                          return;
                        }
                        presenter.login(
                            email: emailInputText, password: passwordInputText);
                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey[900],
                        ),
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Dose not have account?',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            // go to sign up screen
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  onLoginFailed() {
    print('onLoginFailed');
    // show a message to the user.
    Fluttertoast.showToast(
        msg: "Email or Password are incorrect :)",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  onLoginSuccess() {
    print('onLoginSuccess');
    /*regular navigation method*/
//    Navigator.pushReplacementNamed(context, '/home');

    /*
    * I figured it out. It was the Navigator.pushAndRemoveUntil function.
    *  Where i had to pass the Home widget as the newRoute,
    *  and the "/Home" route as the predicate
    * */
    /* Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Home()),
        ModalRoute.withName("/login"));*/

    /*
    * even simpler and I think a better way would be to do it this way,
    *  this Schedules a callback for the end of the current persistent frame,
    * to push to route /loginPage and removes all the previous routes,
    * this way you can make sure that all the frames are rendered and then
    *  you navigate to next page. 
    **/
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
  }

  @override
  hideProgress() {
    Navigator.pop(context); //pop dialog
  }

  @override
  showProgress() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(Colors.grey[900]),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Please Wait ...",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[900],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
