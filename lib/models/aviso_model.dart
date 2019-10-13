// To parse this JSON data, do
//
//     final avisoModel = avisoModelFromJson(jsonString);

import 'dart:convert';

AvisoModel avisoModelFromJson(String str) => AvisoModel.fromJson(json.decode(str));

String avisoModelToJson(AvisoModel data) => json.encode(data.toJson());

class AvisoModel {
    int idAviso;
    String img;
    String usrId;
    String titulo;
    String descripcion;
    DateTime fechaFin;
    DateTime fechaAlta;
    int prioridad;

    AvisoModel({
        this.idAviso,
        this.img,
        this.usrId,
        this.titulo,
        this.descripcion,
        this.fechaFin,
        this.fechaAlta,
        this.prioridad,
    });

    factory AvisoModel.fromJson(Map<String, dynamic> json) => AvisoModel(
        idAviso: json['idAviso'],
        img: json["img"],
        usrId: json["usrId"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        fechaFin: DateTime.parse(json["fechaFin"]),
        fechaAlta: DateTime.parse(json["fechaAlta"]),
        prioridad: json["prioridad"],
    );

    Map<String, dynamic> toJson() => {
        "idAviso":idAviso,
        "img": img,
        "usrId": usrId,
        "titulo": titulo,
        "descripcion": descripcion,
        "fechaFin": "${fechaFin.year.toString().padLeft(4, '0')}-${fechaFin.month.toString().padLeft(2, '0')}-${fechaFin.day.toString().padLeft(2, '0')}",
        "fechaAlta": "${fechaAlta.year.toString().padLeft(4, '0')}-${fechaAlta.month.toString().padLeft(2, '0')}-${fechaAlta.day.toString().padLeft(2, '0')}",
        "prioridad": prioridad,
    };
}
