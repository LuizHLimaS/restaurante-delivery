class SignUpViewmodel {
  //
  String? validateName(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return 'Informe o seu nome';
    if (name.length < 3) return 'O nome deve ter pelo menos 3 letras';
    return null;
  }

  String? validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Informe o seu email';

    final emailRegex = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.]+$');
    if (!emailRegex.hasMatch(email)) return 'E-mail inválido';
    return null;
  }

  String? validatePhone(String? value) {
    final digits = (value ?? '').replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return 'Informe o seu número de celular';
    if (digits.length != 11)
      return 'Informe o DDD e os 9 dígitos do número de celular';
    return null;
  }

  String? validatePassword(String? value) {
    final password = value ?? '';
    if (password.isEmpty) return 'Crie uma senha';
    if (password.length < 6) return 'A senha deve ter pelo menos 6 caracteres';
    return null;
  }

  String? validatePasswordConfirmation(String? value, String password) {
    if (value == null || value.isEmpty) return 'Confirme a sua senha';
    if (value != password) return 'As senhas não conferem';
    return null;
  }
}
