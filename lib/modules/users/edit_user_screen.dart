import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/user_model.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/styles/colors.dart';

class EditUserScreen extends StatelessWidget {
  List<UserModel> users = [];

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = AppCubit.get(context).userModel;
        var profileImage =AppCubit.get(context).profileImage;
        var coverImage =AppCubit.get(context).coverImage;
        nameController.text=AppCubit.get(context).userModel!.name!;
        phoneController.text=AppCubit.get(context).userModel!.phone!;
        locationController.text=AppCubit.get(context).userModel!.location??'';

        var selectedProgram=AppCubit.get(context).userModel!.userType !='Trainer'? AppCubit.get(context).userModel!.bodyType :null;
        return Scaffold(
          appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                  )),
              title: Text('Edit Users [ADMIN]'),
              actions: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(end:15),
                  child: TextButton(
                    onPressed: (){
                      if(AppCubit.get(context).userModel.userType!='Trainer')
                        {
                          AppCubit.get(context).updateUser(
                            name: nameController.text,
                            phone:phoneController.text,
                            location:locationController.text,
                            bodyType:selectedProgram??'null',
                          );
                        }
                      else
                        {
                          AppCubit.get(context).updateTrainer(
                            name: nameController.text,
                            phone:phoneController.text,
                            location:locationController.text,

                          );
                        }

                    },
                    child: Text(
                          'Update',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: defaultColor,
                          ),
                  ),
                  ),
                )
              ]
          ),
          body: SingleChildScrollView  (
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is AppUserUpdateProfileLoadingState || state is AppUserUpdateCoverLoadingState)
                    LinearProgressIndicator(),
                  if(state is AppUserUpdateProfileLoadingState || state is AppUserUpdateCoverLoadingState)
                    SizedBox(
                    height: 5,
                    ),
                  Container(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Container(
                                height: 140,
                                width:double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4)
                                  ),
                                  image:DecorationImage(image: coverImage==null? NetworkImage(userModel!.cover??'',): Image.file(coverImage).image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: (){
                                    AppCubit.get(context).getCoverImage();
                                  },
                                  icon: CircleAvatar(
                                      backgroundColor: defaultColor?.withOpacity(0.2),
                                      radius: 40,
                                      child: Icon(
                                         Icons.camera_alt,
                                         size: 25,
                                         color: Colors.white,
                                      )),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                backgroundImage: profileImage==null ? NetworkImage(userModel!.image??''): Image.file(profileImage).image ,
                                radius: 60,
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                AppCubit.get(context).getProfileImage();
                              },
                              icon: CircleAvatar(
                                  backgroundColor: defaultColor?.withOpacity(0.2),
                                  radius: 40,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 25,
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if(AppCubit.get(context).profileImage!=null || AppCubit.get(context).coverImage!=null)
                  Row(
                    children: [
                      if(AppCubit.get(context).coverImage!=null)
                      Expanded(
                        child: Column(
                          children: [
                            defaultButton(function: (){
                              if(AppCubit.get(context).userModel!.userType!='Trainer')
                                {
                                  AppCubit.get(context).uploadCoverImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    
                                  );
                                }
                              else
                                {
                                  AppCubit.get(context).uploadCoverImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                  );
                                }

                            },
                              text: 'Upload cover',
                              isUppercase: false,
                            ),
                            if(state is AppUserUpdateCoverLoadingState)
                              SizedBox(
                              height: 5,
                            ),
                            if(state is AppUserUpdateCoverLoadingState)
                              LinearProgressIndicator(),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if(AppCubit.get(context).profileImage!=null)
                      Expanded(
                        child: Column(
                          children: [
                            defaultButton(function: (){
                              if(AppCubit.get(context).userModel!.userType!='Trainer')
                                {
                                  AppCubit.get(context).uploadProfileImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              else
                                {
                                  AppCubit.get(context).uploadProfileImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                  );
                                }

                            },
                              text: 'Upload profile',
                              isUppercase: false,
                            ),
                            if(state is AppUserUpdateProfileLoadingState)
                            SizedBox(
                              height: 5,
                            ),
                            if(state is AppUserUpdateProfileLoadingState)
                              LinearProgressIndicator(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if(AppCubit.get(context).profileImage!=null || AppCubit.get(context).coverImage!=null)
                    SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (value){
                        if(value.isEmpty) {
                          return 'Name must not be empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix: Icon(
                        Icons.person,
                      )
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (value){
                        if(value.isEmpty) {
                          return 'Phone must not be empty';
                        }
                        return null;
                      },
                      label: 'Phone',
                      prefix: Icon(
                        Icons.call,
                      )
                  ),   SizedBox(
                    height: 15,
                  ),              
                  defaultFormField(
                      controller: locationController,
                      type: TextInputType.text,
                      validate: (value){
                        if(value.isEmpty) {
                          return 'Location must not be empty';
                        }
                        return null;
                      },
                      label: 'Location',
                      prefix: Icon(
                        Icons.location_on,
                      )
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if(AppCubit.get(context).userModel!.userType!='Trainer')
                  DropdownButtonFormField<String>(
                    hint: Text('Choose your Program'),
                    value: selectedProgram,
                    items: ['Lose Weight', 'Gain Weight', 'Maintain Weight', 'Gain Muscle', 'Modify my diet', 'Increase Step Count', 'Get Shredded', 'Increase Strength']
                        .map((e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    )).toList(),
                    onChanged: (value){
                      print(value);
                      selectedProgram =value!;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder:OutlineInputBorder(
                          borderSide: BorderSide(
                            color:  Color.fromARGB(255,157, 7, 89),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0)) ,
                          disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:  Color.fromARGB(255,157, 7, 89),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0)),
                          focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:  Color.fromARGB(255,157, 7, 89),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                  ),
                  if(AppCubit.get(context).userModel.userType=='Trainer')
                    Column(

              ),
            ]),
          ),
        ));
      },
    );
  }
}
