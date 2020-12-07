import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieeecrop/Language/translation/bloc/translation_bloc.dart';
import 'package:ieeecrop/Language/translation/global_translation.dart';
import 'package:ieeecrop/pages/login-page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ieeecrop/services/authentication-service.dart';
import 'package:splashscreen/splashscreen.dart';

final storage = FlutterSecureStorage();
final token = storage.read(key: "jwt");
int check;

//Main function to check internet and token before routing

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///
  /// Initialization of the translations based on supported language
  /// and the  fallback language (Optional)
  ///
  List<String> supportedLanguages = ["en","hi","bn","mr","ta","te","kn","ml","or","pa"];
  await translations.init(supportedLanguages, fallbackLanguage: 'en');
  return runApp(BlocProvider(
    create: (context) => TranslationBloc(),
    child: App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslationBloc, TranslationState>(
        builder: (context, state) {
          return MaterialApp(
            locale: state.locale ?? translations.locale,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            supportedLocales: translations.supportedLocales(),
            title: 'IEEE MAATI',
            home: SplashScreen(
              seconds: 3,
              image:Image.asset('assets/images/Maati_high.png'),
              photoSize: 130,
              title: Text("Welcome",style: TextStyle(
                fontFamily: 'Anton',
                color:Colors.green,
                fontSize: 24
              ),),
              loadingText: Text("AI based Crop recommendation App",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w500),),
              loaderColor: Colors.green.withOpacity(0.8),
              navigateAfterSeconds: LoginPage(),
            ),
          );
        });
  }
}
//test