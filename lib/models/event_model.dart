Event eventFromJson(dynamic json) => Event.fromJson(json);

class Event {
  Event({
    required this.id,
    required this.userId,
    required this.eventTypeId,
    required this.timestamp,
    required this.body,
    required this.lat,
  });

  int id;
  int userId;
  int eventTypeId;
  DateTime timestamp;
  EventBody body;
  int lat;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json['id'],
    userId: json['user_id'],
    eventTypeId: json['event_type_id'],
    timestamp: DateTime.parse(json['timestamp']),
    body: EventBody.fromJson(json['body']),
    lat: json['lat'],
  );
}

class EventBody {
  EventBody({
    required this.content,
  });

  String content;

  factory EventBody.fromJson(Map<String, dynamic> json) => EventBody(
    content: json['content'],
  );
}
