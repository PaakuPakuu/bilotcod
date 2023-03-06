class Patient {
  String? id;
  String nom;
  String prenom;
  int age;
  String sexe;

  get civilite => sexe == 'M' ? 'M.' : 'Mme';

  Patient(this.nom, this.prenom, this.age, this.sexe, {this.id});

  factory Patient.fromFirestore(String id, Map<String, dynamic> data) {
    return Patient(
      id: id,
      data['nom'] as String,
      data['prenom'] as String,
      data['age'] as int,
      data['sexe'] as String,
    );
  }
}
