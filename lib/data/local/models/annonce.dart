const String tableAnnonces = 'annonces';
class AnnonceFields {
  static final List<String> values = [
    /// Add all fields
    id, etat, localisation, temps, details, nombre, description, imageUrl
  ];
  static const String id = 'id';
  static const String etat = 'etat';
  static const String localisation = 'localisation';
  static const String temps = 'temps';
  static const String details = 'details';
  static const String nombre = 'nombre';
  static const String description = 'description';
  static const String imageUrl = 'imageUrl';
  static const String isSync = 'issync';
  static const String isUpdate = 'isupdate';

}
class Annonce {
  int? id;
  Etat etat;
  String localisation;
  DateTime temps;
  String details;
  int nombre;
  String description;
  String? imageUrl;
  Annonce({
    this.id,
    required this.etat,
    required this.localisation,
    required this.temps,
    required this.details,
    this.imageUrl,
    required this.nombre,
    required this.description,
  });
  Annonce copy({
   int? id,
   Etat? etat,
   String? localisation,
   DateTime? temps,
   String? details,
   int? nombre,
   String? description,
   String? imageUrl, 
  }) =>
      Annonce(
        id: id ?? this.id,
        etat: etat ?? this.etat,
        localisation: localisation ?? this.localisation,
        temps: temps ?? this.temps,
        details: details ?? this.details,
        imageUrl: imageUrl ?? this.imageUrl,
        nombre: nombre ?? this.nombre,
        description: description ?? this.description,



      );

  Map<String, dynamic> toJson() {
    return {
      'etat': 'perdu',
      'localisation': localisation,
      'temps': temps.millisecondsSinceEpoch,
      'details': details,
      'nombre': "nombre",
      'description': description,
      'imageUrl': imageUrl,
    };
  }
  static Annonce fromJson(Map<String, Object?> json) => Annonce(
        id: json[AnnonceFields.id] as int?,
        etat: json[AnnonceFields.etat] as Etat,
        localisation: json[AnnonceFields.localisation] as String,
        temps: json[AnnonceFields.temps] as DateTime,
        details: json[AnnonceFields.details] as String,
        nombre: json[AnnonceFields.details] as int,
        description: json[AnnonceFields.description] as String,
        imageUrl: json[AnnonceFields.details] as String,
      );
  Map<String, Object?> toJsons() => {
    AnnonceFields.id: id,
    AnnonceFields.etat: etat,
    AnnonceFields.localisation: localisation,
    AnnonceFields.temps: temps.toIso8601String(),
    AnnonceFields.details: details,
    AnnonceFields.nombre: nombre,
    AnnonceFields.description: description,
    AnnonceFields.imageUrl: imageUrl,


      };


  factory Annonce.fromMap(Map<String, dynamic> map) {
    return Annonce(
       etat:map['etat'],
      localisation: map['localisation'] ?? '',
     temps: DateTime.fromMillisecondsSinceEpoch(map['temps']),
       details: map['details'] ?? '',
       nombre: map['nombre']?.toInt() ?? 0,
       description: map['description'] ?? '',
       imageUrl: map['imageUrl'],
     );
  }

  // String toJson() => json.encode(toMap());

  //factory Annonce.fromJson(String source) => Annonce.fromMap(json.decode(source));
}

enum Etat { Trouve, Perdu }
