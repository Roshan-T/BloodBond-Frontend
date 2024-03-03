import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

Future<void> sendEmail(String to, String subject, String text) async {
  final smtpServer = SmtpServer('smtp.gmail.com',
      username: 'bloodbond77@gmail.com', password: 'xtet ihzb rgyi pgdm');

  final message = Message()
    ..from = Address('ccrrizal@gmail.com', 'BloodBond')
    ..recipients.add(to)
    ..subject = subject
    ..text = text;

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ${sendReport}');
    // Additional code for feedback to the user
  } catch (e) {
    print('Error occurred while sending email: $e');
    // Additional code for error handling
  }
}

Future<void> sendOtpEmail(String email, String otp) async {
  final subject = 'BloodBond Password Reset Request';
  final text = """
Dear customer,

You've requested to reset your BloodBond password. Here's your one-time password:

${otp}

Use this code to reset your password within the next 10 minutes. If you didn't make this request, please ignore this message.

Stay secure,
BloodBond Team   
""";

  await sendEmail(email, subject, text);
}
