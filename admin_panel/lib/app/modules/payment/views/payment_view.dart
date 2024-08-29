import 'package:admin_panel/app/components/admin_custom_text_form_field.dart';
import 'package:admin_panel/app/components/dialog_box.dart';
import 'package:admin_panel/app/modules/facilities/views/facilities_view.dart';
import 'package:admin_panel/app/services/firebase/payment_firebase_requests.dart';
import 'package:admin_panel/app/utils/app_colors.dart';
import 'package:admin_panel/app/utils/const.dart';
import 'package:admin_panel/app/utils/constants.dart';
import 'package:admin_panel/app/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/payment_controller.dart';

PaymentController paymentController = Get.put(PaymentController());

class PaymentView extends StatelessWidget {
  const PaymentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primaryWhite,
        elevation: 0,
        title: Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(
            left: ScreenSize.width(1, context),
          ),
          child: Text(
            'Payment',
            style: GoogleFonts.poppins(fontSize: 24, color: AppColors.primaryBlack, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 45, bottom: 20),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "* Note : If you want to change any field then click this ",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColors.red,
                      ),
                    ),
                    WidgetSpan(
                      child: Icon(
                        Icons.check_circle_outline,
                        color: AppColors.red,
                        size: 20,
                      ),
                    ),
                    TextSpan(
                      text: " icon to save",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.sp),
              width: 1.sw,
              decoration: BoxDecoration(
                  color: AppColors.primaryWhite, boxShadow: [BoxShadow(blurRadius: 10, color: AppColors.primaryBlack.withOpacity(0.3))]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: AppColors.appColor,
                    height: 5,
                    width: 1.sw,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 30, 0),
                    child: Text(
                      "Paypal".toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: AppColors.primaryBlack,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                          child: AdminCustomTextFormField(
                              title: "Name",
                              hint: "Enter name",
                              width: 0.3.sw,
                              paddingBetweenTitle: 10,
                              prefixIcon: const Icon(Icons.abc_outlined),
                              textFormIcon: InkWell(
                                child: const Icon(Icons.check_circle_outline),
                                onTap: () {
                                  if (Constant.isDemo) {
                                    DialogBox.dialogBox(
                                        context: Get.context!,
                                        title: "No Access!",
                                        description: "You have no right to add, edit and delete");
                                  } else {
                                    if (paymentController.paypalNameController.value.text.isNotEmpty) {
                                      ProgressLoader.showLoadingDialog();

                                      Constant.paymentModel!.paypal!.name = paymentController.paypalNameController.value.text;
                                      setPayment(Constant.paymentModel!).then((value) {
                                        Get.back();
                                        showSuccessToast("Paypal name updated");
                                      });
                                    } else {
                                      showError("Please add paypal name");
                                    }
                                  }
                                },
                              ),
                              textEditingController: paymentController.paypalNameController.value),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                          child: AdminCustomTextFormField(
                              title: "Paypal Client Id",
                              hint: "Enter paypal client id",
                              width: 0.3.sw,
                              paddingBetweenTitle: 10,
                              isObscure: Constant.isDemo ? true : false,
                              prefixIcon: const Icon(Icons.key),
                              textFormIcon: InkWell(
                                child: const Icon(Icons.check_circle_outline),
                                onTap: () {
                                  if (Constant.isDemo) {
                                    DialogBox.dialogBox(
                                        context: Get.context!,
                                        title: "No Access!",
                                        description: "You have no right to add, edit and delete");
                                  } else {
                                    if (paymentController.paypalClientIdController.value.text.isNotEmpty) {
                                      ProgressLoader.showLoadingDialog();
                                      Constant.paymentModel!.paypal!.paypalClient = paymentController.paypalClientIdController.value.text;
                                      setPayment(Constant.paymentModel!).then((value) {
                                        Get.back();
                                        showSuccessToast("Paypal client id updated");
                                      });
                                    } else {
                                      showError("Please add paypal client id");
                                    }
                                  }
                                },
                              ),
                              textEditingController: paymentController.paypalClientIdController.value),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                          child: AdminCustomTextFormField(
                              title: "Paypal Secret Id",
                              hint: "Enter paypal secret id",
                              width: 0.3.sw,
                              isObscure: Constant.isDemo ? true : false,
                              paddingBetweenTitle: 10,
                              prefixIcon: const Icon(Icons.key),
                              textFormIcon: InkWell(
                                child: const Icon(Icons.check_circle_outline),
                                onTap: () {
                                  if (Constant.isDemo) {
                                    DialogBox.dialogBox(
                                        context: Get.context!,
                                        title: "No Access!",
                                        description: "You have no right to add, edit and delete");
                                  } else {
                                    if (paymentController.paypalSecretIdController.value.text.isNotEmpty) {
                                      ProgressLoader.showLoadingDialog();
                                      Constant.paymentModel!.paypal!.paypalSecret = paymentController.paypalSecretIdController.value.text;
                                      setPayment(Constant.paymentModel!).then((value) {
                                        Get.back();
                                        showSuccessToast("paypal Secret id updated");
                                      });
                                    } else {
                                      showError("Please add paypal Secret id");
                                    }
                                  }
                                },
                              ),
                              textEditingController: paymentController.paypalSecretIdController.value),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Obx(
                        () => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 0, 0, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Status",
                                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Radio(
                                          value: Status.active,
                                          groupValue: paymentController.isStripeActive.value,
                                          onChanged: (value) {
                                            if (Constant.isDemo) {
                                              DialogBox.dialogBox(
                                                  context: Get.context!,
                                                  title: "No Access!",
                                                  description: "You have no right to add, edit and delete");
                                            } else {
                                              paymentController.isStripeActive.value = value ?? Status.active;
                                              ProgressLoader.showLoadingDialog();
                                              Constant.paymentModel!.paypal!.enable = true;
                                              setPayment(Constant.paymentModel!).then((value) {
                                                Get.back();
                                                showSuccessToast("Paypal status updated");
                                              });
                                            }
                                          },
                                          activeColor: AppColors.appColor,
                                        ),
                                        Text("Active",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
                                              color: AppColors.textGrey,
                                            ))
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                          value: Status.inactive,
                                          groupValue: paymentController.isStripeActive.value,
                                          onChanged: (value) {
                                            if (Constant.isDemo) {
                                              DialogBox.dialogBox(
                                                  context: Get.context!,
                                                  title: "No Access!",
                                                  description: "You have no right to add, edit and delete");
                                            } else {
                                              paymentController.isStripeActive.value = value ?? Status.inactive;
                                              ProgressLoader.showLoadingDialog();
                                              Constant.paymentModel!.paypal!.enable = false;
                                              setPayment(Constant.paymentModel!).then((value) {
                                                Get.back();
                                                showSuccessToast("Paypal status updated");
                                              });
                                            }
                                          },
                                          activeColor: AppColors.appColor,
                                        ),
                                        Text("Inactive",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
                                              color: AppColors.textGrey,
                                            ))
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 0, 0, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "SandBox",
                                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Radio(
                                          value: Status.active,
                                          groupValue: paymentController.isPaypalSandBox.value,
                                          onChanged: (value) {
                                            if (Constant.isDemo) {
                                              DialogBox.dialogBox(
                                                  context: Get.context!,
                                                  title: "No Access!",
                                                  description: "You have no right to add, edit and delete");
                                            } else {
                                              paymentController.isPaypalSandBox.value = value ?? Status.active;
                                              ProgressLoader.showLoadingDialog();
                                              Constant.paymentModel!.paypal!.isSandbox = true;
                                              setPayment(Constant.paymentModel!).then((value) {
                                                Get.back();
                                                showSuccessToast("Paypal sandbox status updated");
                                              });
                                            }
                                          },
                                          activeColor: AppColors.appColor,
                                        ),
                                        Text("Test",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
                                              color: AppColors.textGrey,
                                            ))
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                          value: Status.inactive,
                                          groupValue: paymentController.isPaypalSandBox.value,
                                          onChanged: (value) {
                                            if (Constant.isDemo) {
                                              DialogBox.dialogBox(
                                                  context: Get.context!,
                                                  title: "No Access!",
                                                  description: "You have no right to add, edit and delete");
                                            } else {
                                              paymentController.isPaypalSandBox.value = value ?? Status.inactive;
                                              ProgressLoader.showLoadingDialog();
                                              Constant.paymentModel!.paypal!.isSandbox = false;
                                              setPayment(Constant.paymentModel!).then((value) {
                                                Get.back();
                                                showSuccessToast("Paypal sandbox status updated");
                                              });
                                            }
                                          },
                                          activeColor: AppColors.appColor,
                                        ),
                                        Text("Live",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
                                              color: AppColors.textGrey,
                                            ))
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(child: Container())
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.sp),
              width: 1.sw,
              decoration: BoxDecoration(
                  color: AppColors.primaryWhite, boxShadow: [BoxShadow(blurRadius: 10, color: AppColors.primaryBlack.withOpacity(0.3))]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: AppColors.appColor,
                    height: 5,
                    width: 1.sw,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 30, 0),
                    child: Text(
                      "Stripe".toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: AppColors.primaryBlack,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                          child: AdminCustomTextFormField(
                              title: "Name",
                              hint: "Enter name",
                              width: 0.3.sw,
                              paddingBetweenTitle: 10,
                              prefixIcon: const Icon(Icons.abc_outlined),
                              textFormIcon: InkWell(
                                child: const Icon(Icons.check_circle_outline),
                                onTap: () {
                                  if (Constant.isDemo) {
                                    DialogBox.dialogBox(
                                        context: Get.context!,
                                        title: "No Access!",
                                        description: "You have no right to add, edit and delete");
                                  } else {
                                    if (paymentController.stripeNameController.value.text.isNotEmpty) {
                                      ProgressLoader.showLoadingDialog();
                                      Constant.paymentModel!.strip!.name = paymentController.stripeNameController.value.text;
                                      setPayment(Constant.paymentModel!).then((value) {
                                        Get.back();
                                        showSuccessToast("Stripe name updated");
                                      });
                                    } else {
                                      showError("Please add stripe name");
                                    }
                                  }
                                },
                              ),
                              textEditingController: paymentController.stripeNameController.value),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                          child: AdminCustomTextFormField(
                              title: "Stripe Publish Key",
                              hint: "Enter stripe publish key",
                              width: 0.3.sw,
                              isObscure: Constant.isDemo ? true : false,
                              paddingBetweenTitle: 10,
                              prefixIcon: const Icon(Icons.key),
                              textFormIcon: InkWell(
                                child: const Icon(Icons.check_circle_outline),
                                onTap: () {
                                  if (Constant.isDemo) {
                                    DialogBox.dialogBox(
                                        context: Get.context!,
                                        title: "No Access!",
                                        description: "You have no right to add, edit and delete");
                                  } else {
                                    if (paymentController.stripePublishIdController.value.text.isNotEmpty) {
                                      ProgressLoader.showLoadingDialog();
                                      Constant.paymentModel!.strip!.clientpublishableKey =
                                          paymentController.stripePublishIdController.value.text;
                                      setPayment(Constant.paymentModel!).then((value) {
                                        Get.back();
                                        showSuccessToast("Stripe publish key updated");
                                      });
                                    } else {
                                      showError("Please add stripe publish key");
                                    }
                                  }
                                },
                              ),
                              textEditingController: paymentController.stripePublishIdController.value),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                          child: AdminCustomTextFormField(
                              title: "Stripe Secret Key",
                              hint: "Enter Stripe secret key",
                              width: 0.3.sw,
                              isObscure: Constant.isDemo ? true : false,
                              paddingBetweenTitle: 10,
                              prefixIcon: const Icon(Icons.key),
                              textFormIcon: InkWell(
                                child: const Icon(Icons.check_circle_outline),
                                onTap: () {
                                  if (Constant.isDemo) {
                                    DialogBox.dialogBox(
                                        context: Get.context!,
                                        title: "No Access!",
                                        description: "You have no right to add, edit and delete");
                                  } else {
                                    if (paymentController.stripeSecretIdController.value.text.isNotEmpty) {
                                      ProgressLoader.showLoadingDialog();
                                      Constant.paymentModel!.strip!.stripeSecret = paymentController.stripeSecretIdController.value.text;
                                      setPayment(Constant.paymentModel!).then((value) {
                                        Get.back();
                                        showSuccessToast("Stripe secret key updated");
                                      });
                                    } else {
                                      showError("Please add stripe secret key");
                                    }
                                  }
                                },
                              ),
                              textEditingController: paymentController.stripeSecretIdController.value),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Obx(
                        () => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 0, 0, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Status",
                                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Radio(
                                          value: Status.active,
                                          groupValue: paymentController.isStripeSandBox.value,
                                          onChanged: (value) {
                                            if (Constant.isDemo) {
                                              DialogBox.dialogBox(
                                                  context: Get.context!,
                                                  title: "No Access!",
                                                  description: "You have no right to add, edit and delete");
                                            } else {
                                              paymentController.isStripeSandBox.value = value ?? Status.active;
                                              ProgressLoader.showLoadingDialog();
                                              Constant.paymentModel!.strip!.enable = true;
                                              setPayment(Constant.paymentModel!).then((value) {
                                                Get.back();
                                                showSuccessToast("Stripe status updated");
                                              });
                                            }
                                          },
                                          activeColor: AppColors.appColor,
                                        ),
                                        Text("Active",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
                                              color: AppColors.textGrey,
                                            ))
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                          value: Status.inactive,
                                          groupValue: paymentController.isStripeSandBox.value,
                                          onChanged: (value) {
                                            if (Constant.isDemo) {
                                              DialogBox.dialogBox(
                                                  context: Get.context!,
                                                  title: "No Access!",
                                                  description: "You have no right to add, edit and delete");
                                            } else {
                                              paymentController.isStripeSandBox.value = value ?? Status.inactive;
                                              ProgressLoader.showLoadingDialog();
                                              Constant.paymentModel!.strip!.enable = false;
                                              setPayment(Constant.paymentModel!).then((value) {
                                                Get.back();
                                                showSuccessToast("Stripe status updated");
                                              });
                                            }
                                          },
                                          activeColor: AppColors.appColor,
                                        ),
                                        Text("Inactive",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
                                              color: AppColors.textGrey,
                                            ))
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 0, 0, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "SandBox",
                                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Radio(
                                          value: Status.active,
                                          groupValue: paymentController.isStripeSandBox.value,
                                          onChanged: (value) {
                                            if (Constant.isDemo) {
                                              DialogBox.dialogBox(
                                                  context: Get.context!,
                                                  title: "No Access!",
                                                  description: "You have no right to add, edit and delete");
                                            } else {
                                              paymentController.isStripeSandBox.value = value ?? Status.active;
                                              ProgressLoader.showLoadingDialog();
                                              Constant.paymentModel!.strip!.isSandbox = true;
                                              setPayment(Constant.paymentModel!).then((value) {
                                                Get.back();
                                                showSuccessToast("Stripe sandbox status updated");
                                              });
                                            }
                                          },
                                          activeColor: AppColors.appColor,
                                        ),
                                        Text("Test",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
                                              color: AppColors.textGrey,
                                            ))
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                          value: Status.inactive,
                                          groupValue: paymentController.isStripeSandBox.value,
                                          onChanged: (value) {
                                            if (Constant.isDemo) {
                                              DialogBox.dialogBox(
                                                  context: Get.context!,
                                                  title: "No Access!",
                                                  description: "You have no right to add, edit and delete");
                                            } else {
                                              paymentController.isStripeSandBox.value = value ?? Status.inactive;
                                              ProgressLoader.showLoadingDialog();
                                              Constant.paymentModel!.strip!.isSandbox = false;
                                              setPayment(Constant.paymentModel!).then((value) {
                                                Get.back();
                                                showSuccessToast("Stripe sandbox status updated");
                                              });
                                            }
                                          },
                                          activeColor: AppColors.appColor,
                                        ),
                                        Text("Live",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
                                              color: AppColors.textGrey,
                                            ))
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(child: Container())
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.sp),
              width: 1.sw,
              decoration: BoxDecoration(
                  color: AppColors.primaryWhite, boxShadow: [BoxShadow(blurRadius: 10, color: AppColors.primaryBlack.withOpacity(0.3))]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: AppColors.appColor,
                    height: 5,
                    width: 1.sw,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 30, 0),
                    child: Text(
                      "Cash".toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: AppColors.primaryBlack,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                          child: AdminCustomTextFormField(
                              title: "Name",
                              hint: "Enter name",
                              width: 0.3.sw,
                              paddingBetweenTitle: 10,
                              prefixIcon: const Icon(Icons.abc_outlined),
                              textFormIcon: InkWell(
                                child: const Icon(Icons.check_circle_outline),
                                onTap: () {
                                  if (Constant.isDemo) {
                                    DialogBox.dialogBox(
                                        context: Get.context!,
                                        title: "No Access!",
                                        description: "You have no right to add, edit and delete");
                                  } else {
                                    if (paymentController.cashNameController.value.text.isNotEmpty) {
                                      ProgressLoader.showLoadingDialog();
                                      Constant.paymentModel!.cash!.name = paymentController.cashNameController.value.text;
                                      setPayment(Constant.paymentModel!).then((value) {
                                        Get.back();
                                        showSuccessToast("Cash name updated");
                                      });
                                    } else {
                                      showError("Please add cash name");
                                    }
                                  }
                                },
                              ),
                              textEditingController: paymentController.cashNameController.value),
                        ),
                      ),
                      Obx(
                        () => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Status",
                                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Radio(
                                          value: Status.active,
                                          groupValue: paymentController.isCashActive.value,
                                          onChanged: (value) {
                                            if (Constant.isDemo) {
                                              DialogBox.dialogBox(
                                                  context: Get.context!,
                                                  title: "No Access!",
                                                  description: "You have no right to add, edit and delete");
                                            } else {
                                              paymentController.isCashActive.value = value ?? Status.active;
                                              ProgressLoader.showLoadingDialog();
                                              Constant.paymentModel!.cash!.enable = true;
                                              setPayment(Constant.paymentModel!).then((value) {
                                                Get.back();
                                                showSuccessToast("Cash status updated");
                                              });
                                            }
                                          },
                                          activeColor: AppColors.appColor,
                                        ),
                                        Text("Active",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
                                              color: AppColors.textGrey,
                                            ))
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                          value: Status.inactive,
                                          groupValue: paymentController.isCashActive.value,
                                          onChanged: (value) {
                                            if (Constant.isDemo) {
                                              DialogBox.dialogBox(
                                                  context: Get.context!,
                                                  title: "No Access!",
                                                  description: "You have no right to add, edit and delete");
                                            } else {
                                              paymentController.isCashActive.value = value ?? Status.inactive;
                                              ProgressLoader.showLoadingDialog();
                                              Constant.paymentModel!.cash!.enable = false;
                                              setPayment(Constant.paymentModel!).then((value) {
                                                Get.back();
                                                showSuccessToast("Cash status updated");
                                              });
                                            }
                                          },
                                          activeColor: AppColors.appColor,
                                        ),
                                        Text("Inactive",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
                                              color: AppColors.textGrey,
                                            ))
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.sp),
              width: 1.sw,
              decoration: BoxDecoration(
                  color: AppColors.primaryWhite, boxShadow: [BoxShadow(blurRadius: 10, color: AppColors.primaryBlack.withOpacity(0.3))]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: AppColors.appColor,
                    height: 5,
                    width: 1.sw,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 30, 0),
                    child: Text(
                      "Wallet".toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: AppColors.primaryBlack,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                          child: AdminCustomTextFormField(
                              title: "Name",
                              hint: "Enter name",
                              width: 0.3.sw,
                              paddingBetweenTitle: 10,
                              prefixIcon: const Icon(Icons.abc_outlined),
                              textFormIcon: InkWell(
                                child: const Icon(Icons.check_circle_outline),
                                onTap: () {
                                  if (Constant.isDemo) {
                                    DialogBox.dialogBox(
                                        context: Get.context!,
                                        title: "No Access!",
                                        description: "You have no right to add, edit and delete");
                                  } else {
                                    if (paymentController.walletNameController.value.text.isNotEmpty) {
                                      ProgressLoader.showLoadingDialog();
                                      Constant.paymentModel!.wallet!.name = paymentController.walletNameController.value.text;
                                      setPayment(Constant.paymentModel!).then((value) {
                                        Get.back();
                                        showSuccessToast("Wallet name updated");
                                      });
                                    } else {
                                      showError("Please add wallet name");
                                    }
                                  }
                                },
                              ),
                              textEditingController: paymentController.walletNameController.value),
                        ),
                      ),
                      Obx(
                        () => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Status",
                                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Radio(
                                          value: Status.active,
                                          groupValue: paymentController.isWalletActive.value,
                                          onChanged: (value) {
                                            if (Constant.isDemo) {
                                              DialogBox.dialogBox(
                                                  context: Get.context!,
                                                  title: "No Access!",
                                                  description: "You have no right to add, edit and delete");
                                            } else {
                                              paymentController.isWalletActive.value = value ?? Status.active;
                                              ProgressLoader.showLoadingDialog();
                                              Constant.paymentModel!.wallet!.enable = true;
                                              setPayment(Constant.paymentModel!).then((value) {
                                                Get.back();
                                                showSuccessToast("Wallet status updated");
                                              });
                                            }
                                          },
                                          activeColor: AppColors.appColor,
                                        ),
                                        Text("Active",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
                                              color: AppColors.textGrey,
                                            ))
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                          value: Status.inactive,
                                          groupValue: paymentController.isWalletActive.value,
                                          onChanged: (value) {
                                            if (Constant.isDemo) {
                                              DialogBox.dialogBox(
                                                  context: Get.context!,
                                                  title: "No Access!",
                                                  description: "You have no right to add, edit and delete");
                                            } else {
                                              paymentController.isWalletActive.value = value ?? Status.inactive;
                                              ProgressLoader.showLoadingDialog();
                                              Constant.paymentModel!.wallet!.enable = false;
                                              setPayment(Constant.paymentModel!).then((value) {
                                                Get.back();
                                                showSuccessToast("Wallet status updated");
                                              });
                                            }
                                          },
                                          activeColor: AppColors.appColor,
                                        ),
                                        Text("Inactive",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
                                              color: AppColors.textGrey,
                                            ))
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
