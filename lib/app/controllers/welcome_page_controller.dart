

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomePageController extends GetxController {
  
  launcherInBrowser(Uri url) {
    launchUrl(url, mode: LaunchMode.externalApplication);
  }
  
}
