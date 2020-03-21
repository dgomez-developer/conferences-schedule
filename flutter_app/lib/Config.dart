import 'dart:io';

import 'package:flutter/material.dart';

enum Flavor {
  T3CHFEST,
  WTM_MADRID,
  WTM_BARCELONA
}

class Config {


  static const MaterialColor t3chfestTheme = const MaterialColor(
    0xff1B1E54,
    const <int, Color>{
      50: const Color(0xFFE4E4EA),
      100: const Color(0xFFBBBCCC),
      200: const Color(0xFF8D8FAA),
      300: const Color(0xFF5F6287),
      400: const Color(0xFF3D406E),
      500: const Color(0xff1B1E54),
      600: const Color(0xFF181A4D),
      700: const Color(0xFF141643),
      800: const Color(0xFF10123A),
      900: const Color(0xFF080A29),
    },
  );

  static const MaterialColor wtmTheme = const MaterialColor(
    0xff6246BC,
    const <int, Color>{
      50: const Color(0xFFECE9F7),
      100: const Color(0xFFD0C8EB),
      200: const Color(0xFFB1A3DE),
      300: const Color(0xFF917ED0),
      400: const Color(0xFF7A62C6),
      500: const Color(0xff6246BC),
      600: const Color(0xFF5A3FB6),
      700: const Color(0xFF5037AD),
      800: const Color(0xFF462FA5),
      900: const Color(0xFF342097),
    },
  );

  static const MaterialColor wtmBarcelonaTheme = const MaterialColor(
    0xff0ABCA4,
    const <int, Color>{
      50: const Color(0xFFE2F7F4),
      100: const Color(0xFFB6EBE4),
      200: const Color(0xFF85DED2),
      300: const Color(0xFF85DED2),
      400: const Color(0xFF2FC6B2),
      500: const Color(0xff0ABCA4),
      600: const Color(0xFF09B69C),
      700: const Color(0xFF07AD92),
      800: const Color(0xFF05A589),
      900: const Color(0xFF039778),
    },
  );

  static Flavor appFlavor;

  static String get endpoint {
    switch (appFlavor) {
      case Flavor.T3CHFEST:
        return "https://conferences-schedule-api.herokuapp.com/api/t3chfest/schedule/2020";
//        return "http://10.0.2.2:5000/api/t3chfest/schedule/2020";
      case Flavor.WTM_BARCELONA:
        return "https://conferences-schedule-api.herokuapp.com/api/wtm-barcelona/schedule/2020";
//        return "http://10.0.2.2:5000/api/wtm-barcelona/schedule/2020";
      case Flavor.WTM_MADRID:
      default:
        return "https://conferences-schedule-api.herokuapp.com/api/wtm-madrid/schedule/2020";
//        return "http://10.0.2.2:5000/api/wtm-madrid/schedule/2020";

    }
  }

  static Widget get icon {
    switch (appFlavor) {
      case Flavor.T3CHFEST:
        return Image.asset("images/t3chfest-logo.png");
      case Flavor.WTM_BARCELONA:
      case Flavor.WTM_MADRID:
      default:
        return Image.asset("images/wtm-logo.png");
    }
  }

  static MaterialColor get theme {
    switch (appFlavor) {
      case Flavor.T3CHFEST:
        return t3chfestTheme;
      case Flavor.WTM_BARCELONA:
        return wtmBarcelonaTheme;
      case Flavor.WTM_MADRID:
      default:
        return wtmTheme;
    }
  }

  static Color get primaryColor {
    switch (appFlavor) {
      case Flavor.T3CHFEST:
        return t3chfestTheme.shade500;
      case Flavor.WTM_BARCELONA:
        return wtmBarcelonaTheme.shade500;
      case Flavor.WTM_MADRID:
      default:
        return wtmTheme.shade500;
    }
  }

  static String get googleAppId {
    switch (appFlavor) {
      case Flavor.T3CHFEST:
        return (Platform.isAndroid) ? '1:664050747376:android:036118d07e5b32390e7f35' : '1:664050747376:ios:d7995f0be416441b0e7f35';
      case Flavor.WTM_BARCELONA:
        return (Platform.isAndroid) ? '1:664050747376:android:4d1da730b92e5b360e7f35' : '1:664050747376:ios:ce248694c46d2d2d0e7f35';
      case Flavor.WTM_MADRID:
      default:
        return (Platform.isAndroid) ? '1:664050747376:android:b904f6f791227bde0e7f35' : '1:664050747376:ios:da3ecf8eb69bed5b0e7f35';
    }
  }

  static String get name {
    switch (appFlavor) {
      case Flavor.T3CHFEST:
        return 't3chfest';
      case Flavor.WTM_BARCELONA:
        return 'wtm barcelona';
      case Flavor.WTM_MADRID:
      default:
        return 'wtm madrid';
    }
  }
}