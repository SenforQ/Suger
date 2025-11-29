import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static const String _likedPrefix = 'liked_';
  static const String _favoritedPrefix = 'favorited_';
  static const String _agreedToTermsKey = 'agreed_to_terms';
  static const String _agreedToPrivacyKey = 'agreed_to_privacy';

  static Future<bool> isLiked(String characterNickName) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('$_likedPrefix$characterNickName') ?? false;
  }

  static Future<void> setLiked(String characterNickName, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$_likedPrefix$characterNickName', value);
  }

  static Future<bool> isFavorited(String characterNickName) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('$_favoritedPrefix$characterNickName') ?? false;
  }

  static Future<void> setFavorited(String characterNickName, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$_favoritedPrefix$characterNickName', value);
  }

  static Future<bool> hasAgreedToTerms() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_agreedToTermsKey) ?? false;
  }

  static Future<void> setAgreedToTerms(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_agreedToTermsKey, value);
  }

  static Future<bool> hasAgreedToPrivacy() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_agreedToPrivacyKey) ?? false;
  }

  static Future<void> setAgreedToPrivacy(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_agreedToPrivacyKey, value);
  }
}

