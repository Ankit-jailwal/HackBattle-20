import 'package:bloc/bloc.dart';
import 'package:ieeecrop/pages/Nav_page.dart';
import 'package:ieeecrop/pages/Rent_now.dart';
import 'package:ieeecrop/pages/Schemes.dart';
import 'package:ieeecrop/pages/Sell_now.dart';
import 'package:ieeecrop/pages/about_us.dart';
import 'package:ieeecrop/pages/agencies.dart';
import 'package:ieeecrop/pages/history.dart';
import 'package:ieeecrop/pages/Profile_page.dart';
import 'package:ieeecrop/pages/Maati_shop.dart';
import 'package:ieeecrop/pages/News_feed.dart';
import 'package:ieeecrop/pages/Maati_Cam.dart';
import 'package:ieeecrop/pages/Main_menu.dart';
import 'package:ieeecrop/pages/fertilizer_screen.dart';
import 'package:ieeecrop/pages/seed_screen.dart';
import 'package:ieeecrop/pages/pestcide_screen.dart';
import 'package:ieeecrop/pages/services.dart';
import 'package:ieeecrop/pages/tool_screen.dart';

enum DrawerEvents { ProfileEvent, news, cam,menu,history,output,about,shop,tool,seed,pest,ferti,nav,scheme,sell,rent,agen,ser}

abstract class DrawerStates {}

// Used for navigating between different blocs

class DrawerBloc extends Bloc<DrawerEvents, DrawerStates> {

  @override
  DrawerStates get initialState => Main_menu();
  @override
  Stream<DrawerStates> mapEventToState(DrawerEvents event) async* {
    switch (event) {
      case DrawerEvents.menu:
        yield Main_menu();
        break;
      case DrawerEvents.ProfileEvent:
        yield UserScreen();
        break;
      case DrawerEvents.news:
        yield Maati_news();
        break;
      case DrawerEvents.output:
        yield output(null);
        break;
      case DrawerEvents.cam:
        yield maaticam();
        break;
      case DrawerEvents.history:
        yield history_screen();
        break;
      case DrawerEvents.about:
        yield about_us();
        break;
      case DrawerEvents.shop:
        yield maati_shop();
        break;
      case DrawerEvents.ferti:
        yield fertilizer_screen();
        break;
      case DrawerEvents.pest:
        yield pesticide_screen();
        break;
      case DrawerEvents.seed:
        yield seed_screen();
        break;
      case DrawerEvents.tool:
        yield tool_screen();
        break;
      case DrawerEvents.nav:
        yield nav_page();
        break;
      case DrawerEvents.scheme:
        yield scheme_screen();
        break;
      case DrawerEvents.sell:
        yield Sell_now();
        break;
      case DrawerEvents.rent:
        yield Rent_now();
        break;
      case DrawerEvents.agen:
        yield agencies_screen();
        break;
      case DrawerEvents.ser:
        yield service();
        break;
    }
  }
}
