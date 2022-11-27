import 'dart:developer';
import 'package:commander/models/auth.dart';
import 'package:commander/repositories/account_repository.dart';
import 'package:commander/utils/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountStore {
  SharedPreferences? sharedPreferences;
  Auth currentAuth = Auth();
  AccountRepository accountRepository = AccountRepository();

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    currentAuth.setFirstname(sharedPreferences!.getString("firstname") ?? "");
    currentAuth.setLastname(sharedPreferences!.getString("lastname") ?? "");
    currentAuth.setEmail(sharedPreferences!.getString("email") ?? "");
    currentAuth.setAuthToken(sharedPreferences!.getString("auth_token") ?? "");
    currentAuth
        .setRecoveryToken(sharedPreferences!.getString("recovery_token") ?? "");
    currentAuth.setExpiration(sharedPreferences!.getString("expiration") ?? "");
  }

  Future<void> login(Auth newAuth) async {
    currentAuth = newAuth;

    log(currentAuth.toString());

    await sharedPreferences!.setString("firstname", currentAuth.getFirstname());
    await sharedPreferences!.setString("lastname", currentAuth.getLastname());
    await sharedPreferences!.setString("email", currentAuth.getEmail());
    await sharedPreferences!
        .setString("auth_token", currentAuth.getAuthToken());
    await sharedPreferences!
        .setString("recovery_token", currentAuth.getRecoveryToken());
    await sharedPreferences!
        .setString("expiration", currentAuth.getExpiration());
  }

  Future<void> logout() async {
    log("[LOG] Cleaning user preferences and login...");

    currentAuth.logout();
    log(currentAuth.toString());

    await sharedPreferences!.setString("firstname", "");
    await sharedPreferences!.setString("lastname", "");
    await sharedPreferences!.setString("email", "");
    await sharedPreferences!.setString("auth_token", "");
    await sharedPreferences!.setString("recovery_token", "");
    await sharedPreferences!.setString("expiration", "");
  }

  Future<Enum> verifyAuth() async {
    log("[LOG] Verifying status of authentication");

    if (currentAuth.getExpiration().isEmpty) {
      return StatusAuth.loggedOut;
    } else {
      Enum response = await isAuthenticated();

      if (response == StatusAuth.authenticated) return response;

      try {
        Map<String, dynamic> newTokens =
            await accountRepository.renewTokens(currentAuth);
        await sharedPreferences!.setString("auth_token", newTokens["auth_token"]);
        await sharedPreferences!
            .setString("recovery_token", newTokens["recovery_token"]);
        await sharedPreferences!
            .setString("expiration", "${newTokens["expiration"]}");
        return StatusAuth.authenticated;
      } catch (e) {
        log(e.toString());
      }

      return StatusAuth.deauthenticated;
    }
  }

  Future<Enum> isAuthenticated() async {
    if (currentAuth.getAuthToken().isNotEmpty &&
        currentAuth.getRecoveryToken().isNotEmpty &&
        DateTime.parse(currentAuth.getExpiration()).isAfter(DateTime.now())) {
      log("[LOG] Token active");
      return StatusAuth.authenticated;
    }

    log("[LOG] Token expired");
    return StatusAuth.deauthenticated;
  }

  Auth getCurrentAuth() => currentAuth;
}
