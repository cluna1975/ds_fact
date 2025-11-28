import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ds_fact/core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import '../providers/login_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _obscurePassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor ingrese correo y contraseña')),
      );
      return;
    }

    // For now, we simulate login success and go to Home
    // ref.read(loginProvider.notifier).login(email, password);
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    // ref.listen(loginProvider, (previous, next) { ... }); 
    
    final loginState = ref.watch(loginProvider);
    final isLoading = loginState is AsyncLoading;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                const SizedBox(height: 40),
                // Logo Icon
                _buildLogoIcon(),
                const SizedBox(height: 20),
                // Welcome Text
                const Text(
                  'Bienvenido de nuevo',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Inicia sesión para continuar',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 40),
                // Email and Password fields
                _buildCustomTextField(
                  label: 'Correo Electrónico',
                  hint: '@ejemplo.com',
                  icon: Icons.email_outlined,
                  controller: _emailController,
                ),
                const SizedBox(height: 20),
                _buildCustomTextField(
                  label: 'Contraseña',
                  hint: '••••••••',
                  icon: Icons.lock_outline,
                  isPassword: true,
                  controller: _passwordController,
                ),
                const SizedBox(height: 10),
                // Remember me
                _buildRememberMe(),
                const SizedBox(height: 20),
                // Login Button
                _buildLoginButton(isLoading),
                const SizedBox(height: 20),
                // Forgot Password / Sign up
                _buildForgotPasswordSignUp(),
                const SizedBox(height: 30),
                // Social Login Buttons
                _buildSocialButton(
                  text: 'Iniciar sesión con Google',
                  icon: Icons.g_translate, // Placeholder
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                _buildSocialButton(
                  text: 'Iniciar sesión con Facebook',
                  icon: Icons.facebook,
                  color: Colors.blue.shade800,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    )));
  }

  Widget _buildLogoIcon() {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: AppTheme.primaryPurple,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Icon(
        Icons.lock_person_rounded,
        color: Colors.white,
        size: 50,
      ),
    );
  }

  Widget _buildCustomTextField({
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    required TextEditingController controller,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[400]),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: isPassword ? _obscurePassword : false,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: label,
                labelStyle: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
          if (isPassword)
            IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey[400],
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
        ],
      ),
    );
  }

  Widget _buildRememberMe() {
    return Row(
      children: [
        Checkbox(
          value: true,
          onChanged: (val) {},
          activeColor: AppTheme.primaryPurple,
        ),
        const Text('Recordarme?', style: TextStyle(color: Colors.black54)),
      ],
    );
  }

  Widget _buildLoginButton(bool isLoading) {
    return ElevatedButton(
      onPressed: isLoading ? null : _onLoginPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 24), // For spacing
          if (isLoading)
            const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          else
            const Text('INICIAR SESIÓN', style: TextStyle(fontSize: 16)),
          const Icon(Icons.more_horiz, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildForgotPasswordSignUp() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        style: TextStyle(color: Colors.black54, fontSize: 14),
        children: [
          TextSpan(text: '¿Olvidaste cuenta? '),
          TextSpan(
            text: 'Regístrate aquí',
            style: TextStyle(
              color: AppTheme.primaryPurple,
              fontWeight: FontWeight.bold,
            ),
            // recognizer: TapGestureRecognizer()..onTap = () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required String text,
    required IconData icon,
    required Color color,
  }) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        side: BorderSide(color: Colors.grey.shade300),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}