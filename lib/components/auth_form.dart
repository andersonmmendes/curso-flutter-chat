import 'package:curso_flutter_chat/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _submit() {
    _formKey.currentState?.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_formData.isSignup)
                TextFormField(
                  key: const ValueKey('name'),
                  initialValue: _formData.name,
                  onChanged: (value) => _formData.name = value,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                  validator: (value) {
                    final name = value ?? '';

                    if (name.trim().length < 5) {
                      return 'Nome deve ter no mínimo 5 caracteres.';
                    }

                    return null;
                  },
                ),
              TextFormField(
                key: const ValueKey('email'),
                initialValue: _formData.email,
                onChanged: (value) => _formData.email = value,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                ),
                validator: (value) {
                  final email = value ?? '';

                  if (!email.contains('@')) {
                    return 'E-mail informado não é valido.';
                  }

                  return null;
                },
              ),
              TextFormField(
                key: const ValueKey('password'),
                initialValue: _formData.password,
                onChanged: (value) => _formData.password = value,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
                validator: (value) {
                  final password = value ?? '';

                  if (password.length < 6) {
                    return 'Senha deve ter no mínimo 6 caracteres.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _submit,
                child: Text(_formData.isLogin ? 'Entrar' : 'Cadastrar'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _formData.toggleAuthMode();
                  });
                },
                child: Text(
                  _formData.isLogin
                      ? 'Criar uma nova conta?'
                      : 'Já possui conta?',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
