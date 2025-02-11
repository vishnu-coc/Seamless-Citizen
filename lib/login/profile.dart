import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  const Text(
                    "Your Account",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text("Account Center"),
                    subtitle:
                        const Text("Password, security, personal details"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Stay Informed & Get Involved",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.newspaper), // Icon on the left
                    title: const Text("News and Updates"),
                    trailing: const Icon(
                        Icons.arrow_forward_ios), // Icon on the right
                    onTap: () {
                      // Add the functionality to log out from the account
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.people), // Icon on the left
                    title: const Text("Communities"),
                    trailing: const Icon(
                        Icons.arrow_forward_ios), // Icon on the right
                    onTap: () {
                      // Add the functionality to log out from the account
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                        Icons.volunteer_activism), // Icon on the left
                    title: const Text("Become a Volunteer"),
                    trailing: const Icon(
                        Icons.arrow_forward_ios), // Icon on the right
                    onTap: () {
                      // Add the functionality to log out from the account
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Your Activity at a Glance",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.assessment), // Icon on the left
                    title: const Text("Activity Overview"),
                    subtitle: const Text(
                        "Number of issues submitted, issues resolved"),
                    trailing: const Icon(
                        Icons.arrow_forward_ios), // Icon on the right
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings), // Icon on the left
                    title: const Text("Settings"),
                    subtitle: const Text("Notification, Language"),
                    trailing: const Icon(
                        Icons.arrow_forward_ios), // Icon on the right
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.info), // Icon on the left
                    title: const Text("About"),
                    subtitle:
                        const Text("Privacy Policy, Terms and Conditions"),
                    trailing: const Icon(
                        Icons.arrow_forward_ios), // Icon on the right
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout), // Icon on the left
                    title: const Text("Logout"),
                    subtitle: const Text("Sign out accounts"),
                    trailing: const Icon(
                        Icons.arrow_forward_ios), // Icon on the right
                    onTap: () {
                      // Add the functionality to log out from all accounts
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
