import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:ieeecrop/Language/translation/bloc/translation_bloc.dart';
import 'package:ieeecrop/Language/translation/global_translation.dart';
import 'package:ieeecrop/Weahter_API/ui/screen/weather_main_screen.dart';
import 'package:ieeecrop/bloc/drawer_bloc.dart';
import 'package:ieeecrop/custom-widgets/core/custom-app-bar.dart';
import 'package:ieeecrop/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ieeecrop/pages/Maati_shop.dart';
import 'package:ieeecrop/pages/Nav_page.dart';
import 'package:ieeecrop/pages/Rent_now.dart';
import 'package:ieeecrop/pages/Schemes.dart';
import 'package:ieeecrop/pages/Sell_now.dart';
import 'package:ieeecrop/pages/about_us.dart';
import 'package:ieeecrop/pages/agencies.dart';
import 'package:ieeecrop/pages/fertilizer_screen.dart';
import 'package:ieeecrop/pages/history.dart';
import 'package:ieeecrop/pages/Main_menu.dart';
import 'package:toast/toast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ieeecrop/pages/Profile_page.dart';
import 'package:ieeecrop/pages/News_feed.dart';
import 'package:ieeecrop/pages/pestcide_screen.dart';
import 'package:ieeecrop/pages/seed_screen.dart';
import 'package:ieeecrop/pages/services.dart';
import 'package:ieeecrop/pages/tool_screen.dart';
import 'package:ieeecrop/second_screen.dart';
import 'package:ieeecrop/services/authentication-service.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Functions_and_route.dart';
import 'bottom_sheet_shape.dart';
import 'package:ieeecrop/pages/Maati_Cam.dart';
import 'drawer_item.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:ieeecrop/constants.dart';

class DrawerLayout extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<DrawerLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
      future: AuthenticationService().login(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(), //Circular progress indicator
          );
        } else if (snapshot.data['token'] != null) {
          print(snapshot.data);
          var rest = snapshot.data['token'] as String;
          storage.write(
              key: "jwt", value: rest); //Storing token in local storage
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'IEEE APP',
            theme: ThemeProvider.of(context),
            home: BlocProvider<DrawerBloc>(
              create: (context) => DrawerBloc(),
              child: Drawermain(),
            ),
          );
        } else {
          return NetworkGiffyDialog(
            image: Image.network(
              "https://media.giphy.com/media/l4pLY0zySvluEvr0c/giphy.gif",
              fit: BoxFit.cover,
            ),
            entryAnimation: EntryAnimation.TOP_LEFT,
            title: Text(
              translations.text('login.er'),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
            description: Text(
              translations.text('login.des'),
              textAlign: TextAlign.center,
            ),
            onlyOkButton: true,
            onOkButtonPressed: () {
              Navigator.pop(context);
            },
          );
        }
      },
    ));
  }
}

class Drawermain extends StatefulWidget {
  @override
  _DrawermainState createState() => _DrawermainState();
}

class _DrawermainState extends State<Drawermain>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation;
  Animation rotationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); //Global key
  @override

  //Functionality to manage animations and drawer

  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController);
    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(animationController);
    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0),
    ]).animate(animationController);
    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return BlocBuilder<TranslationBloc, TranslationState>(
            builder: (context, state) {
          return Scaffold(
            key: _scaffoldKey,
            body: Column(
              children: <Widget>[
                BlocBuilder<DrawerBloc, DrawerStates>(
                  builder: (context, DrawerStates state) {
                    return CustomAppBar(
                      isBig: (state is UserScreen),
                      height: (state is UserScreen) ? 250 : 150,
                      leading: ThemeSwitcher(
                        builder: (context) {
                          return AnimatedCrossFade(
                            duration: Duration(milliseconds: 1),
                            crossFadeState: ThemeProvider.of(context)
                                        .brightness == // light and dark theme
                                    Brightness.light
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                            firstChild: IconButton(
                              onPressed: () => ThemeSwitcher.of(context)
                                  .changeTheme(theme: kDarkTheme),
                              icon: Container(
                                child: Center(
                                  child: Icon(
                                    LineAwesomeIcons.moon_1,
                                    size: 34,
                                  ),
                                ),
                              ),
                            ),
                            secondChild: IconButton(
                              onPressed: () => ThemeSwitcher.of(context)
                                  .changeTheme(theme: kLightTheme),
                              icon: Container(
                                child: Center(
                                    child: Icon(
                                  LineAwesomeIcons.sun,
                                  size: 34,
                                )),
                              ),
                            ),
                          );
                        },
                      ),
                      title: findSelectedTitle(state),
                      trailing: IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState.openEndDrawer();
                        },
                        icon: Container(
                          child: Center(
                            child: Icon(
                              Icons.settings,
                              size: 34,
                            ),
                          ),
                        ),
                      ),
                      childHeight: 100,
                    );
                  },
                ),
                Expanded(
                  child: BlocBuilder<DrawerBloc, DrawerStates>(
                    //Blocbuilder
                    builder: (context, DrawerStates state) {
                      return state as Widget;
                    },
                  ),
                ),
              ],
            ),
            endDrawer: ClipPath(
              clipper: _DrawerClipper(),
              child: Drawer(
                child: Container(
                  padding: const EdgeInsets.only(top: 48, bottom: 32),
                  height: (orientation == Orientation.portrait)
                      ? MediaQuery.of(context).size.height
                      : MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          BlocProvider.of<DrawerBloc>(context)
                              .add(DrawerEvents.menu);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          margin:
                              const EdgeInsets.only(right: 20, bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Icon(
                            Icons.home,
                            size: 34,
                          ),
                        ),
                      ),
                      DrawerItem(
                        text: translations.text('menu.b1'),
                        onPressed: () {
                          Navigator.pop(context);
                          BlocProvider.of<DrawerBloc>(context).add(
                              DrawerEvents
                                  .cam); //Drawer navigation to Event screen
                        },
                      ),
                      DrawerItem(
                        text: translations.text('menu.b2'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                              .news); //Drawer navigation to Create event screen
                        },
                      ),
                      DrawerItem(
                        text: translations.text('menu.b7'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                              .nav); //Drawer navigation to Create event screen
                        },
                      ),
                      DrawerItem(
                        text: translations.text('menu.b3'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => WeatherMainScreen()),
                          );
                        }, //Drawer navigation to About page (Under construction)
                      ),
                      DrawerItem(
                        text: translations.text('menu.b8'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                              .scheme); //Drawer navigation to Create event screen
                        },
                      ),
                      DrawerItem(
                        text: translations.text('menu.b4'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          launch("tel://1800-180-1551");
                        }, //Drawer navigation to About page (Under construction)
                      ),
                      DrawerItem(
                        text: translations.text('menu.b5'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          BlocProvider.of<DrawerBloc>(context)
                              .add(DrawerEvents.history);
                        }, //Drawer navigation to About page (Under construction)
                      ),
                      DrawerItem(
                        text: translations.text('menu.b6'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          BlocProvider.of<DrawerBloc>(context)
                              .add(DrawerEvents.about);
                        }, //Drawer navigation to About page (Under construction)
                      ),
                      DropdownButton(
                          value: state.locale.languageCode,
                          items: translations.supportedLocales().map((l) {
                            return DropdownMenuItem(
                              child: Text(
                                  '${get_lang(l.languageCode)} (${l.languageCode})'),
                              value: l.languageCode,
                            );
                          }).toList(),
                          onChanged: (l) {
                            BlocProvider.of<TranslationBloc>(context).add(
                              SwitchLanguage(language: l),
                            );
                            print(l);

                          }),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _openSignOutDrawer(context);
                        },
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: translations.text('login.out'), //Signout
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ]),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}

// States for inherited widgets

String findSelectedTitle(DrawerStates state) {
  if (state is UserScreen) {
    return "User Profile";
  } else if (state is maaticam) {
    return translations.text('menu.b1');
  } else if (state is Main_menu) {
    return translations.text('menu.head');
  } else if (state is history_screen) {
    return translations.text('menu.b5');
  } else if (state is Maati_news)
    return translations.text('menu.b2');
  else if (state is about_us) return translations.text('menu.b6');
  else if(state is maati_shop)
  {
    return "Maati Shop";
  }
  else if(state is seed_screen)
  {
    return "Seeds";
  }
  else if(state is fertilizer_screen)
  {
    return "Fertilizers";
  }
  else if(state is pesticide_screen)
  {
    return "Pesticides";
  }
  else if(state is tool_screen)
  {
    return "Tools";
  }
  else if(state is nav_page)
  {
    return "Maati Shop";
  }
  else if(state is scheme_screen)
  {
    return "Maati Schemes";
  }
  else if(state is Rent_now)
  {
    return "Maati Rent";
  }
  else if(state is Sell_now)
  {
    return "Maati Sell";
  }
  else if(state is agencies_screen)
  {
    return "Maati Agencies";
  }
  else if(state is service)
  {
    return "Maati Services";
  }

}

//Signout animation and functionality

void _openSignOutDrawer(BuildContext context) {
  showModalBottomSheet(
      shape: BottomSheetShape(),
      backgroundColor: Theme.of(context).primaryColorLight,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(
            top: 24,
            bottom: 16,
            left: 48,
            right: 48,
          ),
          height: 180,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "Are you sure you want to sign out?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        storage.delete(key: "jwt");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => App()),
                        );
                      },
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Text(
                        "Sign out",
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: OutlineButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => mainpage()),
                        );
                      },
                      borderSide: BorderSide(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        "Stay logged in",
                        style: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}

// Curve in drawer

class _DrawerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(50, 0);
    path.quadraticBezierTo(0, size.height / 2, 50, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class CircularButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final Function onClick;

  CircularButton(
      {this.color, this.width, this.height, this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(icon: icon, enableFeedback: true, onPressed: onClick),
    );
  }
}

// Social media links

String _launchURL_fb = 'https://www.facebook.com/ieeeditu';
String _launchURL_insta = 'https://www.instagram.com/ieeeditu/';
String _launchURL_lin =
    'https://www.linkedin.com/feed/update/urn:li:activity:6697023777416478720/';
Future<void> _launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'header_key': 'header_value'},
    );
  } else {
    throw 'Could not launch $url';
  }
}
