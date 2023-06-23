class UserModel {
  String name;
  String email;
  String address;
  String profilePic;
  String createdAt;
  String phoneNumber;
  String uid;
  String docId;

  UserModel(
      {required this.name,
      required this.email,
      required this.address,
      required this.profilePic,
      required this.createdAt,
      required this.phoneNumber,
      required this.uid,
      required this.docId});

  // from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        address: map['address'] ?? '',
        uid: map['uid'] ?? '',
        phoneNumber: map['phoneNumber'] ?? '',
        createdAt: map['createdAt'] ?? '',
        profilePic: map['profilePic'] ?? '',
        docId: map['docId'] ?? '');
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "uid": uid,
      "address": address,
      "profilePic": profilePic,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
      "docId": docId
    };
  }

  @override
  String toString() {
    return 'UserModel{name: $name, email: $email, address: $address, profilePic: $profilePic, createdAt: $createdAt, phoneNumber: $phoneNumber, uid: $uid, docId: $docId}';
  }
}
