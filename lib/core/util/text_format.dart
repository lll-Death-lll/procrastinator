import 'package:duration/duration.dart';

String cutText(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  }
  return '${text.substring(0, maxLength - 3)}...';
}

String getETA(int? eta) {
  if (eta == null) {
    return '';
  }

  var prettyTime = Duration(minutes: eta).pretty();
  var words = prettyTime.split(' ');

  StringBuffer formattedTime = StringBuffer();
  for (int i = 0; i < words.length; i++) {
    formattedTime.write(words[i]);
    if (i % 2 == 1) {
      formattedTime.write('\n');
    } else {
      formattedTime.write(' ');
    }
  }

  return 'ETA:\n$formattedTime';
}
