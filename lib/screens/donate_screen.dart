import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rahgosha/common/theme.dart';
import 'package:rahgosha/utils/custom_snackbar.dart';
import 'package:rahgosha/utils/providers.dart';

class DonateScreen extends StatelessWidget {
  const DonateScreen({super.key});

  Stack _buildStackedTetherImage(String network) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          "assets/images/crypto-logos/usdt-logo.png",
          width: 30,
          height: 30,
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Image.asset(
            "assets/images/crypto-logos/$network-logo.png",
            width: 12,
            height: 12,
          ),
        ),
      ],
    );
  }




Future<void> _loadAssets(BuildContext context) async {
    await Future.wait([
      precacheImage(AssetImage('assets/images/app-logo.png'), context),
      precacheImage(AssetImage('assets/images/crypto-logos/usdt-logo.png'), context),
      precacheImage(AssetImage('assets/images/crypto-logos/toncoin-logo.png'), context),
      precacheImage(AssetImage('assets/images/crypto-logos/bnb-logo.png'), context),
      precacheImage(AssetImage('assets/images/crypto-logos/litecoin-logo.png'), context),
      precacheImage(AssetImage('assets/images/crypto-logos/bitcoin-logo.png'), context),
      precacheImage(AssetImage('assets/images/crypto-logos/ethereum-logo.png'), context),
      precacheImage(AssetImage('assets/images/crypto-logos/tron-logo.png'), context),
      precacheImage(AssetImage('assets/images/crypto-logos/solana-logo.png'), context),
      precacheImage(AssetImage('assets/images/crypto-logos/SOL-logo.png'), context),
      precacheImage(AssetImage('assets/images/crypto-logos/ETH-logo.png'), context),
      precacheImage(AssetImage('assets/images/crypto-logos/TRX-logo.png'), context),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeColors themeColors = context.watch<ThemeProvider>().getColors(context);
    return FutureBuilder<void>(
      future: _loadAssets(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: themeColors.backgroundColor,
            body: Center(
              child: CircularProgressIndicator(
                color: themeColors.enabledColor,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: themeColors.backgroundColor,
            body: Center(
              child: Text(
                "errors.error".tr(
                  args: [snapshot.error.toString()]
                )
              ),
            ),
          );
        } else {
          
          return _buildDonateScreen(context);
        }
      },
    );
  }

  Widget _buildDonateScreen(BuildContext context) {
    const String tonWallet = "UQDmIZGMq28wMkicYRqavkE15FBMCVlu1Bofih7NdzbHnKcu";
    const String bnbWallet = "0xDbE82d5D542a8646EA124916F110f4c3583A7a2D";
    const String ltcWallet = "ltc1q0l2ycl9k5fzk3w458srh2acvwhy3txgeqf0fm5";
    const String btcWallet = "bc1qsgdav6mcsguxljc3sntnycqzt9ucntn6xhsd4f";
    const String ethWallet = "0xDbE82d5D542a8646EA124916F110f4c3583A7a2D";
    const String trxWallet = "TAVPaGwUJDvtiDiG582z7RAE5HGtbDyzRa";
    const String solWallet = "TAVPaGwUJDvtiDiG582z7RAE5HGtbDyzRa";
    const String usdtBnbWallet = "0xDbE82d5D542a8646EA124916F110f4c3583A7a2D";
    const String usdtEthWallet = "0xDbE82d5D542a8646EA124916F110f4c3583A7a2D";
    const String usdtTrxWallet = "TAVPaGwUJDvtiDiG582z7RAE5HGtbDyzRa";
    const String usdtSolWallet = "TAVPaGwUJDvtiDiG582z7RAE5HGtbDyzRa";
    final ThemeColors themeColors = context.watch<ThemeProvider>().getColors(context);


    final TextStyle textStyle = TextStyle(
      color: themeColors.secondaryTextColor,
      fontFamily: "Vazirmatn"
    );


    return Scaffold(
      backgroundColor: themeColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          "screens.donate.title".tr(),
          style: TextStyle(
            color: themeColors.secondaryTextColor,
            fontFamily: "Vazirmatn",
          ),
        ),
        iconTheme: IconThemeData(
          color: themeColors.secondaryTextColor
        ),
        backgroundColor: themeColors.secondaryBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/app-logo.png'),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            const SizedBox(height: 16),
            Text(
              "screens.donate.info".tr(),
              textAlign: TextAlign.center,
              style: textStyle
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  // TON Wallet
                  ListTile(
                    leading: Image.asset(
                      "assets/images/crypto-logos/toncoin-logo.png",
                      width: 30,
                      height: 30,
                    ),
                    title: Text(
                      "screens.donate.wallets.ton".tr(),
                      style: textStyle,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(
                          const ClipboardData(text: tonWallet),
                        );
                        CustomSnackBar.show(
                          context, 
                          "general.copied_message".tr(
                            args: ["screens.donate.wallets.ton".tr()]
                          ),
                          SnackBarType.info 
                        );
                      },
                    ),
                  ),
                  // BNB Wallet
                  ListTile(
                    leading: Image.asset(
                      "assets/images/crypto-logos/bnb-logo.png",
                      width: 30,
                      height: 30,
                    ),
                    title: Text(
                      "screens.donate.wallets.bnb".tr(),
                      style: textStyle,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(
                          const ClipboardData(text: bnbWallet),
                        );
                        CustomSnackBar.show(
                          context, 
                          "general.copied_message".tr(
                            args: ["screens.donate.wallets.bnb".tr()]
                          ),
                          SnackBarType.info 
                        );
                      },
                    ),
                  ),
                  // Litecoin Wallet
                  ListTile(
                    leading: Image.asset(
                      "assets/images/crypto-logos/litecoin-logo.png",
                      width: 30,
                      height: 30,
                    ),
                    title: Text(
                      "screens.donate.wallets.ltc".tr(),
                      style: textStyle,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(
                          const ClipboardData(text: ltcWallet),
                        );
                        CustomSnackBar.show(
                          context, 
                          "general.copied_message".tr(
                            args: ["screens.donate.wallets.ltc".tr()]
                          ),
                          SnackBarType.info 
                        );
                      },
                    ),
                  ),
                  // Bitcoin Wallet
                  ListTile(
                    leading: Image.asset(
                      "assets/images/crypto-logos/bitcoin-logo.png",
                      width: 30,
                      height: 30,
                    ),
                    title: Text(
                      "screens.donate.wallets.btc".tr(),
                      style: textStyle,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(
                          const ClipboardData(text: btcWallet),
                        );
                        CustomSnackBar.show(
                          context, 
                          "general.copied_message".tr(
                            args: ["screens.donate.wallets.btc".tr()]
                          ),
                          SnackBarType.info 
                        );
                      },
                    ),
                  ),
                  // Ethereum Wallet
                  ListTile(
                    leading: Image.asset(
                      "assets/images/crypto-logos/ethereum-logo.png",
                      width: 30,
                      height: 30,
                    ),
                    title: Text(
                      "screens.donate.wallets.eth".tr(),
                      style: textStyle,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(
                          const ClipboardData(text: ethWallet),
                        );
                        CustomSnackBar.show(
                          context, 
                          "general.copied_message".tr(
                            args: ["screens.donate.wallets.eth".tr()]
                          ),
                          SnackBarType.info 
                        );
                      },
                    ),
                  ),
                  // TRX Wallet
                  ListTile(
                    leading: Image.asset(
                      "assets/images/crypto-logos/tron-logo.png",
                      width: 30,
                      height: 30,
                    ),
                    title: Text(
                      "screens.donate.wallets.trx".tr(),
                      style: textStyle,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(
                          const ClipboardData(text: trxWallet),
                        );
                        CustomSnackBar.show(
                          context, 
                          "general.copied_message".tr(
                            args: ["screens.donate.wallets.trx".tr()]
                          ),
                          SnackBarType.info 
                        );
                      },
                    ),
                  ),
                  // SOL Wallet
                  ListTile(
                    leading: Image.asset(
                      "assets/images/crypto-logos/solana-logo.png",
                      width: 30,
                      height: 30,
                    ),
                    title: Text(
                      "screens.donate.wallets.sol".tr(),
                      style: textStyle,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(
                          const ClipboardData(text: solWallet),
                        );
                        CustomSnackBar.show(
                          context, 
                          "general.copied_message".tr(
                            args: ["screens.donate.wallets.sol".tr()]
                          ),
                          SnackBarType.info 
                        );
                      },
                    ),
                  ),
                  ExpansionTile(
                    backgroundColor: themeColors.backgroundColor,
                    collapsedBackgroundColor: themeColors.backgroundColor,
                    shape: Border(),
                    iconColor: themeColors.enabledColor,
                    leading: Image.asset(
                      "assets/images/crypto-logos/usdt-logo.png",
                      width: 30,
                      height: 30,
                    ),
                    title: Text(
                      "screens.donate.wallets.usdt".tr(),
                      style: textStyle,
                    ),
                    children: [
                     
                      // USDT for BNB
                      ListTile(
                        leading: _buildStackedTetherImage("bnb"),
                        title: Text(
                          "screens.donate.wallets.usdt_bnb".tr(),
                          style: textStyle,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            Clipboard.setData(
                              const ClipboardData(text: usdtBnbWallet),
                            );
                            CustomSnackBar.show(
                              context, 
                              "general.copied_message".tr(
                                args: ["screens.donate.wallets.usdt_bnb".tr()]
                              ),
                              SnackBarType.info 
                            );
                          },
                        ),
                      ),
                      // USDT for Ethereum
                      ListTile(
                        leading: _buildStackedTetherImage("ETH"),
                        title: Text(
                          "screens.donate.wallets.usdt_eth".tr(),
                          style: textStyle,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            Clipboard.setData(
                              const ClipboardData(text: usdtEthWallet),
                            );
                            CustomSnackBar.show(
                              context, 
                              "general.copied_message".tr(
                                args: ["screens.donate.wallets.usdt_eth".tr()]
                              ),
                              SnackBarType.info 
                            );
                          },
                        ),
                      ),
                      // USDT for TRX
                      ListTile(
                        leading: _buildStackedTetherImage("TRX"),
                        title: Text(
                          "screens.donate.wallets.usdt_trx".tr(),
                          style: textStyle,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            Clipboard.setData(
                              const ClipboardData(text: usdtTrxWallet),
                            );
                            CustomSnackBar.show(
                              context, 
                              "general.copied_message".tr(
                                args: ["screens.donate.wallets.usdt_trx".tr()]
                              ),
                              SnackBarType.info 
                            );
                          },
                        ),
                      ),
                      // USDT for SOL
                      ListTile(
                        leading: _buildStackedTetherImage("SOL"),
                        title: Text(
                          "screens.donate.wallets.usdt_sol".tr(),
                          style: textStyle,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            Clipboard.setData(
                              const ClipboardData(text: usdtSolWallet),
                            );
                            CustomSnackBar.show(
                              context, 
                              "general.copied_message".tr(
                                args: ["screens.donate.wallets.usdt_sol".tr()]
                              ),
                              SnackBarType.info 
                            );
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

