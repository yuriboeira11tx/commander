import 'package:string_validator/string_validator.dart' as validator;

class RegisterCredential {
  Email _email = Email('');
  void setEmail(String newEmail) => _email = Email(newEmail);
  Email get email => _email;

  Password _password = Password('');
  void setPassword(String newPassword) => _password = Password(newPassword);
  Password get password => _password;

  Firstname _firstname = Firstname('');
  void setFirstname(String newValue) => _firstname = Firstname(newValue);
  Firstname get firstname => _firstname;

  Lastname _lastname = Lastname('');
  void setLastname(String newValue) => _lastname = Lastname(newValue);
  Lastname get lastname => _lastname;

  Phone _phone = Phone('');
  void setPhone(String newValue) => _phone = Phone(newValue);
  Phone get phone => _phone;

  String? validate() {
    String? validate = _email.validate();
    if (validate != null) {
      return validate;
    }

    validate = _password.validate();
    if (validate != null) {
      return validate;
    }

    validate = firstname.validate();
    if (validate != null) {
      return validate;
    }

    validate = lastname.validate();
    if (validate != null) {
      return validate;
    }

    validate = phone.validate();
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

    if (value.length < 6) {
      return "Senha muito curta";
    }

    return null;
  }
}

class Firstname {
  final String value;

  Firstname(this.value);

  String? validate() {
    if (value.isEmpty) {
      return "Campo de nome não pode ser vazio";
    }

    return null;
  }
}

class Lastname {
  final String value;

  Lastname(this.value);

  String? validate() {
    if (value.isEmpty) {
      return "Campo de último nome não pode ser vazio";
    }

    return null;
  }
}

class Phone {
  final String value;

  Phone(this.value);

  String? validate() {
    if (value.isEmpty) {
      return "Campo de número de telefone não pode ser vazio";
    }

    return null;
  }
}
