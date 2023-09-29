class Contato {
  String? objectId;
  String? contactName;
  String? contactPhoto;
  String? contactNumber;
  String? createdAt;
  String? updatedAt;

  Contato(
      {this.objectId,
      this.contactName,
      this.contactPhoto,
      this.contactNumber,
      this.createdAt,
      this.updatedAt});

  Contato.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    contactName = json['contactName'];
    contactPhoto = json['contactPhoto'];
    contactNumber = json['contactNumber'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['objectId'] = this.objectId;
    data['contactName'] = this.contactName;
    data['contactPhoto'] = this.contactPhoto;
    data['contactNumber'] = this.contactNumber;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
