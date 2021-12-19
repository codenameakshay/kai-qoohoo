import 'package:flutter/material.dart';
import 'package:kai/controllers/timer_controller.dart';
import 'package:provider/provider.dart';

class RecordDuration extends StatelessWidget {
  const RecordDuration({
    Key? key,
  }) : super(key: key);
  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }

    return numberStr;
  }

  @override
  Widget build(BuildContext context) {
    final TimerController _timerController =
        Provider.of<TimerController>(context);
    return Card(
      margin: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: _timerController.recordDuration == 0 ? 48 : 16),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          height: 60,
          child: _timerController.recordDuration == 0
              ? Center(
                  child: Text(
                    'Tap and hold to record audio',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                )
              : Text(
                  '${_formatNumber(_timerController.recordDuration ~/ 60)}:${_formatNumber(_timerController.recordDuration % 60)}',
                  style: Theme.of(context).textTheme.headline2,
                ),
        ),
      ),
    );
  }
}
