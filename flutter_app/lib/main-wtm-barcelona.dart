
import 'package:flutter/material.dart';
import 'package:flutter_app/AppEntry.dart';

import 'Config.dart';

void main(){
  Config.appFlavor = Flavor.WTM_BARCELONA;
  runApp(AppEntry());
}