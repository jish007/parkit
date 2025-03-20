class Profile {
  final String vehicleNumber;
  final String? phoneNum;
  final String? userName;
  final int? noOfVehicles;
  final String? vehicleType;
  final String? bookingDate;
  final String? userEmailId;
  final bool? paidStatus;
  final double? paidAmount;
  final String? allocatedSlotNumber;
  final String? parkedPropertyName;
  final String? durationOfAllocation;
  final String? paymentDate;
  final String? adminMailId;
  final String? vehicleModel;
  final double? totalAmount;
  final String? bookingTime;
  final bool? isBanned;
  final double? fineAmount;

  Profile({
    required this.vehicleNumber,
     this.phoneNum,
     this.userName,
     this.noOfVehicles,
     this.vehicleType,
     this.bookingDate,
     this.userEmailId,
     this.paidStatus,
     this.paidAmount,
     this.allocatedSlotNumber,
     this.parkedPropertyName,
     this.durationOfAllocation,
    this.paymentDate,
    this.adminMailId,
    this.vehicleModel,
    this.totalAmount,
    this.bookingTime,
    this.isBanned,
    this.fineAmount
  });

  // Factory method to parse JSON
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      vehicleNumber: json['vehicleNumber'],
      phoneNum: json['phoneNum'],
      userName: json['userName'],
      noOfVehicles: json['noOfVehicles'],
      vehicleType: json['vehicleType'],
      bookingDate: json['bookingDate'],
      userEmailId: json['userEmailId'],
      paidStatus: json['paidStatus'],
      paidAmount: json['paidAmount'],
      allocatedSlotNumber: json['allocatedSlotNumber'],
      parkedPropertyName: json['parkedPropertyName'],
      durationOfAllocation: json['durationOfAllocation'],
      paymentDate: json['paymentDate'],
      adminMailId: json['adminMailId'],
      vehicleModel: json['vehicleModel'],
      totalAmount: json['totalAmount'],
      bookingTime: json['bookingTime'],
      fineAmount: json['fineAmount'],
      isBanned: json['banned'],
    );
  }
}
