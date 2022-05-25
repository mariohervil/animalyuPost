import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_in_flutter/config.dart';
import 'package:google_maps_in_flutter/widgets/pay_screen.dart';
// import 'package:pay/pay.dart' as pay;

// const _paymentItems = [
//   pay.PaymentItem(
//     label: 'Total',
//     amount: '0.01',
//     status: pay.PaymentItemStatus.final_price,
//   )
// ];

class ApplePayExternalPluginScreen extends StatefulWidget {
  @override
  _ApplePayExternalPluginScreenState createState() =>
      _ApplePayExternalPluginScreenState();
}

class _ApplePayExternalPluginScreenState
    extends State<ApplePayExternalPluginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      title: 'Apple Pay',
      padding: EdgeInsets.all(16),
      tags: ['iOS', 'Pay plugin'],
      children: [
        SizedBox(
          child: Text(
              'Pay is temporaliy disabled because of https://github.com/google-pay/flutter-plugin/issues/126'),
        )
        // pay.ApplePayButton(
        //   paymentConfigurationAsset: 'apple_pay_payment_profile.json',
        //   paymentItems: _paymentItems,
        //   margin: const EdgeInsets.only(top: 15),
        //   onPaymentResult: onApplePayResult,
        //   loadingIndicator: const Center(
        //     child: CircularProgressIndicator(),
        //   ),
        //   childOnError: Text('Apple Pay is not available in this device'),
        //   onError: (e) {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       const SnackBar(
        //         content: Text(
        //             'There was an error while trying to perform the payment'),
        //       ),
        //     );
        //   },
        // ),
      ],
    );
  }

  Future<void> onApplePayResult(paymentResult) async {
    try {
      //debugPrint(paymentResult.toString());
      // 1. Get Stripe token from payment result
      final token = await Stripe.instance.createApplePayToken(paymentResult);

      // 2. fetch Intent Client Secret from backend
      final response = await fetchPaymentIntentClientSecret();
      final clientSecret = response['clientSecret'];

      final params = PaymentMethodParams.cardFromToken(
        paymentMethodData: PaymentMethodDataCardFromToken(
          token: token.id,
        ),
      );

      // 3. Confirm Apple pay payment method
      await Stripe.instance.confirmPayment(clientSecret, params);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Apple Pay payment succesfully completed')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<Map<String, dynamic>> fetchPaymentIntentClientSecret() async {
    final url = Uri.parse('$kApiUrl/create-payment-intent');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': 'example@gmail.com',
        'currency': 'usd',
        'items': [
          {'id': 'id'}
        ],
        'request_three_d_secure': 'any',
      }),
    );
    return json.decode(response.body);
  }
}
