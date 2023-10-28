
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static const userEmail = "userEmail";
  static const mood = 'mood';


  static void setMood(bool isDark) {
    Hive.box(HiveHelper.mood).put(HiveHelper.mood, isDark);
  }

  static bool getMood() {
    return Hive.box(HiveHelper.mood).isNotEmpty
        ? Hive.box(HiveHelper.mood).get(HiveHelper.mood)
        : false;
  }

  static void setUserEmail(String email) {
    Hive.box(HiveHelper.userEmail).put(HiveHelper.userEmail, email);
  }

  static String getUserEmail() {
    return Hive.box(HiveHelper.userEmail).isNotEmpty
        ? Hive.box(HiveHelper.userEmail).get(HiveHelper.userEmail)
        : '';
  }

}
