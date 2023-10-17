import 'package:bluehpark/models/user.dart';
import 'package:bluehpark/pages/client/type_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/Register-screen';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {

  int selectedGender = 0; // 0 para Hombre, 1 para Mujer
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidosController = TextEditingController();
  final TextEditingController correoElectronicoController =
      TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();
  final TextEditingController contrasenaConfirmarController =
      TextEditingController();
  final TextEditingController telefonoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.all(20),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  size: 40,
                ),
              ),
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(
                  'assets/logo_login.jpg',
                  width: 215,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(15),
              alignment: Alignment.center,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 50,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Regístrese para comenzar',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Urbanist',
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: nombreController,
                        style: const TextStyle(
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          labelText: 'Nombre',
                          hintText: 'Nombre',
                          filled: true,
                          fillColor: const Color(0xFFE8ECF4),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: apellidosController,
                        style: const TextStyle(
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'Apellidos',
                          labelText: 'Apellidos',
                          filled: true,
                          fillColor: const Color(0xFFE8ECF4),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: telefonoController,
                        style: const TextStyle(
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.phone,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10)
                        ],
                        decoration: InputDecoration(
                          hintText: 'Telefono',
                          labelText: 'Telefono',
                          filled: true,
                          fillColor: const Color(0xFFE8ECF4),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: correoElectronicoController,
                        style: const TextStyle(
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Correo Electrónico',
                          hintText: 'correo@example.com',
                          filled: true,
                          fillColor: const Color(0xFFE8ECF4),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: contrasenaController,
                        style: const TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.bold,
                        ),
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Ingresa una Contraseña',
                          hintText: 'Contraseña',
                          filled: true,
                          fillColor: const Color(0xFFE8ECF4),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: contrasenaConfirmarController,
                        style: const TextStyle(
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.bold),
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirmar Contraseña',
                          hintText: 'Confirmar Contraseña',
                          filled: true,
                          fillColor: const Color(0xFFE8ECF4),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Género',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      // Usamos un Row para colocar los RadioButtons en fila
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: const Text('Hombre'),
                              leading: Radio<int>(
                                value: 0,
                                groupValue: selectedGender,
                                onChanged: (int? value) {
                                  setState(() {
                                    selectedGender = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: const Text('Mujer'),
                              leading: Radio<int>(
                                value: 1,
                                groupValue: selectedGender,
                                onChanged: (int? value) {
                                  setState(() {
                                    selectedGender = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () async => sendUserData(),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                50.0), // Ajusta el radio para hacerlo semi redondeado
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 16), // Ajusta el tamaño del botón
                          backgroundColor:
                              Colors.blue, // Color de fondo del botón
                        ),
                        child: const Text(
                          'Registrarse', // Texto del botón
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Color del texto
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void sendUserData() async {
    UserData userData = UserData(
        nombre: nombreController.text,
        apellidos: apellidosController.text,
        telefono: int.parse(telefonoController.text),
        correoElectronico: correoElectronicoController.text,
        contrasena: contrasenaController.text,
        genero: selectedGender == 0 ? 'Masculino' : 'Femenino');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TypeUser(userData: userData),
      ),
    );
  }
}
