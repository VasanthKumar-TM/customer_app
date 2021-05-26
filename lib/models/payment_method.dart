import 'dart:ui';

import 'package:customer_app/values/values.dart';

class PaymentMethod {
  const PaymentMethod({this.name, this.icon, this.color});

  final String name;
  final String icon;
  final Color color;
}

List<PaymentMethod> defaultPaymentMethods() => [
      PaymentMethod(
          name: 'Cash on Delivery',
          icon: 'credit_card',
          color: AppColors.orange),
      PaymentMethod(name: 'GPay', icon: 'gpay', color: AppColors.pink),
      PaymentMethod(name: 'Paypal', icon: 'paypal', color: AppColors.blue100),
    ];
