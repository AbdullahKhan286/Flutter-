class MNotification{
  String nId;
  final String authorId;
  final String authorName;
  final String title;
  final dynamic createdAt;
  String? body;
  String? authorPhoto;
  num? totalAttachments;
  String? attachmentsPath;
  MNotification({
    required this.title,
    required this.nId,
    required this.authorId,
    required this.authorName,
    required this.createdAt,
    this.body,
    this.authorPhoto,
    this.totalAttachments,
    this.attachmentsPath,
  });
  factory MNotification.fromJson({required Map<String,dynamic> data}){
    return MNotification(
      title: data["title"],
      nId: data["title"],
      authorId: data["authorId"],
      authorName: data["authorName"],
      createdAt: data["createdAt"],
      body: data["content"],
      authorPhoto: data["authorPhoto"],
      totalAttachments: data["totalAttachments"],
      attachmentsPath: data["attachmentsPath"],
    );
  }
}