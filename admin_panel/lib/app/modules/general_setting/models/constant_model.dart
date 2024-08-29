class ConstantModel {
  String? googleMapKey;
  String? plateRecognizerApiToken;
  String? minimumAmountDeposit;
  String? minimumAmountWithdraw;
  String? notificationServerKey;
  String? privacyPolicy;
  String? radius;
  String? supportEmail;
  String? supportURL;
  String? termsAndConditions;
  String? referralAmount;
  String? phoneNumber;
  String? appVersion;

  ConstantModel(
      {this.googleMapKey,
      this.minimumAmountDeposit,
      this.plateRecognizerApiToken,
      this.minimumAmountWithdraw,
      this.notificationServerKey,
      this.privacyPolicy,
      this.radius,
      this.supportEmail,
      this.supportURL,
      this.termsAndConditions,
      this.referralAmount,
      this.phoneNumber,
      this.appVersion});

  ConstantModel.fromJson(Map<String, dynamic> json) {
    googleMapKey = json['googleMapKey'];
    plateRecognizerApiToken = json['plateRecognizerApiToken'];
    minimumAmountDeposit = json['minimum_amount_deposit'];
    minimumAmountWithdraw = json['minimum_amount_withdraw'];
    notificationServerKey = json['notification_server_key'];
    privacyPolicy = json['privacyPolicy'];
    radius = json['radius'];
    supportEmail = json['supportEmail'];
    supportURL = json['supportURL'];
    termsAndConditions = json['termsAndConditions'];
    referralAmount = json['referralAmount'];
    phoneNumber = json['phoneNumber'];
    appVersion = json['appVersion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['googleMapKey'] = googleMapKey ?? "";
    data['minimum_amount_deposit'] = minimumAmountDeposit ?? "";
    data['plateRecognizerApiToken'] = plateRecognizerApiToken ?? "";
    data['minimum_amount_withdraw'] = minimumAmountWithdraw ?? "";
    data['notification_server_key'] = notificationServerKey ?? "";
    data['privacyPolicy'] = privacyPolicy ?? "";
    data['radius'] = radius ?? "";
    data['supportEmail'] = supportEmail ?? "";
    data['supportURL'] = supportURL ?? "";
    data['termsAndConditions'] = termsAndConditions ?? "";
    data['referralAmount'] = referralAmount ?? "";
    data['phoneNumber'] = phoneNumber ?? "";
    data['appVersion'] = appVersion ?? "";
    return data;
  }
}
