class Friend {
  Friend(this.username, this.id, this.key);

  final String username;
  final String id;
  final String key;

  Friend.fromJson(dynamic json)
      : username = json['username'],
        id = json['id'],
        key = json['key'];

  Map<String, String> toJson() => {
        'username': username,
        'id': id,
        'key': key,
      };
}
