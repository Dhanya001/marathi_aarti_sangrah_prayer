import 'package:flutter/material.dart';

class AppColors {
  /// Light theme colors
  static const Color primary = Color(0xFF8A3A96);
  static const Color secondary = Color(0xFFF3EBF5);
  static const Color background = Color(0xFFFFFFFF);
  static const Color outline = Color(0xFFCDCDCD);
  static const Color dragHandle = Color(0xFFDCE1E8);
  static const Color filledlight = Color(0xFFF6F6F6);

  /// Dark theme colors
  static const Color primaryDark = Color(0xFFFFFFFF);
  static const Color secondaryDark = Color(0xFF282828);
  static const Color backgroundDark = Color(0xff101010);
  static const Color outlineDark = Color(0xFFFFFFFF);

  // Shared Colors
  static const Color skyBlue = Color(0xFFDCF8FF);
  static const Color darkBlue = Color(0xFF0071BC);
  static const Color deepBlue = Color(0xFF3D3C70);

  /// Light theme text colors
  static const Color primaryText = Color(0xff282828);
  static const Color secondaryText = Color(0xFF7F909F);
  static const Color tabsBackground = Color(0xffE8EDEF);

  /// Dark theme text colors
  static const Color primaryTextDark = Color(0xFFFFFFFF);
  static const Color secondaryTextDark = Color(0xFF7F909F);
  static const Color tabsBackgroundDark = Color(0xff323232);

  // Success, Warning, Error
  static const Color success = Color(0xFF28806F);
  static const Color warning = Color(0xFFFFA000);
  static const Color error = Color(0xFFEF4444);

  // Grays
  static const Color grayLight = Color(0xFFF5F5F5);
  static const Color gray = Color(0xFF9E9E9E);
  static const Color grayDark = Color(0xFF212121);
  static Color grayBg = const Color(0xFF9E9E9E).withAlpha(40);

  //Gradients
  static const LinearGradient darkBlueGradient = LinearGradient(
    colors: [Color(0xFF0A76BD), Color(0xFF064974)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const LinearGradient darkPurpleGradient = LinearGradient(
    colors: [Color(0xFF53518C), Color(0xFF232349)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  //textField colors
  static const Color secondaryTextFieldBackgroundColor = Color(0xFFEEEEEE);
  static const Color secondaryTextFieldBackgroundColorDark = Color(0xff595959);

  // Others
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF282828);
  static const Color transparent = Colors.transparent;
  static const Color greenLight = Colors.greenAccent;
  static const Color softPink100 = Color(0xFFF6EBEB);
  static const Color deepMaroon = Color(0xFF852221);
  static const Color pinFieldBgColor = Color(0xFFF5F5F5);
  static const Color unfocusedFieldBorderColor = Color(0xFFE5E5E5);
  static const Color greenRadioBtn = Color(0xFF39B54A);
  static const Color tabUnselectedText = Color(0xFF6B7280);
  static const Color mediumPersianBlue = Color(0xFF005A96);
  static const Color iceBlue = Color(0xFFDCF8FF);
  static const Color fieryRed = Color(0xFFF04438);
  static const Color red = Color(0xFFCC0000);
  static const Color orange = Colors.orange;
  static const Color amber = Colors.amber;
  static const Color lavender = Color(0xFFB378DD);
  static const Color butterscotch = Color(0xFFF7C480);
  static const Color rosePink = Color(0xFFE8899E);
  static const Color cloudGrey = Color(0xFFD9D9D9);
  static const Color green600 = Color(0xFF008000);
  static const Color caramel = Color(0xFFE09037);
  static const Color blue = Color(0xFF3B74DF);
  static const Color green = Colors.green;
  static const Color notificationBadge = Color(0xFFB61818);
  static const Color fieryOrange = Color(0xFFE95C28);
  static const Color amberGold = Color(0xFFCE7B04);
  static const Color leafyGreen = Color(0xFF85C556); // Calm and natural

  static const Color actionPending = Color(0xFFFF9E9E); // Calm and natural
  static const Color expiringSoon = Color(0xFFB50404); // Calm and natural
  static const Color waitingForOthers = Color(0xFFFFC346); // Calm and natural
  static const Color completed = Color(0xFF05AA82); // Calm and natural

  static const Color yellowCard = Color(0xFFFFF4E5);
  static const Color redCard = Color(0xFFFAE8E8);
  static const Color darkYellow = Color(0xFFD09D59);
  static const Color purple = Colors.purple;
  static const Color pink = Colors.pink;

  //testimonial colors
  static const Color testimonialTop1 = Color(0xFFBEEABE);
  static const Color testimonialBottom1 = Color(0xFFEBFFEB);
  static const Color testimonialTop2 = Color(0xFFBDD6FF);
  static const Color testimonialBottom2 = Color(0xFFEFF5FF);
  static const Color testimonialTop3 = Color(0xFFFFD1D1);
  static const Color testimonialBottom3 = Color(0xFFFAE8E8);
  //review colors

  //light
  static const Color reviewPrimaryText = Color(0xFF555555);
  static const Color reviewSecondaryText = Color(0xFF757575);

  //dark
  static const Color reviewPrimaryTextDark = Color(0xFFCCCCCC);
}
