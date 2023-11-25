# PR-PARQUEO-2023-B
    Manual Técnico 

Introducción: 

Una cordial bienvenida al Manual Técnico de BLUH-PARK. Este manual proporciona una guía detallada para desarrolladores que trabajen con el sistema para futuras actualizaciones de la aplicación. El presente manual abarca la información necesaria para instalar BLUH-PARK desde el entorno de desarrollo de Flutter desde Visual Studio Code 

 

Descripción del proyecto: 

La aplicación de BLUH.PARK brinda un servicio de gestión eficiente de establecimientos de parqueos, y búsqueda de parqueos para la realización de reservas, brindando todos los datos requeridos del cliente que realiza la reserva. 

  

Los datos que son requeridos para los usuarios que utilizan el sistema, tanto dueños de parqueos como clientes que buscan parqueos, son almacenados en una base de datos en tiempo real de FireStore, así también como los datos de un parqueo, que este es registrado por un dueño que puede tener varios parqueos. 

 

Roles / integrantes 

Team leader / Ricardo Fernández Castillo 

SQA – Developer / Andrew Fernando Gallardo Callao 

Git Master / Luis David Ancienta Sejas 

Developer – DB Architect / Alvaro Francisco Echeverria Garcia 

 

Arquitectura del software: Explicación de la estructura y organización del software, incluyendo los componentes principales, las interacciones entre ellos. 

Interfaz de Usuario (UI): 

Utiliza Flutter para desarrollar la interfaz de usuario. Organiza la interfaz de manera intuitiva y atractiva para los usuarios, facilitando la navegación por la aplicación. 

Firebase Auth (Autenticación): 

Integra Firebase Auth para gestionar la autenticación de usuarios. Permite a los usuarios registrarse e iniciar sesión mediante Google u otros métodos de autenticación admitidos por Firebase. 

Firestore (Base de Datos): 

Utiliza Firestore como base de datos para almacenar y recuperar información relacionada con los parqueos. Estructura la base de datos de manera eficiente para optimizar las consultas y la recuperación de datos. 

Firebase Storage (Almacenamiento de Imágenes): 

Almacena imágenes de los parqueos en Firebase Storage. Asocia las imágenes con los registros correspondientes en Firestore para un acceso fácil y rápido. 

MapBox (Integración de Mapas): 

Integra MapBox para desplegar un mapa interactivo que muestra la ubicación de los parqueos. Utiliza la API de MapBox para personalizar la apariencia del mapa y proporcionar funcionalidades de navegación. 

Servidor SMTP para Envío de Correos: 

Implementa un servidor SMTP para enviar correos a los usuarios cuando sea necesario. Por ejemplo, puedes utilizar esta funcionalidad para confirmar registros, restablecer contraseñas o enviar notificaciones importantes. 

Seguridad y Protección de Datos: 

Asegúrate de seguir las mejores prácticas de seguridad al interactuar con Firebase y otros servicios. Protege la información sensible de los usuarios y aplica medidas de seguridad recomendadas. 

Optimización de Rendimiento: 

Optimiza el rendimiento de la aplicación, especialmente al interactuar con servicios en la nube como Firebase. Minimiza las consultas innecesarias y utiliza técnicas de almacenamiento en caché cuando sea posible. 

Pruebas Unitarias y de Integración: 

Pruebas unitarias y de integración para garantizar la estabilidad y fiabilidad de la aplicación. Al utilizar servicios externos como Firebase. 

 

Requisitos del sistema: 

Requerimientos de Hardware (mínimo): (cliente): Espacio mínimo: 60 mb  

Requerimientos de Software: (cliente): Android o iOS - Conexión a internet 

Requerimientos de Hardware (server/ hosting/BD):  

Servidor almacenado en la Nube 

Requerimientos de Software (server/ hosting/BD): FireStore - Conexión a internet  

Framework Flutter: 

Utiliza la última versión estable del framework Flutter para el desarrollo de la aplicación. 

Firebase SDK para Flutter: 

Integra el SDK de Firebase para Flutter en tu aplicación. Esto incluye bibliotecas específicas para Firestore, Firebase Storage, Firebase Auth y otros servicios. 

Gestor de Dependencias: 

Usa un gestor de dependencias como pub (el administrador de paquetes de Dart y Flutter). 

Entorno de Desarrollo: 

Configura un entorno de desarrollo que sea compatible con Flutter y Dart. Puedes utilizar editores de código como Visual Studio Code o Android Studio. 

Git y Control de Versiones: 

Implementa un sistema de control de versiones (como Git) para realizar un seguimiento de los cambios en el código fuente y colaborar de manera efectiva si trabajas en un equipo. 

 

 

Instalación y configuración: Instrucciones detalladas sobre cómo instalar el software, configurar los componentes necesarios y establecer la conexión con otros sistemas o bases de datos 


Instalar Flutter: 

Descarga el SDK de Flutter desde el sitio oficial de Flutter: https://flutter.dev/docs/get-started/install. 

Extrae el archivo zip descargado en un directorio de tu elección. 

Agrega la ubicación del directorio flutter/bin a tu variable de entorno PATH. Esto facilitará el acceso a los comandos de Flutter desde cualquier ubicación en tu sistema. 

 

Verificar la Instalación de Flutter: 

Abre una terminal y ejecuta el comando flutter doctor para verificar que Flutter esté instalado correctamente y para solucionar cualquier dependencia faltante. 

 

Instalar Visual Studio Code: 

Descarga e instala Visual Studio Code desde https://code.visualstudio.com/. 

Instalar la Extensión Flutter: 

Abre VSCode. 

Ve al menú de extensiones (icono de cuadro de rompecabezas en la barra lateral izquierda) o usa el atajo Ctrl + Shift + X. 

Busca "Flutter" en la barra de búsqueda. 

Instala la extensión "Flutter" desarrollada por Dart Code. 


Instalar la Extensión Dart: 

Aunque la extensión Flutter incluye el soporte de Dart, también puedes instalar la extensión "Dart" desarrollada por Dart Code para obtener más características específicas de Dart. 


Reiniciar Visual Studio Code: 

Cierra y vuelve a abrir VSCode para que las extensiones y configuraciones surtan efecto. 

 

Instalar Firebase  

Para los siguientes pasos debe tener instalado Node.js (instalar de forma recomendada). 


En la consola CMD ejecutar los comandos:  

npm install -g firebase-tools
firebase --version              | (Verifica la instalacion) 
 

firebase login             | (redirecciona al navegador)

(Cuenta de Google que este en el proyecto de firebase) 

Correo: bluhpark2023@gmail.com 
Contraseña: bluhparkparqueo2023 

 

Clonar Repositorio 

  Para los siguientes pasos debe tener instalado Git. (instalar de forma recomendada). 

  Ejecutar el comando: git clone “url o ssh del proyecto” (para esto debe ser miembro colaborador del repositorio de github). 


Resolver Dependencias 

  Abrir en Visual Code la carpeta “bluh_park” 

  Abrir la terminal de visual code y ejecutar el comando: 

  flutter pub get 

Agregar Huella Digital del APK 

  Con la Cuenta otorgada, dirigirse a la pestaña principal del proyecto (en el navegador): 
  seleccione el apk "bluhpark" ara agregar la huella digital del apk generado


Debe ejecutar el siguiente comando en la terminal de visual studio  
 primero ubicarse en la carpeta Android (dentro del proyecto)
y ejecutar: ./gradlew signingReport



PROCEDIMIENTO DE HOSTEADO / HOSTING (configuración) 

Otros (firebase, etc.) 

La cuenta para el acceso al proyecto en Firebase: 

Correo: bluhpark2023@gmail.com 

Contraseña: bluhparkparqueo2023 


GIT:  

Versión final entregada del proyecto. 

Entrega compilados ejecutables 

 

Personalización y configuración: Información sobre cómo personalizar y configurar el software según las necesidades del usuario, incluyendo opciones de configuración, parámetros y variables. 

Uno de los usuarios administradores que permite la aprobación de cuentas de dueño es: bluhpark2023@gmail.com 


Seguridad: Consideraciones de seguridad y recomendaciones para proteger el software y los datos, incluyendo permisos de acceso, autenticación y prácticas de seguridad recomendadas. 

Los datos registrados en BLUH-PARK, para su correcto funcionamiento, son almacenados en una base de datos de FireStore almacenada en la nube. En cuanto al registro e ingreso login, la aplicación de BLUH-PARK verifica la autenticación del usuario mediante su correo electrónico de Google (@gmail.com). Esto con el fin de mantener la seguridad de los datos. 

 

		 

 

 

Depuración y solución de problemas: Instrucciones sobre cómo identificar y solucionar problemas comunes, mensajes de error y posibles conflictos con otros sistemas o componentes. 
 

Al generar la huella digital:  

 

Solucion:  

- Tener instalado Java 11 minimo (verificar el la ruta C:/files/Java) 

- Verificar la variable de sistema JAVA_HOME este la version de java nescesaria. 

- Cerrar la terminal y Visual Code, volver a abrir y ejecutar el comando en una nueva terminal. 

Problemas con el cargado de paquetes: 

	Ejecutar el comando: flutter pub get 

Problemas al clonar el repositorio: 

	Para clonar el repositorio debe ser miebro del proyecto en github, y con esa 	misma cuenta y usuario configurar el git local. 

    Otra solución es clonar mediante el enlace SSH, para ello debe generar una llave ssh del equipo al cual va a clonar y posterior mente agregar ese codigo llave a su cuenta de github.	 

Problemas al ejecutar los comandos flutter: 

	Asegurese de que la carpeta flutter/bin esta agregada a las variables del sistema 	correctamente. Reinicie la terminal. 

 

 

Glosario de términos: Un glosario que incluya definiciones de términos técnicos y conceptos utilizados en el manual. 

 

 

Referencias y recursos adicionales: Enlaces o referencias a otros recursos útiles, como documentación técnica relacionada, tutoriales o foros de soporte. 

 

-----FLUTER & FIREBASE---------- 

https://firebase.flutter.dev/docs/overview/ 

https://firebase.flutter.dev/docs/auth/manage-users/ 

https://youtube.com/watch?v=ZgiW_IUeFII 

 

 
--------------------------------- Herramientas de Implementación -----------------------------------------
Herramientas de Implementación: 

Lenguajes de programación: 

Dart 

Frameworks: 

Fluter 		 

APIs de terceros, etc: 

MapBox (Visualización y personalización del mapa). 

FirebaseAuth (Autentificacion por google) 

 

 

--------------------------------- Bibliografía ---------------------------
 

https://firebase.flutter.dev/docs/overview/ 

https://firebase.flutter.dev/docs/auth/manage-users/ 

 
