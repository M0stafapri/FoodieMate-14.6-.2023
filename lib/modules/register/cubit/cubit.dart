import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/register/cubit/states.dart';

import '../../../models/trainer_model.dart';
import '../../../models/user_model.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  bool outLineBorder = true;
  var selectedUserType;
  var selectedProgram;

  IconData suffix = Icons.visibility;
  bool isPassword = true;
  void userRegister({
    required String email,
    required String name,
    required String password,
    required String phone,
    required bodyType,
    required userType,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      if (userType == 'User') {
        userCreate(
          uId: value.user!.uid,
          email: email,
          name: name,
          phone: phone,
          bodyType: bodyType,
          userType: userType,
        );
      } else {
        trainerCreate(
          uId: value.user!.uid,
          email: email,
          name: name,
          phone: phone,
          userType: userType,
        );
      }
      emit(RegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
    required bodyType,
    required userType,
  }) {
    var model = UserModel(
      email: email,
      phone: phone,
      name: name,
      uId: uId,
      bodyType: bodyType,
      userType: userType,
      cover:
          'https://www.upload.ee/image/15319380/emergency.png',
      image: userType == 'Trainer'
          ? 'ttps://toppng.com/uploads/preview/instagram-default-profile-picture-11562973083brycehrmyv.png'
          : 'https://toppng.com/uploads/preview/instagram-default-profile-picture-11562973083brycehrmyv.png',
      location: null,
      lat: null,
      long: null,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreateUserErrorState(error.toString()));
    });
  }

  void trainerCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
    required userType,
  }) {
    var model = TrainerModel(
      email: email,
      phone: phone,
      name: name,
      uId: uId,
      userType: userType,
      cover:
          'https://www.upload.ee/image/15319380/emergency.png',
      image: userType == 'Trainer'
          ? 'https://toppng.com/uploads/preview/instagram-default-profile-picture-11562973083brycehrmyv.png'
          : 'https://toppng.com/uploads/preview/instagram-default-profile-picture-11562973083brycehrmyv.png',
      location: null,
      lat: null,
      long: null,
      FirstProgram: null,
      SecondProgram: null,
      ThirdProgram: null,
      FourthProgram: null,
      FifthProgram: null,
      SixthProgram: null,
      SeventhProgram: null,
      EighthProgram: null,
    );
    FirebaseFirestore.instance
        .collection('trainers')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreateUserErrorState(error.toString()));
    });
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    isPassword ? suffix = Icons.visibility : suffix = Icons.visibility_off;
    emit(ChangeRegisterPasswordVisibilityState());
  }

  void changeUserType(value) {
    selectedUserType = value;
    emit(changeUserTypeState());
  }
}
