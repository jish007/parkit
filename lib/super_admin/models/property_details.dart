class PropertyDetails {
  String? slotId;
  String? slotNumber;
  String? floor;
  String? vehicleType;
  String? propertyName;
  String? city;
  String? district;
  String? state;
  String? country;
  String? googleLocation;
   String? adminName;
   String? adminPhone;
   String? propertyType;
   String? adminMailId;
   String? roleName;
   String? responsibilities;
   int? duration;
   int? charge;
   int? x;
   int? y;
   int? height;
   int? width;
   String? ranges;
   String? sheetId;
   String? propertyDesc;
   String? propertyOwner;
   String? ownerPhoneNum;


  PropertyDetails({
    this.slotId,
    this.slotNumber,
    this.floor,
    this.vehicleType,
    this.propertyName,
    this.city,
    this.district,
    this.state,
    this.country,
    this.googleLocation,
    this.adminName,
    this.adminPhone,
    this.propertyType,
    this.adminMailId,
    this.roleName,
    this.responsibilities,
    this.duration,
    this.charge,
    this.ownerPhoneNum,
    this.propertyOwner,
    this.propertyDesc,
    this.sheetId,
    this.ranges,
    this.height,
    this.width,
    this.x,
    this.y,
  });

  factory PropertyDetails.fromJson(Map<String, dynamic> json) {
    return PropertyDetails(
      slotId: json["slotId"].toString() as String?,
      slotNumber: json["slotNumber"] as String?,
      floor: json["floor"] as String?,
      vehicleType: json["vehicleType"] as String?,
      propertyName: json["propertyName"] as String?,
      city: json["city"] as String?,
      district: json["district"] as String?,
      state: json["state"] as String?,
      country: json["country"] as String?,
      googleLocation: json["googleLocation"] as String?,
      adminName: json["adminName"] as String?,
      adminPhone: json["adminPhone"] as String?,
      propertyType: json["propertyType"] as String?,
      adminMailId: json["adminMailId"] as String?,
      roleName: json["roleName"] as String?,
      responsibilities: json["responsibilities"] as String?,
      duration: json["duration"] as int?,
      charge: json["charge"] as int?,
      ownerPhoneNum: json["ownerPhoneNum"] as String?,
      propertyOwner: json["propertyOwner"] as String?,
      propertyDesc: json["propertyDesc"] as String?,
      sheetId: json["sheetId"] as String?,
      ranges: json["ranges"] as String?,
      width: json["width"] as int?,
      height: json["height"] as int?,
      y: json["y"] as int?,
      x: json["x"] as int?,
    );
  }
}
