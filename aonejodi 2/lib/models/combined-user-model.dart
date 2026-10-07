class CombinedUser {
  String email;
  String fullName;
  String gender;
  String day;
  String month;
  String year;
  String motherTongue;
  String religion;
  String caste;
  String country;
  String state;
  String city;
  String profileCreatedBy;
  String phoneNumber;
  String phoneIs;
  String image;
  String language;
  String? birthTime;
  String physicalStatus;
  String medical;
  String father;
  String fathersOccupation;
  String mother;
  String mothersOccupation;
  String brothers;
  String sisters;
  String height;
  String education;
  String employed;
  String complexion;
  String profession;
  String music;
  String sports;
  String movies;
  String maritalStatus;
  String outfit;
  String about;
  String annualIncome;
  String smoking;
  String status;
  String drinking;
  String eating;
  String age;
  String manglik;
  String familyType;
  String familyStatus;
  String ageBetween;
  String image2;
  String image3;
  String bodyType;
  String uid;
  String password;
  String birthPlace;
  String? isverified;

  CombinedUser({
    required this.email,
    required this.fullName,
    required this.gender,
    required this.day,
    required this.month,
    required this.year,
    required this.motherTongue,
    required this.religion,
    required this.caste,
    required this.country,
    required this.state,
    required this.city,
    required this.profileCreatedBy,
    required this.phoneNumber,
    required this.phoneIs,
    required this.image,
    required this.language,
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
    required this.familyStatus,
    required this.ageBetween,
    required this.image2,
    required this.image3,
    required this.bodyType,
    required this.uid,
    required this.password,
    required this.birthPlace,
    this.isverified,
  });

  factory CombinedUser.fromJson(Map<String, dynamic> json) {
    return CombinedUser(
      email: json['email'] ?? '',
      fullName: json['f_name'] ?? '',
      gender: json['gender'] ?? '',
      day: json['day'] ?? '',
      month: json['month'] ?? '',
      year: json['year'] ?? '',
      motherTongue: json['mothertongue'] ?? '',
      religion: json['religion'] ?? '',
      caste: json['caste'] ?? '',
      country: json['country'] ?? '',
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      profileCreatedBy: json['profilecreator'] ?? '',
      phoneNumber: json['mobile'] ?? '',
      phoneIs: json['phoneis'] ?? '',
      image: json['image'] ?? '',
      language: json['language'] ?? '',
      birthTime: json['birth_time'] ?? '',
      physicalStatus: json['physical_status'] ?? '',
      medical: json['medical'] ?? '',
      father: json['father'] ?? '',
      fathersOccupation: json['f_occupation'] ?? '',
      mother: json['mother'] ?? '',
      mothersOccupation: json['m_occupation'] ?? '',
      brothers: json['brothers'] ?? '',
      sisters: json['sisters'] ?? '',
      height: json['height'] ?? '',
      education: json['education'] ?? '',
      employed: json['employed'] ?? '',
      complexion: json['complexion'] ?? '',
      profession: json['profession'] ?? '',
      music: json['music'] ?? '',
      sports: json['sports'] ?? '',
      movies: json['movies'] ?? '',
      maritalStatus: json['marital_status'] ?? '',
      outfit: json['outfit'] ?? '',
      about: json['about'] ?? '',
      annualIncome: json['annual_income'] ?? '',
      smoking: json['smoking'] ?? '',
      status: json['status'] ?? '',
      drinking: json['drinking'] ?? '',
      eating: json['eating'] ?? '',
      age: json['age'] ?? '',
      manglik: json['manglik'] ?? '',
      familyType: json['family_type'] ?? '',
      familyStatus: json['family_status'] ?? '',
      ageBetween: json['age_between'] ?? '',
      image2: json['image2'] ?? '',
      image3: json['image3'] ?? '',
      bodyType: json['body_type'] ?? '',
      uid: json['uid'] ?? '',
      password: json["password"] ?? "",
      birthPlace: json["place_of_birth"] ?? '',
      isverified: json["isverified"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'f_name': fullName,
      'gender': gender,
      'day': day,
      'month': month,
      'year': year,
      'mothertongue': motherTongue,
      'religion': religion,
      'caste': caste,
      'country': country,
      'state': state,
      'city': city,
      'profilecreator': profileCreatedBy,
      'mobile': phoneNumber,
      'phoneis': phoneIs,
      'image': image,
      'language': language,
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
      'family_status': familyStatus,
      'age_between': ageBetween,
      'image2': image2,
      'image3': image3,
      'body_type': bodyType,
      'uid': uid,
      'password': password,
      'place_of_birth': birthPlace,
      'isverified': isverified,
    };
  }
}
