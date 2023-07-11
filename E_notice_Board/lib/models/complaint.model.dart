class MComplaint{
  final String nId;
  final String authorId;
  final String authorName;
  final String title;
  final dynamic createdAt;
  final bool read;
  MComplaint({
    required this.title,
    required this.nId,
    required this.authorId,
    required this.authorName,
    required this.createdAt,
    required this.read,
  });
  factory MComplaint.fromJson({required Map<String,dynamic> data}){
    return MComplaint(
      title: data["title"],
      nId: data["title"],
      authorId: data["authorId"],
      authorName: data["authorName"],
      createdAt: data["createdAt"],
      read: data["read"]??false,
    );
  }
}