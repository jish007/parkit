class PropertyDetails {
  final int? slotId;
  final String? slotNumber;
  final String? floor;
  final String? vehicleType;
  final String? propertyName;
  final String? city;
  final String? district;
  final String? state;
  final String? country;
  final bool? slotAvailability;
  final String? googleLocation;
  final String? adminName;
  final String? adminPhone;
  final String? propertyType;
  final String? adminMailId;
  final String? vehicleNum;
  final String? roleName;
  final String? responsibilities;
  final int? duration;
  final int? charge;

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
    this.slotAvailability,
    this.googleLocation,
    this.adminName,
    this.adminPhone,
    this.propertyType,
    this.adminMailId,
    this.vehicleNum,
    this.roleName,
    this.responsibilities,
    this.duration,
    this.charge,
  });

  factory PropertyDetails.fromJson(Map<String, dynamic> json) {
    return PropertyDetails(
      slotId: json["slotId"] as int?,
      slotNumber: json["slotNumber"] as String?,
      floor: json["floor"] as String?,
      vehicleType: json["vehicleType"] as String?,
      propertyName: json["propertyName"] as String?,
      city: json["city"] as String?,
      district: json["district"] as String?,
      state: json["state"] as String?,
      country: json["country"] as String?,
      slotAvailability: json["slotAvailability"] as bool?,
      googleLocation: json["googleLocation"] as String?,
      adminName: json["adminName"] as String?,
      adminPhone: json["adminPhone"] as String?,
      propertyType: json["propertyType"] as String?,
      adminMailId: json["adminMailId"] as String?,
      vehicleNum: json["vehicleNum"] as String?,
      roleName: json["roleName"] as String?,
      responsibilities: json["responsibilities"] as String?,
      duration: json["duration"] as int?,
      charge: json["charge"] as int?,
    );
  }
}
