class VendorUserModel {

  final String? Uid;
  final bool? approved;

  final String? bussinessName;

  final String? location;

  final String? email;

  final String? phone;

  final String? storeImage;
  VendorUserModel({
    required this.Uid,
    required this.approved,
    required this.bussinessName,
    required this.email,
    required this.location,
    required this.phone,
    required this.storeImage,

  });

  VendorUserModel.fromJson(Map<String, Object?> json)
      : this(
          approved: json['approved']! as bool,
          Uid: json['Uid']! as String,
          bussinessName: json['bussinessName']! as String,
          location: json['location']! as String,
          email: json['email']! as String,
          phone: json['phone']! as String,
          storeImage: json['storeImage']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'approved': approved,
      'vendorId': Uid,
      'bussinessName': bussinessName,
      'location': location,
      'email': email,
      'phone': phone,
      'storeImage': storeImage,
    };
  }
}
