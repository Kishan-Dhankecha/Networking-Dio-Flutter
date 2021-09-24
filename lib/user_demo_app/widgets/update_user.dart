import 'package:flutter/material.dart';

import '../modals/user_info.dart';
import '../networking/dio_client.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({Key? key}) : super(key: key);

  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  late final TextEditingController _idController;
  late final TextEditingController _nameController;
  late final TextEditingController _jobController;

  final DioClient _dioClient = DioClient();

  bool isUpdating = false;

  @override
  void initState() {
    _idController = TextEditingController();
    _nameController = TextEditingController();
    _jobController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _idController,
          decoration: const InputDecoration(hintText: 'Enter ID'),
        ),
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(hintText: 'Enter name'),
        ),
        TextField(
          controller: _jobController,
          decoration: const InputDecoration(hintText: 'Enter job'),
        ),
        const SizedBox(height: 16.0),
        isUpdating
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () async {
                  setState(() => isUpdating = true);
                  if (_nameController.text != '' && _jobController.text != '') {
                    UserInfo userInfo = UserInfo(
                      name: _nameController.text,
                      job: _jobController.text,
                    );
                    UserInfo? retrievedUser = await _dioClient.updateUser(
                      userInfo: userInfo,
                      id: _idController.text,
                    );
                    if (retrievedUser != null) {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Name: ${retrievedUser.name}'),
                                  Text('Job: ${retrievedUser.job}'),
                                  Text(
                                    'Updated at: ${retrievedUser.updatedAt}',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }
                  setState(() => isUpdating = false);
                },
                child: const Text(
                  'Update user',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
      ],
    );
  }
}
