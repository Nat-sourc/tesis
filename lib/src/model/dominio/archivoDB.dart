class ArchivoDB{
  ArchivoDB({
    this.id,
    this.idPaciente,
    this.idDoctor,
    this.path,
    this.fecha,
    this.estado
  });

  int? id;
  String? idPaciente;
  int? idDoctor;
  String? path;
  String? fecha;
  int? estado; //1: Enviado 0: No enviado


  Map<String, dynamic> toJson() => {
      "id": id,
      "idPaciente": idPaciente,
      "idDoctor": idDoctor,
      "path": path,
      "fecha": fecha,
      "estado": estado,
  };
}