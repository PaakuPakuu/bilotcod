class Patient {
  String id;
  String nom;
  String prenom;
  int age;
  String sexe;

  Patient(this.id, this.nom, this.prenom, this.age, this.sexe);

  factory Patient.fromFirestore(String id, Map<String, dynamic> data) {
    return Patient(
      id,
      data['nom'] as String,
      data['prenom'] as String,
      data['age'] as int,
      data['sexe'] as String,
    );
  }
}
