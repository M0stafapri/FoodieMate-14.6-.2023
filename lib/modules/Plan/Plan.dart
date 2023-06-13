import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';
import 'package:graduation_project/shared/cubit/states.dart';
import 'package:graduation_project/shared/styles/colors.dart';

class Plan extends StatelessWidget {
  const Plan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return  Scaffold(
          appBar: AppBar(
            leading:IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                )),
            title: Text('Plans'),
          ),
          body:SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child:Padding(
              padding: const EdgeInsets.all(20),
              child:Column(
                children: [
                  Row(
                    children: [
                      Image(
                              image: AssetImage('assets/images/60.jpg'),
                                                    width: 250, // set the desired width of the image
                              height: 300, // set the desired height of the image
                              fit: BoxFit.scaleDown, //// set the fit property to scale down the image
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height:10,),
                            Text(
                                'Lose Weight',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10,),
                            Text(
                                'If you have any body fat, and you want to get some weight off you. please follow these guide.',

                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                              ),
                            ),
                            SizedBox(height:10),
                            IconButton(
                              onPressed: (){
                                AppCubit.get(context).changeWidgetVisibility(one: true);
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size:35,
                                color: defaultColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if(AppCubit.get(context).OneVisible)
                    Card(
                    color: Colors.grey[100],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Color.fromARGB(255, 0, 0, 0),
                                size: 13,

                              ),
                              SizedBox(width:10,),
                              Expanded(
                                  child:Text(
                                    "Main Goal: Lose Fat Workout Type:  Split Training Level: Beginner Program Duration: 12 weeks Days Per Week: 5 Time Per Workout: 45-60 minutes Equipment Required: Barbell, Bodyweight, Cables, Dumbbells, EZ Bar, Machines Target Gender:Female Recommended Supps: Whey Protein Isolate, Fish Oil, Fat Burner (optional)",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 7, 0, 83),
                                    ),
                                  )
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Color.fromARGB(255, 3, 3, 3),
                                size: 13,

                              ),
                              SizedBox(width:10,),
                              Expanded(
                                  child:Text(
                                    " Exercise: Dumbbell Bench Press   Sets: 3-4	\n Reps: 6-12",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  )
                              ),
                            ],
                          ),
                          SizedBox(
                            height:10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Color.fromARGB(255, 0, 0, 0),
                                size: 13,

                              ),
                              SizedBox(width:10,),
                              Expanded(
                                  child:Text(
                                    "Exercise: Incline Dumbbell Press   Sets: 2-3	Reps: 12-15",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 7, 0, 83),
                                    ),
                                  )
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Color.fromARGB(255, 0, 0, 0),
                                size: 13,

                              ),
                              SizedBox(width:10,),
                              Expanded(
                                  child:Text(
                                    " Exercise: Machine Chest Fly  Sets: 2-3	Reps: 12-15",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  )
                              ),
                            ],
                          ),
                          SizedBox(
                            height:10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Color.fromARGB(255, 7, 0, 83),
                                size: 13,

                              ),
                              SizedBox(width:10,),
                              Expanded(
                                  child:Text(
                                    "Exercise: Seated Dumbbell Press   Sets: 3-4	Reps: 6-12",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 7, 0, 83),
                                    ),
                                  )
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Color.fromARGB(255, 6, 0, 0),
                                size: 13,

                              ),
                              SizedBox(width:10,),
                              Expanded(
                                  child:Text(
                                    "Exercise: Lateral Raise   Sets: 2-3	Reps: 12-15",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  )
                              ),
                            ],
                          ),
                          SizedBox(
                            height:10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Color.fromARGB(255, 0, 0, 0),
                                size: 13,

                              ),
                              SizedBox(width:10,),
                              Expanded(
                                  child:Text(
                                    "Exercise: Deadlifts   Sets: 3-4	Reps: 6-12",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  )
                              ),
                            ],
                          ),
                          SizedBox(
                            height:10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Color.fromARGB(255, 0, 0, 0),
                                size: 13,

                              ),
                              SizedBox(width:10,),
                              Expanded(
                                  child:Text(
                                    "Exercise: Leg Extensions   Sets: 3	Reps: 12",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  )
                              ),
                            ],
                          ),
                          SizedBox(
                            height:10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Color.fromARGB(255, 0, 0, 0),
                                size: 13,

                              ),
                              SizedBox(width:10,),
                              Expanded(
                                  child:Text(
                                    "Exercise: Incline Skullcrusher  Sets: 3	 Reps: 12",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Image(image:AssetImage('assets/images/61.jpg'),
                                                    width: 250, // set the desired width of the image
                              height: 300, // set the desired height of the image
                              fit: BoxFit.scaleDown, // set the fit property to scale down the image
                      
                      ),

                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height:10,),
                            Text(
                                'Gain Weight',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10,),
                            Text(
                                'If you have issues with you being skinny, please follow these guide to gain some weight',

                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                              ),
                            ),
                            SizedBox(height:10),
                            IconButton(
                              onPressed: (){
                                AppCubit.get(context).changeWidgetVisibility(two: true);
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size:35,
                                color: defaultColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if(AppCubit.get(context).TwoVisible)
                    Card(
                      color: Colors.grey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  size: 13,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text( "Exercise: Plank   Sets: 3    Reps: 20 sec holds",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  size: 13,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      " Exercise: Crunches   Sets: 3    Reps: 20",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  size: 13,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Column(
                                      children: [
                                       Text(
                                          "Exercise: Push Up   Sets: 3    Reps: 20",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color:Color.fromARGB(255, 0, 0, 0),
                                          ),
                                        ),
                                        SizedBox(
                                          height:10,
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: Color.fromARGB(255, 0, 0, 0),
                                              size: 10,

                                            ),
                                            SizedBox(width:10,),
                                            Expanded(
                                                child:Text(
                                                  "Exercise: Bodyweight Jump Squat  Sets: 3    Reps: 20",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                  ),
                                                )
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:10,
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: Color.fromARGB(255, 0, 0, 0),
                                              size: 10,

                                            ),
                                            SizedBox(width:10,),
                                            Expanded(
                                                child:Text(
                                                  "Exercise: Lying Leg Raise  Sets: 3    Reps: 20",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromARGB(255, 0, 22, 47),
                                                  ),
                                                )
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height:10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  size: 13,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Exercise: Kettlebell Swing Sets: 3    Reps: 20",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 18, 2, 46),
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height:10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  size: 13,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Exercise: Alternating Bodyweight Lunge  Sets: 3    Reps: 20",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Image(image:AssetImage('assets/images/62.jpg'),
                                                                          width: 250, // set the desired width of the image
                              height: 300, // set the desired height of the image
                              fit: BoxFit.scaleDown, //
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height:10,),
                            Text(
                                'Maintain Weight',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10,),
                            Text(
                                'If you want to keep your body in the same shape, without having to gain muscles, follow this guide',

                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                              ),
                            ),
                            SizedBox(height:10),
                            IconButton(
                              onPressed: (){
                                AppCubit.get(context).changeWidgetVisibility(three: true);
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size:35,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if(AppCubit.get(context).ThreeVisible)
                    Card(
                      color: Colors.grey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Exercise: Standing Calf Raises   Sets: 3    Reps: 20",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 0, 23, 49),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Exercise: Bodyweight Glute Bridge   Sets: 3    Reps: 20",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Exercise: Mountain Climbers   Sets: 3-5    Reps: 15",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Exercise: Side Lying Clams   Sets: 4-5    Reps: 15",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Exercise: Seated Curls   Sets: 2-3   Reps: 30",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Exercise: Stiff-Leg Deadlift  Sets: 2-3   Reps: 30",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Image(image:AssetImage('assets/images/63.jpg'),
                                                                                                width: 250, // set the desired width of the image
                              height: 300, // set the desired height of the image
                              fit: BoxFit.scaleDown, ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height:10,),
                            Text(
                                'Gain Muscle',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10,),
                            Text(
                                'If you want to grow muscles, follow this guide',

                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                              ),
                            ),
                            SizedBox(height:10),
                            IconButton(
                              onPressed: (){
                                AppCubit.get(context).changeWidgetVisibility(four: true);
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size:35,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if(AppCubit.get(context).FourVisible)
                    Card(
                      color: Colors.grey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Call 123 or ask someone else to",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.blue[800],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Lay the person on their back and open their airway.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Check for breathing. If they are not breathing, start CPR.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Perform 30 chest compressions.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Perform two rescue breaths.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Repeat until an ambulance or automated external defibrillator (AED) arrives",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Image(image:AssetImage('assets/images/64.jpg'),
                                                                          width: 250, // set the desired width of the image
                              height: 300, // set the desired height of the image
                              fit: BoxFit.scaleDown, 
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height:10,),
                            Text(
                                'Get Shredded',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10,),
                            Text(
                                'If you wanna get your muscles in a perfect shape, follow the upcoming guide',

                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                              ),
                            ),
                            SizedBox(height:10),
                            IconButton(
                              onPressed: (){
                                AppCubit.get(context).changeWidgetVisibility(five: true);
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size:35,
                                color: Colors.black
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if(AppCubit.get(context).FiveVisible)
                    Card(
                      color: Colors.grey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Exercise: Machine Side Lateral Raises Sets: 2-3   Reps: 30",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Exercise:  Seated Rear Dumbbell Lateral Raise Sets: 2-3   Reps: 30",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Exercise:  Barbell Military Press Sets: 2-3   Reps: 30",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Exercise:  Machine Shrugs Sets: 2-3   Reps: 30",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,

                                ),
                                SizedBox(width:10,),
                                Expanded(
                                    child:Text(
                                      "Exercise:  Machine Shrugs Sets: 2-3   Reps: 30",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),


          ),

        );
      },
    );
  }
}
