import 'package:flutter/material.dart';
import 'package:guia_restaurantes/viewmodels/sign_up_viewmodel.dart';
import 'package:guia_restaurantes/views/pages/profile_page.dart';

class SingUpPage extends StatefulWidget {
  static const _ifoodRed = Color(0XFFEA1D2C);

  //Metodo construtor:
  const SingUpPage({super.key});

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final _viewModel = SignUpViewmodel();

  bool _obscurePassword = true;
  bool _acceptedTerms = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Criar conta'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                const SizedBox(height: 24),

                _buildField(
                  label: 'Nome completo',
                  icon: Icons.person_outlined,
                  controller: _nameController,
                  validator: _viewModel.validateName,
                ),
                const SizedBox(height: 16),

                _buildField(
                  label: 'Email',
                  icon: Icons.mail_outlined,
                  controller: _emailController,
                  validator: _viewModel.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),

                _buildField(
                  label: 'Celular',
                  icon: Icons.phone_outlined,
                  controller: _phoneController,
                  validator: _viewModel.validatePhone,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),

                _buildField(
                  label: 'Senha',
                  icon: Icons.lock_outlined,
                  controller: _passwordController,
                  validator: _viewModel.validatePassword,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                _buildField(
                  label: 'Confirmar senha',
                  icon: Icons.lock_outlined,
                  controller: _confirmPasswordController,
                  validator: (value) => _viewModel.validatePasswordConfirmation(
                    value,
                    _passwordController.text,
                  ),
                  obscureText: _obscurePassword,
                ),
                const SizedBox(height: 8),

                _buildTermsCheckbox(),

                const SizedBox(height: 16),

                _buildSubmitButton(),

                const SizedBox(height: 8),

                _buildLoginLink(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Falta pouco para matar a sua fome!',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        Text(
          'Preencha os seus dados para criar a sua conta.',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildField({
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    TextEditingController? controller,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: SingUpPage._ifoodRed, width: 2),
        ),
        floatingLabelStyle: const TextStyle(color: SingUpPage._ifoodRed),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        final isValid = _formKey.currentState!.validate();
        print('Formulário válido? $isValid');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: SingUpPage._ifoodRed,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text(
        'Criar conta',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return CheckboxListTile(
      value: _acceptedTerms,
      onChanged: (value) {
        setState(() {
          _acceptedTerms = value ?? false;
          //_acceptedTerms = !_acceptedTerms;
        });
      },
      activeColor: SingUpPage._ifoodRed,
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      title: const Text(
        'Li e aceito os termos de uso e a política de privacidade',
      ),
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      style: TextButton.styleFrom(foregroundColor: SingUpPage._ifoodRed),
      child: const Text('Já tenho uma conta'),
    );
  }

  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }
}
