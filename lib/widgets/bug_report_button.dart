import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kai/services/logger_service.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:device_info_plus/device_info_plus.dart';

class BugReportButton extends StatelessWidget {
  const BugReportButton({
    Key? key,
    required this.darkAppBarContents,
  }) : super(key: key);

  final bool darkAppBarContents;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: reportBug,
      icon: const Icon(Icons.bug_report),
      color: darkAppBarContents
          ? Theme.of(context).bottomNavigationBarTheme.unselectedItemColor
          : Theme.of(context).appBarTheme.titleTextStyle?.color,
    );
  }

  reportBug() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final release = androidInfo.version.release;
      final sdkInt = androidInfo.version.sdkInt;
      final manufacturer = androidInfo.manufacturer;
      final model = androidInfo.model;
      logger.d('Android $release (SDK $sdkInt), $manufacturer $model');
      final String zipPath = await zipLogs();
      final MailOptions mailOptions = MailOptions(
        body:
            '----x-x-x----<br>Device info -<br><br>Android version: Android $release<br>SDK Number: SDK $sdkInt<br>Device Manufacturer: $manufacturer<br>Device Model: $model<br>----x-x-x----<br><br>Enter the bug/issue below -<br><br>',
        subject: '[BUG REPORT::${"kai".toUpperCase()}]',
        recipients: ["akshaymaurya3006@gmail.com"],
        isHTML: true,
        attachments: [
          zipPath,
        ],
        appSchema: 'com.google.android.gm',
      );
      final MailerResponse response = await FlutterMailer.send(mailOptions);
      if (response != MailerResponse.android) {
        final MailOptions mailOptions = MailOptions(
          body:
              '----x-x-x----<br>Device info -<br><br>Android version: Android $release<br>SDK Number: SDK $sdkInt<br>Device Manufacturer: $manufacturer<br>Device Model: $model<br>----x-x-x----<br><br>Enter the bug/issue below -<br><br>',
          subject: '[BUG REPORT::${"kai".toUpperCase()}]',
          recipients: ["akshaymaurya3006@gmail.com"],
          isHTML: true,
          attachments: [
            zipPath,
          ],
        );
        await FlutterMailer.send(mailOptions);
      } else {
        logger.i("Bug Report sent!");
      }
    } else if (Platform.isIOS) {
      final iOSInfo = await DeviceInfoPlugin().iosInfo;
      final systemName = iOSInfo.systemName;
      final systemVersion = iOSInfo.systemVersion;
      final name = iOSInfo.name;
      final model = iOSInfo.model;
      logger.d(
          'SystemName $systemName (SystemVersion $systemVersion), $name $model');
      final String zipPath = await zipLogs();
      final MailOptions mailOptions = MailOptions(
        body:
            '----x-x-x----<br>Device info -<br><br>iOS version: iOS $systemName<br>SystemVersion: $systemVersion<br>Device Name: $name<br>Device Model: $model<br>----x-x-x----<br><br>Enter the bug/issue below -<br><br>',
        subject: '[BUG REPORT::${"kai".toUpperCase()}]',
        recipients: ["akshaymaurya3006@gmail.com"],
        isHTML: true,
        attachments: [
          zipPath,
        ],
      );
      final MailerResponse response = await FlutterMailer.send(mailOptions);
      if (response != MailerResponse.sent) {
        final MailOptions mailOptions = MailOptions(
          body:
              '----x-x-x----<br>Device info -<br><br>iOS version: iOS $systemName<br>SystemVersion: $systemVersion<br>Device Name: $name<br>Device Model: $model<br>----x-x-x----<br><br>Enter the bug/issue below -<br><br>',
          subject: '[BUG REPORT::${"kai".toUpperCase()}]',
          recipients: ["akshaymaurya3006@gmail.com"],
          isHTML: true,
          attachments: [
            zipPath,
          ],
        );
        await FlutterMailer.send(mailOptions);
      } else {
        logger.i("Bug Report sent!");
      }
    }
  }
}
