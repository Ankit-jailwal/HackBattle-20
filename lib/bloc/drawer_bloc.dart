import 'package:bloc/bloc.dart';
import 'package:ieeecrop/pages/Nav_page.dart';
import 'package:ieeecrop/pages/about_us.dart';
import 'package:ieeecrop/pages/history.dart';
import 'package:ieeecrop/pages/Profile_page.dart';
import 'package:ieeecrop/pages/Maati_shop.dart';
import 'package:ieeecrop/pages/News_feed.dart';
import 'package:ieeecrop/pages/Maati_Cam.dart';
import 'package:ieeecrop/pages/Main_menu.dart';
import 'package:ieeecrop/pages/fertilizer_screen.dart';
import 'package:ieeecrop/pages/seed_screen.dart';
import 'package:ieeecrop/pages/pestcide_screen.dart';
import 'package:ieeecrop/pages/tool_screen.dart';

enum DrawerEvents { ProfileEvent, news, cam,menu,history,output,about,shop,tool,seed,pest,ferti,nav}

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
    }
  }
}
