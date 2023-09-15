
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_create_account/update_parking.dart';


class RegisterScreen extends StatefulWidget {
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
    var scaffold = Scaffold(
      body: Container(
        color: Colors.blue,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height, // Tamaño de la pantalla
            child: Stack(
              children: [
                Positioned(
                  top: 100,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: 5,
                    margin: const EdgeInsets.all(20.0),
                    child: Container(
                      width: 351,
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Regístrese para comenzar',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'Urbanist',
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          TextField(
                            controller: nombreController,
                            decoration: InputDecoration(
                              labelText: 'Nombre:',
                              hintText: 'Nombre',
                              filled: true,
                              fillColor: const Color(0xFFE8ECF4),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            controller: apellidosController,
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
                          // ... otros campos de TextField
                          const SizedBox(height: 15),
                          TextField(
                            controller: telefonoController,
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
                                  borderRadius: BorderRadius.circular(15.0)),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            controller: correoElectronicoController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Correo Electrónico',
                              hintText: 'correo@example.com',
                              filled: true,
                              fillColor: const Color(0xFFE8ECF4),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            controller: contrasenaController,
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: 'Ingresa una Contraseña',
                                hintText: 'Contraseña',
                                filled: true,
                                fillColor: const Color(0xFFE8ECF4),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0))),
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            controller: contrasenaConfirmarController,
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: 'Confirmar Contraseña',
                                hintText: 'Confirmar Contraseña',
                                filled: true,
                                fillColor: const Color(0xFFE8ECF4),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0))),
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
                          ElevatedButton(
                            onPressed: () async {
                              //Acción cuando se presiona el botón

                              //(agregar valicion)(OJO)

                              // Crea una instancia de UserData con los datos
                              UserData userData = UserData(
                                nombre: nombreController.text,
                                apellidos: apellidosController.text,
                                telefono: int.parse(telefonoController.text),
                                correoElectronico:
                                correoElectronicoController.text,
                                contrasena: contrasenaController.text,
                                genero: 'Masculino'
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const UpdateParking()
                                      // TypeUser(userData: userData),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    30.0), // Ajusta el radio para hacerlo semi redondeado
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
                          const SizedBox(height: 150)
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    iconSize: 40,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    return scaffold;
  }
}

class UserData {
  final String nombre;
  final String apellidos;
  final int telefono;
  final String correoElectronico;
  final String contrasena;
  final String genero;
  UserData({
    required this.nombre,
    required this.apellidos,
    required this.telefono,
    required this.correoElectronico,
    required this.contrasena,
    required this.genero
  });
}
