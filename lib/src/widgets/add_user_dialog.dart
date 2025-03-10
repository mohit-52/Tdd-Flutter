import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbb/main.dart';
import 'package:tbb/src/authentication/presentation/cubit/authentication_cubit.dart';

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({required this.nameController, super.key});

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'username',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final avatar =
                      'https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/283.jpg';
                  final name = nameController.text.trim();
                  context.read<AuthenticationCubit>().createUser(
                      createdAt: DateTime.now().toString(),
                      name: name,
                      avatar: avatar);
                  Navigator.of(context).pop();
                },
                child: Text('Create User'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
