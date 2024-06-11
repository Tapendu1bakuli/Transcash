class AddedMoneyUsingPaypalModel {
  AddedMoneyUsingPaypalModel({
     this.shortMessage,
     this.longMessage,
     this.data,
     this.status,
  });
   String? shortMessage;
   String? longMessage;
   Data? data;
   int? status;

  AddedMoneyUsingPaypalModel.fromJson(Map<String, dynamic> json){
    shortMessage = json['short_message'];
    longMessage = json['long_message'];
    data = Data.fromJson(json['data']);
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['short_message'] = shortMessage;
    _data['long_message'] = longMessage;
    _data['data'] = data!.toJson();
    _data['status'] = status;
    return _data;
  }
}

class Data {
  Data({
     this.id,
     this.name,
     this.email,
     this.emailVerifiedAt,
     this.phone,
     this.userType,
    this.dob,
     this.createdAt,
     this.updatedAt,
     this.isVerified,
     this.profileImage,
     this.countryCode,
    this.otpCode,
     this.isActive,
     this.stripeCustomerId,
     this.totalAmount,
  });
   int? id;
   String? name;
   String? email;
   String? emailVerifiedAt;
   String? phone;
   String? userType;
   String? dob;
   String? createdAt;
   String? updatedAt;
   int? isVerified;
   String? profileImage;
   String? countryCode;
   String? otpCode;
   int? isActive;
   String? stripeCustomerId;
   int? totalAmount;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    userType = json['user_type'];
    dob = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isVerified = json['is_verified'];
    profileImage = json['profile_image'];
    countryCode = json['country_code'];
    otpCode = null;
    isActive = json['is_active'];
    stripeCustomerId = json['stripe_customer_id'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['email_verified_at'] = emailVerifiedAt;
    _data['phone'] = phone;
    _data['user_type'] = userType;
    _data['dob'] = dob;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['is_verified'] = isVerified;
    _data['profile_image'] = profileImage;
    _data['country_code'] = countryCode;
    _data['otp_code'] = otpCode;
    _data['is_active'] = isActive;
    _data['stripe_customer_id'] = stripeCustomerId;
    _data['total_amount'] = totalAmount;
    return _data;
  }
}