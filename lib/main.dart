import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:virtual_mall/core/services/auth/authentication_service.dart';
import 'package:virtual_mall/core/services/auth/firebase_auth.dart';
import 'package:virtual_mall/core/services/business/business_service.dart';
import 'package:virtual_mall/core/services/business/firebase_business.dart';
import 'package:virtual_mall/core/services/buyCar/buy_car_service.dart';
import 'package:virtual_mall/core/services/buyCar/firebase_buy_car.dart';
import 'package:virtual_mall/core/viewmodels/home_model.dart';
import 'package:virtual_mall/core/viewmodels/login_model.dart';
import 'package:virtual_mall/keys/keys_loader.dart';
import 'package:virtual_mall/keys/keys_model.dart';
import 'package:virtual_mall/translation/app_localizations.dart';
import 'package:virtual_mall/ui/router.dart';
import 'package:virtual_mall/ui/shared/app_colors.dart';
import 'package:virtual_mall/ui/views/home_view.dart';
import 'package:virtual_mall/ui/views/sing_in_view.dart';
import 'package:virtual_mall/ui/views/splash_view.dart';

import 'core/models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) =>
              KeysLoader(secretPath: "assets/secret s.json").load(),
        ),
        Provider(
          create: (_) => AppFirebaseAuth(),
        ),
        ProxyProvider<AppFirebaseAuth, AuthenticationService>(
          update: (_, api, previous) =>
              (previous ?? AuthenticationService())..api = api,
          dispose: (_, auth) => auth.dispose(),
        ),
        ProxyProvider<Keys, AppFirebaseBusiness>(
          update: (_, keys, previous) =>
              (previous ?? AppFirebaseBusiness())..keys = keys,
        ),
        ProxyProvider<AppFirebaseBusiness, BusinessService>(
          update: (_, api, previous) =>
              (previous ?? BusinessService())..api = api,
          dispose: (_, auth) => auth.dispose(),
        ),
        Provider<AppFirebaseBuyCar>(
          create: (_) => AppFirebaseBuyCar(),
        ),
        ProxyProvider<AppFirebaseBuyCar, BuyCarService>(
          update: (_, api, car) => (car ?? BuyCarService())..api = api,
        ),
        FutureProvider(
          create: (context) =>
              Provider.of<AuthenticationService>(context, listen: false)
                  .getLoggedUser(),
        ),
        StreamProvider<User>(
          create: (context) {
            return Provider.of<AuthenticationService>(context, listen: false)
                .user;
          },
        ),
        ChangeNotifierProxyProvider<AuthenticationService, LoginModel>(
          create: (_) => LoginModel(),
          update: (_, auth, model) => model..authenticationService = auth,
        ),
        ChangeNotifierProxyProvider<BusinessService, HomeModel>(
          create: (_) => HomeModel(),
          update: (_, businessService, model) => model
            ..businessService = businessService
            ..getPosts(),
        )
      ],
      child: MaterialApp(
        localizationsDelegates: [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [Locale("en"), Locale("es")],
        title: 'La Panera',
        theme: ThemeData(
          primaryColorBrightness: Brightness.dark,
            primarySwatch: Colors.amber,
            primaryColorLight: Colors.amber,
            brightness: Brightness.light,
            primaryColorDark: primaryColor,
            primaryColor: primaryColor,
            accentColor: Colors.orangeAccent,
            appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Colors.black),
                color: toolbarColor,
                textTheme: TextTheme(
                    title: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 20.0,
                        color: Colors.black)))),
        routes: {
          // `initialRoute` is not enough
          // the route `/` will always be pushed. So `/` should handle displaying LoginView internally
          // see https://stackoverflow.com/questions/56145378/why-is-initstate-called-twice/56145478#56145478
          '/': (context) {
            if (Provider.of<User>(context) == null) return const SplashView();
            return Provider.of<User>(context)?.id != null
                ? const HomeView()
                : const LoginView();
          },
          '/login': (_) => const LoginView(),
        },
        onGenerateRoute: Router.generateRoute,
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        ),
      ),
    );
  }
}
