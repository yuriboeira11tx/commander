import 'package:string_validator/string_validator.dart' as validator;

class LoginCredential {
  Email _email = Email('');
  void setEmail(String newEmail) => _email = Email(newEmail);
  Email get email => _email;

  Password _password = Password('');
  void setPassword(String newPassword) => _password = Password(newPassword);
  Password get password => _password;

  String? validate() {
    String? validate = _email.validate();
    if (validate != null) {
      return validate;
    }

    validate = _password.validate();
    if (validate != null) {
      return validate;
    }

    return null;
  }
}

class Email {
  final String value;

  Email(this.value);

  String? validate() {
    if (value.isEmpty) {
      return "Campo de e-mail não pode ser vazio";
    }

    if (!validator.isEmail(value)) {
      return "Isso não é um e-mail";
    }

    return null;
  }
}

class Password {
  final String value;

  Password(this.value);

  String? validate() {
    if (value.isEmpty) {
      return "Campo de senha não pode ser vazio";
    }

    return null;
  }
}
