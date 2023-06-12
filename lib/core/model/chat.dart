class Chat {
  final String messageId;
  final String roomId;

  final String content;
  final String senderId;
  final String senderNickname;
  final int violentPrice;

  final int createdAtTs;
  Chat(this.messageId, this.roomId, this.content, this.senderId, this.senderNickname, this.violentPrice, this.createdAtTs);
}
