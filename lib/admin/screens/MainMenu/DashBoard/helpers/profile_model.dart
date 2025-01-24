class Profile {
  final String vehicleNumber;
  final String phoneNum;
  final String userName;
  final int noOfVehicles;
  final String vehicleType;
  final String bookingDate;
  final String userEmailId;
  final bool paidStatus;
  final double paidAmount;
  final String allocatedSlotNumber;
  final String parkedPropertyName;
  final int durationOfAllocation;
  final String paymentDate;
  final String adminMailId;
  final String vehicleModel;
  final double totalAmount;
  final String bookingTime;
  final bool? isBanned;
  final int? fineAmount;

  Profile({
    required this.vehicleNumber,
    required this.phoneNum,
    required this.userName,
    required this.noOfVehicles,
    required this.vehicleType,
    required this.bookingDate,
    required this.userEmailId,
    required this.paidStatus,
    required this.paidAmount,
    required this.allocatedSlotNumber,
    required this.parkedPropertyName,
    required this.durationOfAllocation,
    required this.paymentDate,
    required this.adminMailId,
    required this.vehicleModel,
    required this.totalAmount,
    required this.bookingTime,
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
