import 'package:anti_social_network/common/index.dart';
import 'package:flutter/material.dart';

import '../features/login/views/sign_in/login_view.dart';

class DialogHelper {
  static void showUnauthorizedAccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Unauthorized Access'),
          content: const Text('Your session has expired. Please log in again.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
                // Redirect to the login page or perform any other necessary action
                Utils.clearToken();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void showFailedGroupCreationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create group failed'),
          content: const Text('Failed to create group.Try Again'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void showNotAMemberGroupDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('This is a private Group'),
          content: const Text('You are not a member'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
