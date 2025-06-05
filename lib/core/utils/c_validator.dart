class CValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите email';
    }

    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Некорректный email';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите пароль';
    }
    if (value.length < 6) {
      return 'Пароль должен быть не менее 6 символов';
    }
    return null;
  }
}
