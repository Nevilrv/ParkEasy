import 'package:admin_panel/app/modules/facilities/views/facilities_view.dart';
import 'package:admin_panel/app/modules/payment/models/payment_model.dart';
import 'package:admin_panel/app/services/firebase/payment_firebase_requests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  // paypal
  Rx<TextEditingController> paypalNameController = TextEditingController().obs;
  Rx<TextEditingController> paypalClientIdController = TextEditingController().obs;
  Rx<TextEditingController> paypalSecretIdController = TextEditingController().obs;

  // stripe
  Rx<TextEditingController> stripeNameController = TextEditingController().obs;
  Rx<TextEditingController> stripePublishIdController = TextEditingController().obs;
  Rx<TextEditingController> stripeSecretIdController = TextEditingController().obs;

  Rx<TextEditingController> cashNameController = TextEditingController().obs;
  Rx<TextEditingController> walletNameController = TextEditingController().obs;

  Rx<PaymentModel> paymentModel = PaymentModel().obs;

  Rx<Status> isPaypalActive = Status.active.obs;
  Rx<Status> isStripeActive = Status.active.obs;
  Rx<Status> isCashActive = Status.active.obs;
  Rx<Status> isWalletActive = Status.active.obs;

  Rx<Status> isPaypalSandBox = Status.active.obs;
  Rx<Status> isStripeSandBox = Status.active.obs;

  getPaymentData() {
    getPayment().then((value) {
      if (value != null) {
        paymentModel.value = value;
        //paypal
        paypalNameController.value.text = paymentModel.value.paypal!.name!;
        paypalClientIdController.value.text = paymentModel.value.paypal!.paypalClient!;
        paypalSecretIdController.value.text = paymentModel.value.paypal!.paypalSecret!;
        isPaypalActive.value = paymentModel.value.paypal!.enable == true ? Status.active : Status.inactive;
        isPaypalSandBox.value = paymentModel.value.paypal!.isSandbox == true ? Status.active : Status.inactive;
        //stripe
        stripeNameController.value.text = paymentModel.value.strip!.name!;
        stripePublishIdController.value.text = paymentModel.value.strip!.clientpublishableKey!;
        stripeSecretIdController.value.text = paymentModel.value.strip!.stripeSecret!;
        isStripeActive.value = paymentModel.value.strip!.enable == true ? Status.active : Status.inactive;
        isStripeSandBox.value = paymentModel.value.strip!.isSandbox == true ? Status.active : Status.inactive;
        //cash
        cashNameController.value.text = paymentModel.value.cash!.name!;
        isCashActive.value = paymentModel.value.cash!.enable == true ? Status.active : Status.inactive;
        //wallet
        walletNameController.value.text = paymentModel.value.wallet!.name!;
        isWalletActive.value = paymentModel.value.wallet!.enable == true ? Status.active : Status.inactive;
      }
    });
  }

  @override
  void onInit() {
    getPaymentData();
    super.onInit();
  }
}
