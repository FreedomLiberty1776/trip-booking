import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// import 'deep_link.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();

  // static const _keyUsername = 'username';
  // static const _keyPets = 'pets';
  // static const _keyBirthday = 'birthday';

  // List<String> get storageKeys => _storageKeys;

  static clearToken() async {
    await _storage.delete(key: 'token');
  }

  // static clearSecureStorage(List<String> params) {
  //   params.forEach((param) async {
  //     await _storage.delete(key: param);
  //   });
  // }

  static Future logout() async {
    List<String> keys = ['token', 'phoneVerified', "rfCode", "rfLInk"];
    keys.forEach((param) async {
      await _storage.delete(key: param);
    });
  }

  static resetSecureStorage() {
    List<String> _storageKeys = [
      'token',
      'deliveryLocationInfo',
      'phone',
      'phoneVerified',
      'firstName',
      'lastName',
      "rfCode",
      "rfLInk"
    ];
    _storageKeys.forEach((param) async {
      await _storage.delete(key: param);
    });
  }

  static Future setToken(String token) async =>
      await _storage.write(key: 'token', value: token);

  static Future<String?> getToken() async {
    try {
      return await _storage.read(key: 'token');
    } catch (e) {
      return null;
    }
  }

  static Future setCart(String cart) async =>
      await _storage.write(key: 'cart', value: cart);

  static Future getCart() async {
    try {
      return await _storage.read(key: 'cart');
    } catch (e) {
      return null;
    }
  }

  static Future setMomo(String momo) async =>
      await _storage.write(key: 'momo', value: momo);

  static Future getMomo() async {
    try {
      return await _storage.read(key: 'momo');
    } catch (e) {
      return null;
    }
  }

  // static Future setrfCode(String rfCode, bool createLink) async {
  //   // rfCode is the referral code for this user
  //   await _storage.write(key: 'rfCode', value: rfCode);
  //   if (rfCode.isNotEmpty) {
  //     if (createLink) {
  //       setrfLInk(rfCode, false);
  //     }
  //   }
  // }

  static Future getrfCode() async {
    try {
      return await _storage.read(key: 'rfCode');
    } catch (e) {
      return null;
    }
  }

  static Future setFirstInstall(bool firstInstall) async {
    // firstInstall set when the app runs for the first time after install. will be use to check if a referral link should be applied or not.
    // print(
    //     "this is the first opne after install ........................................................");
    await _storage.write(key: 'firstInstall', value: firstInstall.toString());
  }

  static Future getFirstInstall() async {
    try {
      return await _storage.read(key: 'firstInstall');
    } catch (e) {
      return null;
    }
  }

  static Future setrefferedCode(String refferedCode) async {
    // refferedCode is the referral code that is shared with this user.
    if (refferedCode.isNotEmpty) {
      await _storage.write(key: 'refferedCode', value: refferedCode);
    }
  }

  static Future getrefferedCode() async {
    try {
      return await _storage.read(key: 'refferedCode');
    } catch (e) {
      return "";
    }
  }

  // static Future setrfLInk(String rfLInk, bool isLink) async {
  //   if (rfLInk.isNotEmpty) {
  //     // there is a posibility that rfCode can be an empty string
  //     if (!isLink) {
  //       String link =
  //           await FirebaseDynamicLinkService.createDeepLink(true, rfLInk);
  //       await _storage.write(key: 'rfLInk', value: link);
  //     } else {
  //       await _storage.write(key: 'rfLInk', value: rfLInk);
  //     }
  //   }
  // }

  static Future getrfLInk() async {
    try {
      return await _storage.read(key: 'rfLInk');
    } catch (e) {
      return null;
    }
  }

  // they have to have the option to copy and to share...

  static Future setUserPhone(String phone) async =>
      await _storage.write(key: 'phone', value: phone);

  static Future<String?> getUserPhone() async {
    try {
      return await _storage.read(key: 'phone');
    } catch (e) {
      return null;
    }
  }

  static Future setFirstName(String firstName) async =>
      await _storage.write(key: 'firstName', value: firstName);

  static Future<String?> getFirstName() async {
    try {
      return await _storage.read(key: 'firstName');
    } catch (e) {
      return null;
    }
  }

  static Future setFavorites(List favorites) async =>
      await _storage.write(key: 'favorites', value: jsonEncode(favorites));

  static Future<String> getFavorites() async {
    try {
      var t = await _storage.read(key: 'favorites');
      //print('this is the favoirtes pulled from storate $t');
      return t ?? "[]";
    } catch (e) {
      return "[]";
    }
  }

  static Future<String?> getName() async {
    try {
      String? first = await _storage.read(key: 'firstName');
      String? last = await _storage.read(key: 'lastName');
      return '$first $last';
    } catch (e) {
      return null;
    }
  }

  static Future setLastName(String lastName) async =>
      await _storage.write(key: 'lastName', value: lastName);

  static Future<String?> getLastName() async {
    try {
      return await _storage.read(key: 'lastName');
    } catch (e) {
      return null;
    }
  }

  // static Future setCities(String cities) async =>
  //     await _storage.write(key: 'cities', value: cities);

  // static Future<String?> getCities() async =>
  //     await _storage.read(key: 'cities');

  static Future setUPhoneVerified(bool verified) async =>
      await _storage.write(key: 'phoneVerified', value: '$verified');

  static Future<String?> getUPhoneVerified() async {
    try {
      return await _storage.read(key: 'phoneVerified');
    } catch (e) {
      return 'false';
    }
  }
}
