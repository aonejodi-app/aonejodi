class RegisteredUser {
  final String email;
  final String password;
  final String fullName;
  final String gender;
  final String day;
  final String month;
  final String year;
  final String motherTongue;
  final String religion;
  final String caste;
  final String country;
  final String state;
  final String city;
  final String profileCreatedBy;
  final String phoneNumber;
  final String phoneIs;
  final String image;
  final String language;

  RegisteredUser({
    required this.email,
    required this.password,
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
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'fullName': fullName,
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
      };

  factory RegisteredUser.fromJson(Map<String, dynamic> json) => RegisteredUser(
        email: json['email'],
        password: json['password'],
        fullName: json['full_name'],
        gender: json['gender'],
        day: json['day'],
        month: json['month'],
        year: json['year'],
        motherTongue: json['mothertongue'],
        religion: json['religion'],
        caste: json['caste'],
        country: json['country'],
        state: json['state'],
        city: json['city'],
        profileCreatedBy: json['profilecreator'],
        phoneNumber: json['mobile'],
        phoneIs: json['phoneis'],
        image: json['image'],
        language: json['language'],
      );
}
