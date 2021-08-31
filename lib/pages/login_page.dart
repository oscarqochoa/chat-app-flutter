import 'package:chat_app/helpers/mostrar_alerta.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/widgets/boton_azul.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Logo(titulo: "Messenger"),
                _Form(),
                Labels(
                  ruta: 'register',
                  titulo: "¿No tienes cuenta?",
                  subtitulo: "Crea una ahora!",
                ),
                Text(
                  "Términos y condiciones de uso",
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<_Form> {
  final TextEditingController emailCtrl = new TextEditingController();
  final TextEditingController passCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(
      context,
    );

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: "Correo",
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: "Contraseña",
            textController: passCtrl,
            isPassword: true,
          ),
          BotonAzul(
            text: "Ingresar",
            onPressed: authService.autenticando ? null : _login(authService),
          ),
        ],
      ),
    );
  }

  _login(authService) async {
    FocusScope.of(context).unfocus();

    final loginOk =
        await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());

    if (loginOk) {
      // todo: Navegar a otra pantalla
    } else {
      // todo: Mostrar Alerta
      mostrarAlerta(context, 'Login inccorrecto', 'Revise sus credenciales');
    }
  }
}
