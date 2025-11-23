import 'dart:isolate';
import 'dart:math';

void main() async {
  final receivePort = ReceivePort();
  await Isolate.spawn(randomNumberGenerator, receivePort.sendPort);

  int sum = 0;

  await for (var message in receivePort) {
    if (message is int) {
      sum += message;
      print("Nhận số: $message — Tổng hiện tại: $sum");

      if (sum > 100) {
        print("Tổng vượt 100 → gửi lệnh dừng isolate...");
        messagePort?.send("STOP");
      }
    } else if (message is SendPort) {
      messagePort = message;
    } else if (message == "DONE") {
      print("Isolate đã dừng!");
      receivePort.close();
      break;
    }
  }
}

SendPort? messagePort;

void randomNumberGenerator(SendPort mainSendPort) async {
  final port = ReceivePort();

  mainSendPort.send(port.sendPort);

  final random = Random();

  await for (var msg in port) {
    if (msg == "STOP") {
      mainSendPort.send("DONE");
      Isolate.exit();
    } else {
      int num = random.nextInt(20) + 1;
      mainSendPort.send(num);
      await Future.delayed(Duration(seconds: 1));
    }
  }
}
