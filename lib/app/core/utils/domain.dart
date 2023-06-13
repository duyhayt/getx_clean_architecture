abstract class Domain {
  // static String enPoint = "http://192.168.1.28";
  // static String port = "23000";
  static String enPoint = "http://103.252.1.145";
  static String port = "23000";

  static String getBaseUrl() {
    if (port.isNotEmpty) {
      return '$enPoint:$port';
    }
    return enPoint;
  }
}
