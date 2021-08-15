// bool connected = false;
// String _host = "192.168.10.63";
// int _port = 10007;
import 'package:flutter_socket_plugin/flutter_socket_plugin.dart';
class ClientFSocket {
  static FlutterSocket? flutterSocket;
  bool connected = false;
  String _host = "192.168.10.63";
  int _port = 10007;
  String receiveMessage = "";

  ClientFSocket._privateConstructor();

  static final ClientFSocket _instance = ClientFSocket._privateConstructor();

  factory ClientFSocket() {
    initSocket();
    return _instance;
  }
  static initSocket() {

    /// init socket
    flutterSocket = FlutterSocket();

    /// listen connect callback
    flutterSocket!.connectListener((data){
      print("connect listener data:$data");
    });

    /// listen error callback
    flutterSocket!.errorListener((data){
      print("error listener data:$data");
    });

    /// listen receive callback
    flutterSocket!.receiveListener((data){
      print("receive listener data:$data");
      if (data != null) {
        // receiveMessage = receiveMessage + "\n" + data;
      }
    });

    /// listen disconnect callback
    flutterSocket!.disconnectListener((data){
      print("disconnect listener data:$data");
    });
  }
  Future<void> createSocket(String host) async {
    //port is default
    var x = await flutterSocket!.createSocket(host, _port, timeout: 20);

  }
  Future<void> tryConnect() async {
    //port is default
    var x = flutterSocket!.tryConnect();
    print("THIS IS "+ x.toString());

  }
  Future<void> tryDisconnect() async{
    flutterSocket!.tryDisconnect();
  }
  Future<void> sendMessage(String text)async {
    await flutterSocket!.send(text);
  }


}