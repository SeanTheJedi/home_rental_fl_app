enum UserRole {
  tenant,
  landlord,
}

class User {
  final String id;
  final String fullname;
  final String email;
  final String? phoneNumber;
  final String? avatarUrl;
  final UserRole role;
  final List<String>? ownedPropertyIds; // only for landlords

  User({
    required this.id,
    required this.fullname,
    required this.email,
    this.phoneNumber,
    this.avatarUrl,
    required this.role,
    this.ownedPropertyIds,
  });

  static  List<User> dummyUsers = [
    User(
      id: '1',
      fullname: 'John Doe',
      email: 'jd@gmail.com',
      role: UserRole.tenant,
    ),
    User(
      id: '2',
      fullname: 'Jane Smith',
      email: 'janes@gmail.com',
      role: UserRole.landlord,
      ownedPropertyIds: ['1', '2'],
    )
  ];
}





