import 'package:meta/meta.dart';

class classUsuarios {
  List<classUsuarios> listaUser;
  String nombre;
  String apellido;
  String dia;
  String mes;
  String anno;
  String cel;
  String identificacion;
  String numCC;
  String genero;
  String correo;
  String contrasena;
  classUsuarios.aux() {}
  classUsuarios(
      String correo2,
      String nombre2,
      String apellido2,
      String dia2,
      String mes2,
      String anno2,
      String cel2,
      String identificacion2,
      String numCC2,
      String genero2,
      String contrasena2) {
    this.correo = correo2;
    this.nombre = nombre2;
    this.apellido = apellido2;
    this.dia = dia2;
    this.mes = mes2;
    this.anno = anno2;
    this.cel = cel2;
    this.identificacion = identificacion2;
    this.numCC = numCC2;
    this.genero = genero2;
    this.contrasena = contrasena2;
  }
/*
  classUsuarios(
      {@required this.correo,
      @required this.nombre,
      @required this.apellido,
      @required this.dia,
      @required this.mes,
      @required this.anno,
      @required this.cel,
      @required this.identificacion,
      @required this.numCC,
      @required this.genero,
      @required this.contrasena});*/
  void newUsuario(
    String nombre1,
    String apellido1,
    String dia1,
    String mes1,
    String anno1,
    String cel1,
    String identificacion1,
    String numCC1,
    String genero1,
    String correo1,
    String contrasena1,
  ) {
    //listaUser.add(nombre1, apellido1, dia1, mes1, anno1, cel1, identificacion1,
    //    numCC1, genero1, correo1, contrasena1);
  }
/*
  factory classUsuarios.fromMap(dynamic data) => classUsuarios(
      correo: data['correo'],
      nombre: data['nombre'],
      apellido: data['apellido'],
      dia: data['dia'],
      mes: data['mes'],
      anno: data['anno'],
      cel: data['cel'],
      identificacion: data['identificacion'],
      numCC: data['numCC'],
      genero: data['genero'],
      contrasena: data['contrasena']);*/

  List<classUsuarios> getLista() {
    return listaUser;
  }

  String getnombre() {
    return nombre;
  }

  void setnombre(String Nombre) {
    this.nombre = Nombre;
  }

  String getapellido() {
    return apellido;
  }

  void setapellido(String Apellido) {
    this.apellido = apellido;
  }

  String getdia() {
    return dia;
  }

  void setdia(String Dia) {
    this.dia = Dia;
  }

  String getmes() {
    return mes;
  }

  void setmes(String Mes) {
    this.mes = Mes;
  }

  String getanno() {
    return anno;
  }

  void setanno(String Anno) {
    this.anno = Anno;
  }

  String getcel() {
    return cel;
  }

  void setcel(String Cel) {
    this.cel = Cel;
  }

  String getidentificacion() {
    return identificacion;
  }

  void setidentificacion(String Identificacion) {
    this.identificacion = Identificacion;
  }

  String getnumCC() {
    return numCC;
  }

  void setnumCC(String NumCC) {
    this.numCC = NumCC;
  }

  String getgenero() {
    return genero;
  }

  void setgenero(String Genero) {
    this.genero = Genero;
  }

  String getcorreo() {
    return correo;
  }

  void setcorreo(String Correo) {
    this.correo = Correo;
  }

  String getcontrasena() {
    return correo;
  }

  void setcontrasena(String Contrasena) {
    this.contrasena = Contrasena;
  }

  void agregarUsuario23(
      String nombre2,
      String apellido2,
      String dia2,
      String mes2,
      String anno2,
      String cel2,
      String identificacion2,
      String numCC2,
      String genero2,
      String correo2,
      String contrasena2) {
    this.nombre = nombre2;
    /*classUsuarios obj = new classUsuarios(
        correo: correo,
        nombre: nombre,
        apellido: apellido,
        dia: dia,
        mes: mes,
        anno: anno,
        cel: cel,
        identificacion: identificacion,
        numCC: numCC,
        genero: genero,
        contrasena: contrasena);
    listaUser.add(obj);

  */
  }
}
