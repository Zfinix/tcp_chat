class TCPData {
  String ip,name;
  int port;

  TCPData({this.ip, this.port, this.name});

  TCPData.fromJson(Map<String, dynamic> json) {
    ip = json['ip'];
    port = json['port'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ip'] = this.ip;
    data['port'] = this.port;
    data['name'] = this.name;
    return data;
  }
}
