import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:cine_plex/controller/core_controller.dart';
import 'package:cine_plex/utils/config.dart';
import 'package:cine_plex/utils/pages.dart';
import 'package:cine_plex/utils/theme.dart';
import 'package:cine_plex/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const SpeedyBook());
}

class SpeedyBook extends StatelessWidget {
  const SpeedyBook({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      publicKey: Config.khaltiPublicKeyTest,
      builder: (context, navigatorKey) {
        return GetMaterialApp(
          localizationsDelegates: const [KhaltiLocalizations.delegate],
          navigatorKey: navigatorKey,
          initialBinding: BindingsBuilder(() {
            Get.put(CoreController());
          }),
          debugShowCheckedModeBanner: false,
          getPages: pages,
          theme: basicTheme(),
          initialRoute: SplashScreen.routeName,
        );
      },
    );
  }
}
