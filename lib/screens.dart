import 'package:flutter/material.dart';
import 'package:google_maps_in_flutter/screens/card_payments/no_webhook_payment_cardform_screen.dart';
import 'package:google_maps_in_flutter/screens/regional_payment_methods/ali_pay_screen.dart';
import 'package:google_maps_in_flutter/screens/regional_payment_methods/aubecs_debit.dart';
import 'package:google_maps_in_flutter/screens/regional_payment_methods/fpx_screen.dart';
import 'package:google_maps_in_flutter/screens/regional_payment_methods/grab_pay_screen.dart';
import 'package:google_maps_in_flutter/screens/regional_payment_methods/ideal_screen.dart';
import 'package:google_maps_in_flutter/screens/regional_payment_methods/klarna_screen.dart';
import 'package:google_maps_in_flutter/screens/regional_payment_methods/paypal_screen.dart';
import 'package:google_maps_in_flutter/screens/regional_payment_methods/us_bank_account.dart';
import 'package:google_maps_in_flutter/screens/wallets/apple_pay_screen.dart';
import 'package:google_maps_in_flutter/screens/wallets/google_pay_stripe_screen.dart';
import 'package:google_maps_in_flutter/widgets/platform_icons.dart';


class ExampleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final bool expanded;

  const ExampleSection({
    Key? key,
    required this.title,
    required this.children,
    this.expanded = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
      initiallyExpanded: expanded,
      childrenPadding: EdgeInsets.only(left: 20),
      title: Text(title),
      children:
          ListTile.divideTiles(tiles: children, context: context).toList(),
    );
  }
}

class Example extends StatelessWidget {
  final String title;
  final TextStyle? style;
  final Widget? leading;
  final List<DevicePlatform> platformsSupported;

  final WidgetBuilder builder;

  Example({
    required this.title,
    required this.builder,
    this.style,
    this.leading,
    this.platformsSupported = DevicePlatform.values,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        final route = MaterialPageRoute(builder: builder);
        Navigator.push(context, route);
      },
      title: Text(title, style: style),
      leading: this.leading,
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        PlatformIcons(supported: platformsSupported),
        Icon(Icons.chevron_right_rounded),
      ]),
    );
  }

  static List<Example> paymentMethodScreens = [];

  static List<Widget> screens = [
    ExampleSection(
      title: 'Card Payments',
      children: [
        Example(
          title: 'Card Form',
          builder: (c) => NoWebhookPaymentCardFormScreen(),
          platformsSupported: [DevicePlatform.android, DevicePlatform.ios],
        ),
      ],
    ),
    ExampleSection(
      title: 'Wallets',
      children: [
        Example(
          title: 'Apple Pay',
          leading: Image.asset(
            'assets/apple_pay.png',
            width: 48,
          ),
          builder: (c) => ApplePayScreen(),
          platformsSupported: [DevicePlatform.ios],
        ),
        Example(
          leading: Image.asset(
            'assets/google_play.png',
            width: 48,
          ),
          title: 'Google Pay',
          builder: (c) => GooglePayStripeScreen(),
          platformsSupported: [DevicePlatform.android],
        ),
      ],
    ),
    ExampleSection(title: 'Regional Payment Methods', children: [
      Example(
        title: 'Ali Pay',
        leading: Image.asset(
          'assets/alipay.png',
          width: 48,
        ),
        builder: (context) => AliPayScreen(),
        platformsSupported: [DevicePlatform.android, DevicePlatform.ios],
      ),
      Example(
        title: 'Ideal',
        leading: Image.asset(
          'assets/ideal_pay.png',
          width: 48,
        ),
        builder: (context) => IdealScreen(),
        platformsSupported: [DevicePlatform.android, DevicePlatform.ios],
      ),
      Example(
        title: 'Aubecs',
        builder: (context) => AubecsExample(),
      ),
      Example(
        title: 'Fpx',
        leading: Image.asset(
          'assets/fpx.png',
          width: 48,
        ),
        builder: (contex) => FpxScreen(),
      ),
      Example(
        title: 'Grab pay',
        leading: Image.asset(
          'assets/grab_pay.png',
          width: 48,
        ),
        builder: (contex) => GrabPayScreen(),
      ),
      Example(
        title: 'Klarna',
        leading: Image.asset(
          'assets/klarna.jpg',
          width: 48,
        ),
        builder: (contex) => KlarnaScreen(),
      ),
      Example(
        title: 'PayPal',
        leading: Image.asset(
          'assets/paypal.png',
          width: 48,
        ),
        builder: (contex) => PayPalScreen(),
        platformsSupported: [DevicePlatform.android, DevicePlatform.ios],
      ),
      Example(
        title: 'Us bank accounts (ACH)',
        builder: (contex) => UsBankAccountScreen(),
      ),
    ]),
  ];
}
