
var url = "http://192.168.43.137:8007/";
class BaseUrl {
  static String login = "$url"+"login/login.php";
  static String register = "$url"+"login/register.php";
  static String tambahProduk = "$url"+"login/addProduk.php";
  static String lihatProduk = "$url"+"login/lihatProduk.php";
  static String editProduk = "$url"+"login/editProduk.php";
  static String deleteProduk = "$url"+"login/deleteProduk.php";
  static String getChat = "$url"+"login/getChat.php";
  static String sendChat = "$url"+"login/addMessage.php";
  static String sendFcm = "$url"+"login/send.php";
}

class GlobalVar {
  static String homeScreenText = "";
  static String getIdUser = "";
}
