class Message {
  Message(this.text, this.timestamp, this.authorSent);

  final String text;
  final int timestamp;
  final bool authorSent;

  Message.fromJson(dynamic json)
      : text = json['text'],
        timestamp = json['timestamp'],
        authorSent = json['authorSent'];

  Map<String, String> toJson() => {
        'authorSent': authorSent.toString(),
        'timestamp': timestamp.toString(),
        'text': text,
      };
}
