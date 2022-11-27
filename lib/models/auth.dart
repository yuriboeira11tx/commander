class Auth {
  String firstname = "";
  String lastname = "";
  String email = "";
  String authToken = "";
  String recoveryToken = "";
  String expiration = "";

  Auth();

  String getFirstname() => firstname;
  String getLastname() => lastname;
  String getEmail() => email;
  String getAuthToken() => authToken;
  String getRecoveryToken() => recoveryToken;
  String getExpiration() => expiration;

  void setFirstname(String newValue) => firstname = newValue;
  void setLastname(String newValue) => lastname = newValue;
  void setEmail(String newValue) => email = newValue;
  void setAuthToken(String newValue) => authToken = newValue;
  void setRecoveryToken(String newValue) => recoveryToken = newValue;
  void setExpiration(String newValue) => expiration = newValue;

  void logout() {
    setFirstname("");
    setLastname("");
    setEmail("");
    setAuthToken("");
    setRecoveryToken("");
    setExpiration("");
  }

  @override
  String toString() {
    return "Auth(${getFirstname()}, ${getLastname()}, ${getEmail()}, ${getAuthToken()}, ${getRecoveryToken()}, ${getExpiration()})";
  }
}
