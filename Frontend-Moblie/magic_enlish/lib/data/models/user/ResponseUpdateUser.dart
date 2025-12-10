class ResponseUpdateUser {
  final int id;
  final String name;
  final String email;
  final String? avatarUrl;

  ResponseUpdateUser({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  factory ResponseUpdateUser.fromJson(Map<String, dynamic> json) {
    // Backend trả về { "user": {...}, "access_token": "..." }
    final userJson = json['user'] as Map<String, dynamic>;
    return ResponseUpdateUser(
      id: userJson['id'],
      name: userJson['name'],
      email: userJson['email'],
      avatarUrl: userJson['avatarUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
    };
  }
}
