class UserDetail {
  final String birthTime;
  final String physicalStatus;
  final String medical;
  final String father;
  final String fathersOccupation;
  final String mother;
  final String mothersOccupation;
  final String brothers;
  final String sisters;
  final String height;
  final String education;
  final String employed;
  final String complexion;
  final String profession;
  final String music;
  final String sports;
  final String movies;
  final String maritalStatus;
  final String outfit;
  final String about;
  final String annualIncome;
  final String smoking;
  final String status;
  final String drinking;
  final String eating;
  final String age;
  final String manglik;
  final String familyType;
  final String bodyType;

  UserDetail({
    required this.birthTime,
    required this.physicalStatus,
    required this.medical,
    required this.father,
    required this.fathersOccupation,
    required this.mother,
    required this.mothersOccupation,
    required this.brothers,
    required this.sisters,
    required this.height,
    required this.education,
    required this.employed,
    required this.complexion,
    required this.profession,
    required this.music,
    required this.sports,
    required this.movies,
    required this.maritalStatus,
    required this.outfit,
    required this.about,
    required this.annualIncome,
    required this.smoking,
    required this.status,
    required this.drinking,
    required this.eating,
    required this.age,
    required this.manglik,
    required this.familyType,
    required this.bodyType,
  });

  Map<String, dynamic> toJson() => {
        'birth_time': birthTime,
        'physical_status': physicalStatus,
        'medical': medical,
        'father': father,
        'f_occupation': fathersOccupation,
        'mother': mother,
        'm_occupation': mothersOccupation,
        'brothers': brothers,
        'sisters': sisters,
        'height': height,
        'education': education,
        'employed': employed,
        'complexion': complexion,
        'profession': profession,
        'music': music,
        'sports': sports,
        'movies': movies,
        'marital_status': maritalStatus,
        'outfit': outfit,
        'about': about,
        'annual_income': annualIncome,
        'smoking': smoking,
        'status': status,
        'drinking': drinking,
        'eating': eating,
        'age': age,
        'manglik': manglik,
        'family_type': familyType,
        'body_type': bodyType,
      };

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        birthTime: json['birth_time'],
        physicalStatus: json['physical_status'],
        medical: json['medical'],
        father: json['father'],
        fathersOccupation: json['f_occupation'],
        mother: json['mother'],
        mothersOccupation: json['m_occupation'],
        brothers: json['brothers'],
        sisters: json['sisters'],
        height: json['height'],
        education: json['education'],
        employed: json['employed'],
        complexion: json['complexion'],
        profession: json['profession'],
        music: json['music'],
        sports: json['sports'],
        movies: json['movies'],
        maritalStatus: json['marital_status'],
        outfit: json['outfit'],
        about: json['about'],
        annualIncome: json['annual_income'],
        smoking: json['smoking'],
        status: json['status'],
        drinking: json['drinking'],
        eating: json['eating'],
        age: json['age'],
        manglik: json['manglik'],
        familyType: json['family_type'],
        bodyType: json['body_type'],
      );
}
