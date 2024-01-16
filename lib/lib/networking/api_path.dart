
class APIEndPoints {
  /// ASN URL
  static String asnBetaUrl = '';
  static String asnUrl = 'http://ec2-18-191-6-94.us-east-2.compute.amazonaws.com';

  ///user endpoints
  static String login = "/user/login";
  static String register = "/user/register";
  static String logout = "/user/logout";

  /// profile endpoints
  static String getMyProfile = "/profile/me";
  static String getUserProfile = "/profile/user";
  static String editEmails = "/profile/edit/emails";
  static String editAddresses = "/profile/edit/addresses";
  static String editSocials = "/profile/edit/socials";
  static String editPhones = "/profile/edit/phones";
  static String editBio = "/profile/edit/bio";
  static String editPhoto = "/profile/edit/photo";

  /// favorite endpoints
  static String addFavorite = "/favorite/add";
  static String removeFavorite = "/favorite/remove";
  static String listFavorite = "/favorite/list";

  /// contact endpoints
  static String listDirectoryContacts = "/contact/list";

  /// request endpoints
  static String addRequest = "/request/add";
  static String removeRequest = "/request/remove";
  static String listSentRequests = "/request/sent/list";
  static String listReceivedRequests = "/request/received/list";

  /// groups endpoints
  static String listGroups ="/group/list";
  static String addGroup = "/group/add";
  static String listMembers = "/group/list-members";
  /// preset endpoints
  static String addPreset = "/preset/add";
  static String listPreset = "/preset/list";

  /// map endpoints
  static String addLocation = "/location/add";
  static String listLocations = "/location/nearby/list";


}
