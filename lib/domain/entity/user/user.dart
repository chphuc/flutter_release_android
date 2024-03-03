class User {
  String accessToken;
  String? refreshToken;
  int userId;
  int expireInSeconds;

  User({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    required this.expireInSeconds
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      accessToken: json['result']['accessToken'],
      refreshToken: json['result']['refreshToken'],
      userId: json['result']['userId'],
      expireInSeconds: json['result']['expireInSeconds']
    );
  }
}
