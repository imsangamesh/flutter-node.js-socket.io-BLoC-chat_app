import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/features/chat/widgets/info_tile.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  Text subHeading(String text) => Text(
        '● $text:',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 2,
        ),
      );

  Text body(String text) => Text(
        '— $text',
        style:
            const TextStyle(fontSize: 15, color: AppColors.grey, height: 1.2),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help!')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            /// - - - - - - - - - - - - - - - - `CHAT CONNECTION`
            InfoTile(
              title: 'Chat Connection',
              children: [
                subHeading('Server set up'),
                body(
                  'Please go to `server` directory from root directory and run `npm install` to install packages.',
                ),
                body(
                  'Run `npm start` to run and keep the server active.',
                ),
                subHeading('Install app'),
                body(
                  'Kindly assign your IP address to `ipAddress` variable in `main.dart` file.',
                ),
                body(
                  'Build & install the app in 2 different devices which should be connected to the given IP address.',
                ),
                subHeading('Start chatting'),
                body('Login with your credentials and start chatting.'),
                body(
                  'You can also `clear` the chats from clear_all button in AppBar.',
                ),
              ],
            ),

            /// - - - - - - - - - - - - - - - - `USER AUTHENTICATION`
            InfoTile(
              title: 'User Authentication',
              children: [
                subHeading('Sign Up'),
                body(
                  'User is allowed to sign up with `name`, `email` and `password`.',
                ),
                body('Implemented Validations for each field.'),
                subHeading('Sign In'),
                body(
                  'User is allowed to sign in with `email` and `password`.',
                ),
                body('Implemented Validations for each field.'),
                subHeading('Edit'),
                body(
                  'User can edit his `name`, `email` and `password` from Profile Screen.',
                ),
                subHeading('Sign Out'),
                body('User can logout from profile screen.'),
              ],
            ),

            /// - - - - - - - - - - - - - - - - `USER AUTHENTICATION`
            InfoTile(
              title: 'Others',
              children: [
                subHeading('Change Theme'),
                body('User can switch between themes as per his interest.'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
