import 'dart:collection';
import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graduation_project/modules/Plan/Plan.dart';
import 'package:graduation_project/modules/about/about_screen.dart';

import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';
import 'package:graduation_project/shared/cubit/states.dart';
import 'package:graduation_project/shared/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';

import '../modules/Recipes/Recipe.dart';

import '../modules/feedback/feedback.dart';
import '../modules/forgot_password/forgot_password_screen.dart';
import '../modules/trainers/trainers_screen.dart';
import '../modules/profile/profile_screen.dart';
import '../modules/settings/settings_screen.dart';
import '../modules/users/users_screen.dart';
import '../shared/styles/themes.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var searchController =TextEditingController();


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit.get(context).getCustomMarker();
        return ConditionalBuilder(
            condition: state is AppGetUserLoadingState|| state is AppGetTrainerLoadingState,
            builder: (context) => Center(child: CircularProgressIndicator()),
            fallback: (context) => Scaffold(
              key: scaffoldKey,
              body: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: LatLng(30.033333, 31.233334),
                        zoom: 10
                    ),
                    mapType:AppCubit.get(context).mapTypeUser==popupMenuValues.normalView? MapType.normal : AppCubit.get(context).mapTypeUser== popupMenuValues.satelliteView? MapType.hybrid:MapType.terrain,

                    onMapCreated: (GoogleMapController googleMapController) {

                      // for search function
                      AppCubit.get(context).onMapCreated(googleMapController);
                      AppCubit.get(context).getCurrentLocation();
                      AppCubit.get(context).saveMyLocation();

                      // darkMapTheme
                      if(state is AppChangeModeState && AppCubit.get(context).isDark)
                      {
                        googleMapDarkTheme(googleMapController);
                      }
                      else if(AppCubit.get(context).isDark)
                      {
                        googleMapDarkTheme(googleMapController);
                      }
                      //markers
                    
                      addProgramMarker(context);
                     

                    },

                    buildingsEnabled: true,
                    trafficEnabled: true,
                    mapToolbarEnabled: true,
                    compassEnabled: true,
                    zoomControlsEnabled: true,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    markers: state is AppSearchSuccessState?AppCubit.get(context).mySearchMarkers: AppCubit.get(context).currentIndex==0 && state is !AppSearchSuccessState? AppCubit.get(context).myProgramMarkers :AppCubit.get(context).currentIndex==1 && state is !AppSearchSuccessState?AppCubit.get(context).myProgramMarkers:AppCubit.get(context).myProgramMarkers,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 40,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppCubit.get(context).isDark? HexColor('282828'):Colors.white,
                          child: IconButton(
                              onPressed: (){
                                scaffoldKey.currentState?.openDrawer();
                              },
                              icon: Icon(
                                Icons.menu_rounded,
                                size: 25,
                                color:AppCubit.get(context).isDark?Colors.grey:defaultColor,
                              )
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(child: CupertinoSearchTextField(
                          controller: searchController,
                          backgroundColor: AppCubit.get(context).isDark?HexColor('282828'):Colors.white,
                          itemColor: Colors.grey,
                          style: TextStyle(color: Colors.grey),
                          autocorrect: true,
                          onSubmitted: (value){
                            AppCubit.get(context).searchAndNavigate();
                          },
                          onChanged: (value){
                            AppCubit.get(context).changeSearchAddress(value);
                          },

                        )),
                        SizedBox(width: 10,),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppCubit.get(context).isDark?HexColor('282828'):Colors.white,
                          child: PopupMenuButton<popupMenuValues>(
                            onSelected:(value){AppCubit.get(context).changeMapView(value);},
                            //color: AppCubit.get(context).isDark? HexColor('282828'):null,
                            itemBuilder: (context)=> [
                              PopupMenuItem(
                                child:Text('Satellite view'),
                                value:popupMenuValues.satelliteView,
                              ),
                              PopupMenuItem(
                                child:Text('Normal view'),
                                value:popupMenuValues.normalView,
                              ),
                              PopupMenuItem(
                                child:Text('Terrain view'),
                                value:popupMenuValues.terrainnView,
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  if(AppCubit.get(context).currentIndex==1)
                    Positioned(
                      bottom: 15,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: AnimatedFloatingActionButton(
                          //Fab list
                            curve: Curves.bounceInOut,
                            durationAnimation: 300,
                            spaceBetween: -10.0,
                            fabButtons: <Widget>[
                              AppCubit.get(context).float1(context),AppCubit.get(context).float2(context)
                            ],
                            key : key,
                            colorStartAnimation: defaultColor??Color.fromARGB(255,157, 7, 89),
                            colorEndAnimation: defaultColor??Color.fromARGB(255,157, 7, 89),
                            animatedIconData: AnimatedIcons.menu_close //To principal button
                        ),
                      ),
                    ),
                  if(AppCubit.get(context).currentIndex==2)
                    Positioned(
                      bottom: 15,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: AnimatedFloatingActionButton(
                          //Fab list
                            curve: Curves.bounceInOut,
                            durationAnimation: 300,
                            spaceBetween: -10.0,
                            fabButtons: <Widget>[
                              AppCubit.get(context).float3(context),AppCubit.get(context).float4(context)
                            ],
                            key : key,
                            colorStartAnimation: defaultColor??Color.fromARGB(255,157, 7, 89),
                            colorEndAnimation: defaultColor??Color.fromARGB(255,157, 7, 89),
                            animatedIconData: AnimatedIcons.menu_close //To principal button
                        ),
                      ),
                    ),

                ],
              ),
              drawer: Drawer(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        myDrawer(context),
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: AppCubit.get(context).currentIndex,
                onTap: (value) {
                  AppCubit.get(context).changeIndex(value);
                },
                items:  AppCubit.get(context).userModel!.userType!='Trainer'?AppCubit.get(context).bottomItemsWithBurnsItem :AppCubit.get(context).bottomItem,
              ),


            ),
        );
      },
    );
  }


  Widget myDrawer(context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsetsDirectional.all(25.0),
              child: Row(
                children: [
                  Text(
                    'FoodieMate',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: defaultColor,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      navigateTo(context,ProfileScreen());
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          '${AppCubit.get(context).userModel?.image}'),
                      radius: 25,

                    ),
                  ),
                ],
              ),
            ),
          ),
          myDevider(),
          menuItem(
            itemIcon: Icons.food_bank,
            itemName: 'Recipes',
            onTap: () {
              navigateTo(context, Recipe());
            },
          ),
          menuItem(
            itemIcon: Icons.sports_gymnastics_sharp,
            itemName: 'Plans',
            onTap: () {
              navigateTo(context, Plan());
            },
          ),
          //if(AppCubit.get(context).userModel?.userType=='Admin')
          menuItem(
            itemIcon: Icons.local_hospital_outlined,
            itemName: 'Trainers',
            onTap: () {
              AppCubit.get(context).getTrainerData();
              navigateTo(context, TrainersScreen());
            },
          ),
          //if(AppCubit.get(context).userModel?.userType=='Admin')
            menuItem(
            itemIcon: CupertinoIcons.person_2,
            itemName: 'Users',
            onTap: () {
              AppCubit.get(context).getUsers();
              navigateTo(context, UsersScreen());
            },
          ),
          menuItem(
            itemIcon: Icons.settings_outlined,
            itemName: 'Settings',
            onTap: () {
              navigateTo(context, SettingsScreen());
            },
          ),
          menuItem(
            itemIcon: Icons.logout,
            itemName: 'Logout',
            onTap: () {
              AppCubit.get(context).signOut(context);
            },
          ),
          myDevider(),
          menuItem(
            itemIcon: Icons.info_outline,
            itemName: 'About',
            fontSize: 14,
            iconSize: 18,
            onTap: () {
              navigateTo(context, AboutScreen());
            },
          ),
          menuItem(
            itemIcon: Icons.feedback_outlined,
            itemName: 'Feedback',
            fontSize: 14,
            iconSize: 18,
            onTap: () {
              navigateTo(context, FeedBack());
            },
          ),
          menuItem(
            itemIcon: Icons.feedback_outlined,
            itemName: 'Support Ticket',
            fontSize: 14,
            iconSize: 18,
            onTap: () {
              navigateTo(context, ForgotPasswordScreen());
            },
          ),
        ],
      ),
    ),
  );
  void addProgramMarker(context) {
    AppCubit.get(context).addProgramMarker(
      markerId: '1',
      markerPosition: const LatLng(30.209562,31.533938 ),
      infoWindowTitle: 'Captain Sherif Elfadaly',
    );

    AppCubit.get(context).addProgramMarker(
      markerId: '2',
      markerPosition: const LatLng(30.0214489, 31.4904086),
      infoWindowTitle: 'Captain Shimaa Ragab',
    );

  AppCubit.get(context).addProgramMarker(
    markerId: '3',
    markerPosition: const LatLng(30.047562,31.518687),
    infoWindowTitle: 'Captain Alaa Hammouda',
  );
  AppCubit.get(context).addProgramMarker(
    markerId: '4',
    markerPosition: const LatLng(30.045063,31.266188),
    infoWindowTitle: 'Captain Barak Samir Ebraheem',
  );
  AppCubit.get(context).addProgramMarker(
    markerId: '5',
    markerPosition: const LatLng(30.096438,31.239688),
    infoWindowTitle: 'Captain Walid Adel',
  );
    AppCubit.get(context).addProgramMarker(
        markerId: '1',
        markerPosition: const LatLng(30.05160665975826, 31.21054654046658),
        infoWindowTitle:'Captain Ahmed Mostafa',
        infoWindowDescription: 'ISSA Certified Fitness Trainer, Specialist in Performance Nutrition, Specialist in Exercise Therapy, TRX instructor, Boxercise Instructor, Gym	Body Shapers Egypt, VIBES GYM and OSANA FAMILY WELLNESS'
    );

    AppCubit.get(context).addProgramMarker(
        markerId: '2',
        markerPosition: const LatLng(30.070037976343123, 31.284155908532693),
        infoWindowTitle: 'Captain Mohab Sarhan',
        infoWindowDescription: ' Freelancer Personal Trainer '
    );

    AppCubit.get(context).addProgramMarker(
      markerId: '3',
      markerPosition: const LatLng(30.015734113461725, 31.22772343015096),
      infoWindowTitle: 'Captain Mahmoud Abd Alazeem',
      infoWindowDescription: 'Freelancer Personal Trainer',
    );

    AppCubit.get(context).addProgramMarker(
      markerId: '4',
      markerPosition: const LatLng(30.043390224368093, 31.217853117984525),
      infoWindowTitle: ' Captain Ahmed Kandil ',
      infoWindowDescription: 'Freelancer Personal Trainer',
    );
    AppCubit.get(context).addProgramMarker(
      markerId: '5',
      markerPosition: const LatLng(30.065843713162607, 31.244354625377646),
      infoWindowTitle: 'Captain Mostafa Domany',
      infoWindowDescription: ' Freelancer Personal Trainer',
    );
    AppCubit.get(context).addProgramMarker(
      markerId: '6',
      markerPosition: const LatLng(30.05192076644373, 31.211052163215275),
      infoWindowTitle: 'Captain Ahmed Hamdy, 26X6+MCG',
      infoWindowDescription: 'Fitness Manager, 3753530',
    );
    AppCubit.get(context).addProgramMarker(
  markerId: '7',
  markerPosition: const LatLng(30.04484433519289, 31.210344506356613),
  infoWindowTitle: 'Captain Jessie Elbaz',
  infoWindowDescription: '26R6+W57, Ministry of Agriculture Street, Dokki, Dokki District, Giza 3751254',
);

AppCubit.get(context).addProgramMarker(
  markerId: '8',
  markerPosition: const LatLng(30.037857242715162, 31.209218132614158),
  infoWindowTitle: 'Captain Yasser Elkashef',
  infoWindowDescription: '26M6+P4, Dokki District, 15 May Bridge, Dr. El-Sabbaki',
);

AppCubit.get(context).addProgramMarker(
  markerId: '9',
  markerPosition: const LatLng(30.05212242683355, 31.211021180236536),
  infoWindowTitle: 'Captain Kirolos Emad',
  infoWindowDescription: '0237613117, Agouza, Agouza District, Giza 3753530',
);

AppCubit.get(context).addProgramMarker(
  markerId: '10',
  markerPosition: const LatLng(30.054054012579744, 31.210334534735367),
  infoWindowTitle: 'Catpain Mohamed Shaalan',
  infoWindowDescription: 'Beside HSBC Bank, El-Imbaba, Giza, 0233374317',
);

AppCubit.get(context).addProgramMarker(
  markerId: '11',
  markerPosition: const LatLng(30.045155859720996, 31.23022679471311),
  infoWindowTitle: 'Captain Karim Nour',
  infoWindowDescription: '987 Nile Corniche, Bab El-Louq, Abdeen, Cairo Governorate 4272040',
);

AppCubit.get(context).addProgramMarker(
  markerId: '12',
  markerPosition: const LatLng(30.07346400739051, 31.28485888329649),
  infoWindowTitle: 'Captain Karim Hamada Ebied',
  infoWindowDescription: '378M+9X5, Unnamed Road, El-Sarayat, El-Waily, Cairo Governorate',
);
AppCubit.get(context).addProgramMarker(
  markerId: '13',
  markerPosition: const LatLng(30.02323041387819, 31.237252230235853),
  infoWindowTitle: 'Captain Islam AbuAuf',
  infoWindowDescription: '0225351500, Zinhom, El-Sayeda Zeinab District, Cairo Governorate 4260102',
);

AppCubit.get(context).addProgramMarker(
  markerId: '14',
  markerPosition: const LatLng(30.073166901070287, 31.281462942806964),
  infoWindowTitle: 'Captain Hesham El Adawy',
  infoWindowDescription: '15 Sarayat Street, Abbassiya, 0226836668',
);

AppCubit.get(context).addProgramMarker(
  markerId: '15',
  markerPosition: const LatLng(30.025424652831912, 31.237583933650427),
  infoWindowTitle: 'Captain Moustafa ElNashar',
  infoWindowDescription: '0225351500, Railway El-Mahgar, Zinhom, El-Sayeda Zeinab District, Cairo Governorate 4260102',
);

AppCubit.get(context).addProgramMarker(
  markerId: '16',
  markerPosition: const LatLng(30.029817886746002, 31.232273542392065),
  infoWindowTitle: 'Captain Ahmed Wasfy',
  infoWindowDescription: '33 Kasr El-Aini, El-Ainy, El-Sayeda Zeinab District, Cairo Governorate, 4260016, 0225353040',
);

AppCubit.get(context).addProgramMarker(
  markerId: '17',
  markerPosition: const LatLng(30.044517238506575, 31.210157081923427),
  infoWindowTitle: 'Captain Ibrahim Taha',
  infoWindowDescription: '1 Nahda Street, Next to Ministry of Agriculture, Ministry of Agriculture Street, Dokki, Dokki District, Giza, 0233377677',
);

AppCubit.get(context).addProgramMarker(
  markerId: '18',
  markerPosition: const LatLng(30.605758347137343, 31.006484897177497),
  infoWindowTitle: 'Captain Mahmoud Antar',
  infoWindowDescription: 'H2F6+VR2, Shubra El-Kheima District, Menoufia 6132703',
);
AppCubit.get(context).addProgramMarker(
  markerId: '19',
  markerPosition: const LatLng(30.025721902404115, 31.237927256401008),
  infoWindowTitle: 'Captain Magdy Nabil',
  infoWindowDescription: '14 Medan El-Sadd El-Aali, Fenni Sabqan, Dokki District, Giza, 0237606444',
);


    AppCubit.get(context).addProgramMarker(
  markerId: '20',
  markerPosition: const LatLng(30.06389801557521, 31.259661948463698),
  infoWindowTitle: 'Captain Loui Jumat',
  infoWindowDescription: ',0225893754,3766+222, Al Shareaa Al Gadid, El-Adawi, Bab El-Shaariya, Cairo Governorate 4330360',
  icon: BitmapDescriptor.defaultMarker,
);

AppCubit.get(context).addProgramMarker(
  markerId: '21',
  markerPosition: const LatLng(30.06833436735362, 31.29338304819735),
  infoWindowTitle: 'Captain ANNA LOUISE',
  infoWindowDescription: 'Abbassiya, 6 El Sika El Beydaa, Abbassiya, Nasr City, Cairo Governorate, 0223425245',
  icon: BitmapDescriptor.defaultMarker,
);

AppCubit.get(context).addProgramMarker(
  markerId: '22',
  markerPosition: const LatLng(30.602608831652418, 31.482351105606053),
  infoWindowTitle: 'Captain Basem Gamal',
  infoWindowDescription: 'HFMP+JW9, Shiba El-Nakaria, Zagazig Center, Sharkia',
  icon: BitmapDescriptor.defaultMarker,
);

AppCubit.get(context).addProgramMarker(
  markerId: '23',
  markerPosition: const LatLng(30.030469867303026, 31.23626741984464),
  infoWindowTitle: 'Captain Heba Khalil',
  infoWindowDescription: ',01004244428,1 Abu el reesh, Medan, El-Sayeda Zeinab, Cairo Governorate',
  icon: BitmapDescriptor.defaultMarker,
);

AppCubit.get(context).addProgramMarker(
  markerId: '24',
  markerPosition: const LatLng(30.069819962462216, 31.294815243074865),
  infoWindowTitle: 'Captain Abd El-Azem',
  infoWindowDescription: ',0223424025,El-Abaseya, Ext. Ramses, El-Seriaat El-Sharqia, Nasr City',
  icon: BitmapDescriptor.defaultMarker,
);

AppCubit.get(context).addProgramMarker(
  markerId: '25',
  markerPosition: const LatLng(30.02058282917547, 32.54624379111682),
  infoWindowTitle: 'Captain Walaa Saeed',
  infoWindowDescription: 'XG8W+XX2, El Shahid, Suez',
  icon: BitmapDescriptor.defaultMarker,
);

AppCubit.get(context).addProgramMarker(
  markerId: '26',
  markerPosition: const LatLng(29.988970802929213, 31.272705680432043),
  infoWindowTitle: 'Captain Ahmed Zahran',
  infoWindowDescription: ',01014111130,X7MF+J37, El Gazayer, Maadi El-Sarayat El-Gharbeya, Qasr El-Bassatin, Cairo Governorate 4234501',
  icon: BitmapDescriptor.defaultMarker,
);

AppCubit.get(context).addProgramMarker(
  markerId: '27',
  markerPosition: const LatLng(30.0346310683986, 31.2268260439908),
  infoWindowTitle: 'Captain Samah Osama',
  infoWindowDescription: ',0223643988,26JG+JRF, Old Cairo, Cairo Governorate 4240310',
  icon: BitmapDescriptor.defaultMarker,
);

AppCubit.get(context).addProgramMarker(
  markerId: '28',
  markerPosition: const LatLng(30.05152250319907, 31.26607451475684),
  infoWindowTitle: 'Captain Shahir Mekawi',
  infoWindowDescription: 'Gohar El Qaed, Ad, El Darb El Ahmar, Cairo Governorate ,01020186351,4293076',
  icon: BitmapDescriptor.defaultMarker,
);

AppCubit.get(context).addProgramMarker(
  markerId: '29',
  markerPosition: const LatLng(30.084496646151642, 31.28966540160409),
  infoWindowTitle: 'Captain Eslam Shalaby',
  infoWindowDescription: 'El Khalifa El Mamoun, Kobri El-Qobba, Nasr City, Cairo Governorate ,01098106892,4393002',
  icon: BitmapDescriptor.defaultMarker,
);

AppCubit.get(context).addProgramMarker(
  markerId: '30',
  markerPosition: const LatLng(31.286739379431644, 29.91112654199217),
  infoWindowTitle: 'Captain Eslam Moheb (Essoo Crossfiter)',
  infoWindowDescription: '63 Ahmed Suleiman El Sheikh, Kom El-Deka Sharq, El Attarin, Alexandria ,034951963,5370055',
  icon: BitmapDescriptor.defaultMarker,
);

   AppCubit.get(context).addProgramMarker(
      markerId: '31',
      markerPosition: const LatLng(
          31.278235682989365, 29.91661969759209 ),

      infoWindowTitle: 'Captain Tarek Abdallah',
      infoWindowDescription: 'University, East Gate and Water Pump, East Gate Department, Alexandria, 01281813497, 5422023',

      icon: BitmapDescriptor.defaultMarker,
    );

    AppCubit.get(context).addProgramMarker(
      markerId: '33',
      markerPosition: const LatLng(
          31.32799950109503, 29.955071683502787),

      infoWindowTitle: 'Captain Mohamed Mohsen',
      infoWindowDescription: ', 034871586, 6XP2+M7H, Tariq Al-Geish, Al-Azareta and El-Shatby, East Gate Department, Alexandria 5452041',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addProgramMarker(
      markerId: '34',
      markerPosition: const LatLng(
          31.075047782730014, 31.363274801800014),

      infoWindowTitle: 'Captain Mohamed Tarek ',
      infoWindowDescription: '29V7+5MM, First Mansoura, Mansoura, Dakahlia',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addProgramMarker(
      markerId: '35',
      markerPosition: const LatLng(
          30.027932405096088, 31.23094591709254),

      infoWindowTitle: 'Captain Shadi A. Allam',
      infoWindowDescription: '1 Al-Qasr Al-Ainy St, Fom Al-Khalig Square, Al-Ainy, Sayeda Zeinab Department, Cairo Governorate, 0223664690',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addProgramMarker(
      markerId: '36',
      markerPosition: const LatLng(
          30.144562212053618, 31.355737632984656 ),

      infoWindowTitle: 'Captain Mohey Rihan',
      infoWindowDescription: '49J4+V7R, Ain Shams Sharqia, Ain Shams Department, Cairo Governorate 4545245',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addProgramMarker(
      markerId: '37',
      markerPosition: const LatLng(
          30.03329355852859, 31.23094591709066 ),

      infoWindowTitle: 'Captain Tamer Farag',
      infoWindowDescription: 'Corniche Al-Nile, Al-Ainy, Sayeda Zeinab Department, Cairo Governorate, 0223654061, 4262001',

      icon: BitmapDescriptor.defaultMarker,
    );

    AppCubit.get(context).addProgramMarker(
      markerId: '39',
      markerPosition: const LatLng(
          30.640302483584918, 32.28745098043834),

      infoWindowTitle: 'Captain Hany Emam',
      infoWindowDescription: 'Al-Buhaira, Second Ismailia Department, Ismailia 41517, 0643103835',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addProgramMarker(
      markerId: '40',
      markerPosition: const LatLng(
          30.147730114465325, 31.385083586592234 ),

      infoWindowTitle: 'Captain Bassam Hany',
      infoWindowDescription: 'Taha Hussein Axis, Heliopolis, Al-Nuzha Department, Cairo Governorate 4473303',

      icon: BitmapDescriptor.defaultMarker,
    );

    ////

    AppCubit.get(context).addProgramMarker(
      markerId: '41',
      markerPosition: const LatLng(
          30.033671660663572, 31.227995197038087 ),

      infoWindowTitle: 'Captain Ahmed Hisham',
      infoWindowDescription: 'Gezira, 0223643524',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addProgramMarker(
      markerId: '42',
      markerPosition: const LatLng(
          29.081860672402183, 31.121403769913048),

      infoWindowTitle: 'Captain Mohamed Awaad',
      infoWindowDescription: '24R9+Q8M, Beni Suef Department, Beni Suef Governorate 2731016',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addProgramMarker(
      markerId: '43',
      markerPosition: const LatLng(
          30.58457778169085, 31.501779497890124 ),

      infoWindowTitle: 'Captain Mahmoud Mohamed',
      infoWindowDescription: 'Tanta, Al-Gharbia Governorate 01011555655',

      icon: BitmapDescriptor.defaultMarker,
    );

      AppCubit.get(context).addProgramMarker(
      markerId: '44',
      markerPosition: const LatLng(
          30.58457778169085, 31.501779497890124 ),

      infoWindowTitle: 'Captain Moutaz Essam',
      infoWindowDescription: 'Tanta, Al-Gharbia Governorate 01011555655',

      icon: BitmapDescriptor.defaultMarker,
    );

    AppCubit.get(context).addProgramMarker(
      markerId: '45',
      markerPosition: const LatLng(
          30.1190749835053, 31.341648195084226),

      infoWindowTitle: 'Captain Ibrahim adel',
      infoWindowDescription: 'El-Fanar, Zagazig, Sharqia Governorate 01010553538',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addProgramMarker(
      markerId: '46',
      markerPosition: const LatLng(
          30.89472175257955, 31.368727027222413 ),

      infoWindowTitle: 'Captain Ibrahim Taha',
      infoWindowDescription: 'Mansoura, Dakahlia Governorate, 0502234441',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addProgramMarker(
      markerId: '47',
      markerPosition: const LatLng(
          30.558768964685054, 31.24876563277087 ),

      infoWindowTitle: 'Captain Loay Mamdouh',
      infoWindowDescription: 'G6HX+PG3, Asniet, Kafr Shukr Center, Qalyubia 6491644',

      icon: BitmapDescriptor.defaultMarker,
    );

    AppCubit.get(context).addProgramMarker(
      markerId: '48',
      markerPosition: const LatLng(
          30.235665930534893, 31.481944237700983),

      infoWindowTitle: 'Captain Farid Habib',
      infoWindowDescription: 'Captain Farid Habib, 5th Settlement, Block 16081, Rock Ville Rd, Al Obour, Qalyubia, 0246142000',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addProgramMarker(
      markerId: '49',
      markerPosition: const LatLng(
          30.013448219960967, 32.54075066026421 ),

      infoWindowTitle: 'Captain Ahmed Alnamakey',
      infoWindowDescription: 'XG8W+XX2, El Shohadaa, Suez, Suez',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addProgramMarker(
      markerId: '50',
      markerPosition: const LatLng(
          28.175775838893017, 30.77265313647568 ),

      infoWindowTitle: 'Captain Doaa Gamal Abd ElNaser',
      infoWindowDescription: 'Corniche El Nile, next to Minya Oncology Center, Al Minya, 0862339241',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addProgramMarker(
      markerId: '51',
      markerPosition: const LatLng(
          31.098290159302742, 31.368768004540723 ),

      infoWindowTitle: 'Captain Saad Ibrahim Saad',
      infoWindowDescription: 'Gehan Al Sadat, First District, Dakahlia 7650030, 0502202945',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addProgramMarker(
      markerId: '52',
      markerPosition: const LatLng(
          29.97783114756183, 32.550467211782376 ),

      infoWindowTitle: 'Captain Hossam Enaya',
      infoWindowDescription: 'Salah Uddin St, Suez, 8141210, 0623331190',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addProgramMarker(
      markerId: '53',
      markerPosition: const LatLng(
          30.072568428449916, 31.276650851960085 ),

      infoWindowTitle: 'Captain Ahmed Talaat',
      infoWindowDescription: '379G+64V, Captain El Deir El Abbasia El Qebli, Al Waily, Cairo Governorate 4390220',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addProgramMarker(
      markerId: '54',
      markerPosition: const LatLng(
          30.589537635318045, 31.00670549709788 ),

      infoWindowTitle: 'Captain Hany Eryan Samy',
      infoWindowDescription: 'Gamal Abdel Nasser St, Shibin El Kom, El Menoufia 6132703, 0482221277',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addProgramMarker(
      markerId: '55',
      markerPosition: const LatLng(
          25.392690598608382, 46.63273463437496),

      infoWindowTitle: 'Captain Fares Elsny',
      infoWindowDescription: 'JMHQ+5WF, Imam Abdulaziz bin Muhammad bin Saud Subsidiary Street, Al Alisha, Shemisee, Riyadh 12746, Saudi Arabia',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addProgramMarker(
      markerId: '56',
      markerPosition: const LatLng(
          30.819614617122227, 30.998463967644348),

      infoWindowTitle: 'Captain Khaled Gamal Ahmed',
      infoWindowDescription: 'Captain El Manshawi St, Tanta (2nd district), Tanta, El Gharbia',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addProgramMarker(
      markerId: '58',
      markerPosition: const LatLng(
          26.78497064798173, 31.787543788537988),

      infoWindowTitle: 'Captain Walid Bahaa Eldin Saad',
      infoWindowDescription: 'GPQ4+99P, Al-Khawli, First Division, Sohag 1670032, 0932155381',

      icon: BitmapDescriptor.defaultMarker,
    );

    AppCubit.get(context).addProgramMarker(
      markerId: '59',
      markerPosition: const LatLng(
          25.92936795138513, 32.852973613703305),

      infoWindowTitle: 'Captain Ahmed Fayek Khedr',
      infoWindowDescription: 'Tibah, New Tibah City, next to Tibah City Device',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addProgramMarker(
      markerId: '60',
      markerPosition: const LatLng(
          30.99524147009114, 31.71881841207787),

      infoWindowTitle: 'Captain Youssef Abbas',
      infoWindowDescription: 'Al-Zananiri Village, Awlad Saqr, Awlad Saqr Center, Al-Sharqia 7362860, 0553464636',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addProgramMarker(
      markerId: '61',
      markerPosition: const LatLng(
          30.31647014595019, 31.743196960386587 ),

      infoWindowTitle: 'Captain Mohamed Youssef',
      infoWindowDescription: 'Piece 200 southwest 6A Third Industrial Zone, Al-Sharqia, 01020010679, 44634',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addProgramMarker(
      markerId: '62',
      markerPosition: const LatLng(
          30.585341380706012, 31.49883788802093 ),

      infoWindowTitle: 'Captain Eslam Ezzelarab',
      infoWindowDescription: 'HG82+JGR, Al-Ahrar Road, Zagazig Center, Al-Sharqia 7141360',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addProgramMarker(
      markerId: '63',
      markerPosition: const LatLng(
          27.33111817013578, 31.206331644086358 ),

      infoWindowTitle: 'Captain Karim Ahmed',
      infoWindowDescription: '0882370016, 55HJ+QPC, Ring Road, Second Al-Hamraa, Second Division Asyut, Asyut 2073021',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addProgramMarker(
      markerId: '64',
      markerPosition: const LatLng(
          30.03383715734181, 31.43728258160833  ),

      infoWindowTitle: 'Captain Rihan Youssef',
      infoWindowDescription: '90 North 90th, First Division, New Cairo, Cairo Governorate, 0228124242, 4730131',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addProgramMarker(
      markerId: '65',
      markerPosition: const LatLng(
          30.074351063771537, 31.275756983685152),

      infoWindowTitle: 'Captain Labib Ahmed',
      infoWindowDescription: '379G+64V, Private Path Captain Al-Damurdash, Al-Abbaseya Al-Qublyah, Al-Waily, Cairo Governorate 4390220',

      icon: BitmapDescriptor.defaultMarker,
    );
    AppCubit.get(context).addProgramMarker(
      markerId: '66',
      markerPosition: const LatLng(
          30.04357842265291, 31.21672725544704 ),

      infoWindowTitle: 'Captain Saad Mohsen',
      infoWindowDescription: '14 Medan, Al-Sadd Al-Ali, formerly Funi, Al-Duqqi Division, Giza, 0237606444',

      icon: BitmapDescriptor.defaultMarker,
    );
  }
  }


