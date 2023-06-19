class UserModel {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String regNo;
  final String email;
  final String photoUrl;
  final String idPhotoUrl;
  final bool verified;

  UserModel({
    required this.verified,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.regNo,
    required this.email,
    required this.photoUrl,
    required this.idPhotoUrl,
  });
}
