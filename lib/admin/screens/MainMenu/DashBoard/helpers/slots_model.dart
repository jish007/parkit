class Slots {
  final int slotId;
  final String slotNumber;
  final String floor;
  final String vehicleType;
  final String propertyName;
  final String city;
  final String district;
  final String state;
  final String country;
  final bool slotAvailability;
  final String googleLocation;
  final String adminName;
  final String adminPhone;
  final String propertyType;
  final String adminMailId;
  final String? vehicleNum;
  final String? startTime;
  final String? exitTime;


  Slots({
    required this.slotId,
    required this.slotNumber,
    required this.floor,
    required this.vehicleType,
    required this.propertyName,
    required this.city,
    required this.district,
    required this.state,
    required this.country,
    required this.slotAvailability,
    required this.googleLocation,
    required this.adminName,
    required this.adminPhone,
    required this.propertyType,
    required this.adminMailId,
    this.vehicleNum,
    this.startTime,
    this.exitTime,
  });

  // Factory method to parse JSON
  factory Slots.fromJson(Map<String, dynamic> json) {
    return Slots(
      slotId: json['slotId'],
      slotNumber: json['slotNumber'],
      floor: json['floor'],
      vehicleType: json['vehicleType'],
      propertyName: json['propertyName'],
      city: json['city'],
      district: json['district'],
      state: json['state'],
      country: json['country'],
      slotAvailability: json['slotAvailability'],
      googleLocation: json['googleLocation'],
      adminName: json['adminName'],
      adminPhone: json['adminPhone'],
      propertyType: json['propertyType'],
      adminMailId: json['adminMailId'],
      vehicleNum: json['vehicleNum'],
      startTime: json['startTime'],
      exitTime: json['exitTime'],
    );
  }
}
