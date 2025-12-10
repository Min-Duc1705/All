class ResponseLogin {
  final int id;
  final String name;
  final String email;
  final String accessToken;
  final String? avatarUrl;

  ResponseLogin({
    required this.id,
    required this.name,
    required this.email,
    required this.accessToken,
    this.avatarUrl,
  });

  factory ResponseLogin.fromJson(Map<String, dynamic> json) {
    // Backend trả về { "user": {...}, "access_token": "..." }
    final userJson = json['user'] as Map<String, dynamic>;
    return ResponseLogin(
      id: userJson['id'],
      name: userJson['name'],
      email: userJson['email'],
      accessToken: json['access_token'],
      avatarUrl: userJson['avatarUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'access_token': accessToken,
      'avatarUrl': avatarUrl,
    };
  }
}
