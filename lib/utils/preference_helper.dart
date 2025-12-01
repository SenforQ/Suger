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

  static const String _userAvatarPathKey = 'user_avatar_path';
  static const String _userNameKey = 'user_name';

  static Future<String?> getUserAvatarPath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userAvatarPathKey);
  }

  static Future<void> setUserAvatarPath(String? path) async {
    final prefs = await SharedPreferences.getInstance();
    if (path == null) {
      await prefs.remove(_userAvatarPathKey);
    } else {
      await prefs.setString(_userAvatarPathKey, path);
    }
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  }

  static Future<void> setUserName(String? name) async {
    final prefs = await SharedPreferences.getInstance();
    if (name == null) {
      await prefs.remove(_userNameKey);
    } else {
      await prefs.setString(_userNameKey, name);
    }
  }

  static Future<bool> isVipActive() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('user_vip_active') ?? false;
  }

  static const String _freePaintingCountKey = 'free_painting_count';
  static const String _vipFreePaintingCountKey = 'vip_free_painting_count';
  static const String _vipFreePaintingResetDateKey = 'vip_free_painting_reset_date';
  static const int _initialFreeCount = 3;
  static const int _vipMonthlyFreeCount = 10;

  static Future<int> getFreePaintingCount() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_freePaintingCountKey)) {
      await prefs.setInt(_freePaintingCountKey, _initialFreeCount);
      return _initialFreeCount;
    }
    return prefs.getInt(_freePaintingCountKey) ?? 0;
  }

  static Future<void> setFreePaintingCount(int count) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_freePaintingCountKey, count);
  }

  static Future<int> getVipFreePaintingCount() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final lastResetDateStr = prefs.getString(_vipFreePaintingResetDateKey);
    
    if (lastResetDateStr == null) {
      await prefs.setString(_vipFreePaintingResetDateKey, now.toIso8601String());
      await prefs.setInt(_vipFreePaintingCountKey, _vipMonthlyFreeCount);
      return _vipMonthlyFreeCount;
    }

    final lastResetDate = DateTime.parse(lastResetDateStr);
    final isNewMonth = now.year != lastResetDate.year || now.month != lastResetDate.month;
    
    if (isNewMonth) {
      await prefs.setString(_vipFreePaintingResetDateKey, now.toIso8601String());
      await prefs.setInt(_vipFreePaintingCountKey, _vipMonthlyFreeCount);
      return _vipMonthlyFreeCount;
    }

    return prefs.getInt(_vipFreePaintingCountKey) ?? _vipMonthlyFreeCount;
  }

  static Future<void> setVipFreePaintingCount(int count) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_vipFreePaintingCountKey, count);
  }

  static Future<bool> useFreePainting() async {
    final isVip = await isVipActive();
    if (isVip) {
      final count = await getVipFreePaintingCount();
      if (count > 0) {
        await setVipFreePaintingCount(count - 1);
        return true;
      }
    } else {
      final count = await getFreePaintingCount();
      if (count > 0) {
        await setFreePaintingCount(count - 1);
        return true;
      }
    }
    return false;
  }
}

