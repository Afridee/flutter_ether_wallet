import 'package:intl/intl.dart';

String TimeStampToDate(int millis){
  var dt = DateTime.fromMillisecondsSinceEpoch(millis);
  var d12 = DateFormat('MM/dd/yyyy, hh:mm a').format(dt);

  return d12.toString();
}