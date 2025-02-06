// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';

double mediaQueryWidth =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;
double mediaQueryHeight =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;

double fem = mediaQueryWidth / 375;
