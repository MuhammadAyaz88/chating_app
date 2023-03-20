class User {
  final String name,email,password,id,notification_token,img_url;
      // reciver_id,sender_id,message_type;
  int timestamp;

//<editor-fold desc="Data Methods">

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.id,
    required this.notification_token,
    required this.img_url,
    required this.timestamp,
  });

// Ma@override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          email == other.email &&
          password == other.password &&
          id == other.id &&
          notification_token == other.notification_token &&
          img_url == other.img_url &&
          timestamp == other.timestamp);

  @override
  int get hashCode =>
      name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      id.hashCode ^
      notification_token.hashCode ^
      img_url.hashCode ^
      timestamp.hashCode;

  @override
  String toString() {
    return 'User{' +
        ' name: $name,' +
        ' email: $email,' +
        ' password: $password,' +
        ' id: $id,' +
        ' notification_token: $notification_token,' +
        ' img_url: $img_url,' +
        ' timestamp: $timestamp,' +
        '}';
  }

  User copyWith({
    String? name,
    String? email,
    String? password,
    String? id,
    String? notification_token,
    String? img_url,
    int? timestamp,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      id: id ?? this.id,
      notification_token: notification_token ?? this.notification_token,
      img_url: img_url ?? this.img_url,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'email': this.email,
      'password': this.password,
      'id': this.id,
      'notification_token': this.notification_token,
      'img_url': this.img_url,
      'timestamp': this.timestamp,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      id: map['id'] as String,
      notification_token: map['notification_token'] as String,
      img_url: map['img_url'] as String,
      timestamp: map['timestamp'] as int,
    );
  }

  //</editor-fold>p<String, dynamic>? optionalData;

}
