class Room {
  final String roomId;
  final String roomName;
  final String ownerId;
  final int createdAtTs;
  final int lastMessageAtTs;
  final int unreadMessageCount;
  final int cumulatedPrice;
  final String roomImageUrl;

  Room(this.roomId, this.roomName, this.ownerId, this.createdAtTs,
      this.lastMessageAtTs, this.unreadMessageCount, this.cumulatedPrice, this.roomImageUrl);

  @override
  int get hashCode => roomId.hashCode;

  @override
  bool operator ==(Object other) {
    if(other is Room) {
      return other.roomId == roomId;
    }
    return false;
  }
}