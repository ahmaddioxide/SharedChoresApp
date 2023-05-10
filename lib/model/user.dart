class User {
  String userId;
  String name;
  String email;
  String password;
  String phone;
  String image;

  User(
      {required this.userId,
      required this.name,
      required this.email,
      required this.password,
      required this.phone,
      required this.image});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'image': image,
      };
}
