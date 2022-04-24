class Model {
  final String nombres_empleado;
  final String apellidos_empleado;

  Model._({required this.nombres_empleado, required this.apellidos_empleado});

  factory Model.fromJson(Map<String, dynamic> json) {
    return new Model._(
      nombres_empleado: json['nombres_empleado'],
      apellidos_empleado: json['apellidos_empleado'],
    );
  }
}