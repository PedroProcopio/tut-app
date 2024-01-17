import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:tut_app/domain/model/models.dart';

Future<DeviceInfo> getDeviceDetails() async {

  String name = "Unknown";
  String version = "Unknown";
  String identifier = "Unknown";

  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  try{
    if(Platform.isAndroid){
      var build = await deviceInfoPlugin.androidInfo;
      name = build.brand + " " +build.model;
      identifier = build.id;
      version = build.version.codename;
    }
    else if(Platform.isIOS){
    var build = await deviceInfoPlugin.iosInfo;
      name = build.name + " " +build.model;
      identifier = build.identifierForVendor!;
      version = build.systemVersion;
      
    }
  }on PlatformException{
    return DeviceInfo(name: name, identifier: identifier, version: version);

  }
  return DeviceInfo(name: name, identifier: identifier, version: version);



}