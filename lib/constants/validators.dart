String emailValidator(String email) {
  if (email.isEmpty) {
    return "Email cannot be empty";
  } else {
    String pattern =
        r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(email)) {
      return "Invalid Email";
    } else {
      return "";
    }
  }
}

String passwordValidator(String password) {
  if (password.isEmpty) {
    return "Password cannot be empty";
  } else {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(password)) {
      return "Invalid Password";
    } else {
      return "";
    }
  }
}

bool confirmPasswordValidator(String password, String confirmPassword) {
  return password == confirmPassword;
}

String nameValidator(String name) {
  if(name.isEmpty){
    return "Name cannot be empty";
  }else{
    return "";
  }
}