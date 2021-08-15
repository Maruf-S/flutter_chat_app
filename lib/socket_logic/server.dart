import 'dart:io';

import 'dart:typed_data';

class ServerFSocket {

  ServerFSocket._privateConstructor();

  static final ServerFSocket _instance = ServerFSocket._privateConstructor();

  bool connected = false;
  String _host = "192.168.10.63";
  static int _port = 10007;
  static ServerSocket? _serverSocket;
  static Socket? _socketSample;
  factory ServerFSocket() {
    return _instance;
  }

  //CALL DIS FIRST
  static createSocket() async {
    _serverSocket = await ServerSocket.bind(InternetAddress.anyIPv4, _port, shared: true, v6Only: false);
    print("object:$_serverSocket");
  }
  static startListening(){
    _serverSocket!.listen((client) {
      _handleListen(client);
    });
  }
  static sendMessage(String text){
    _socketSample!.write(text);
  }
  static _handleListen(Socket client) {
    _socketSample = client;
    print("client ip:${client.address}");
    print("client port:${client.port}");
    print("client remoteAddress:${client.remoteAddress}");
    print("client remotePort:${client.remotePort}");
    client.listen(
          (Uint8List data) {
        var message = String.fromCharCodes(data);
        if (message != "h**eart||hear**t||hear**t") {
          message = message.substring(13);
          message = message.substring(0,message.length-2);
          print(message);
          //RECIVED MESSAGE
        }
      },
      onError: (error) {
        print("error:$error");
        client.close();
      },
      onDone: (){
        client.close();
      },
    );
  }
}