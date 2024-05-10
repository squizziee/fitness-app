# Fitness application for Android
## Lianha Ivan, group 253504

This project is a mobile application for planning workout routines of various types and durations. It provides comprehensive customization and management of workout schedules, as well as smooth operation and an intuitive interface.

Functionality:

**Workout regiment creation (unlimited number of routines can be created):**
+ Namesetting
+ Setting the duration of the routine in days
+ Setting the sport type
+ Writing a description
+ Setting a workout/rest day for each day of the regiment

**Workout creation:**
+ Namesetting
+ Exercise addition (200+ options)
+ Exercise deletion
+ Exercise editing

**Adding exercises to workout (each type of sport has its own exercise handler). For weight training:**
+ Exercise type selection (each exercise corresponds to a body part and exercise type - barbell, dumbbell, cables, bodyweight)
+ Set creation (selecting weight, number of repetitions, notes)
+ Set editing
+ Set deletion

**Setting goals:**
+ Exercise selection
+ Setting a goal for the exercise
+ Setting a deadline for the goal
+ Progress tracking

**Other features:**
+ Access to a list of all workouts
+ Profile editing
+ Bulletproof input

Application class diagram:

![OOP_new drawio](https://github.com/squizziee/fitness-app/assets/50028911/95e61729-ec7c-4ead-bf0a-4808a040454e)

Model description:
+ TrainingRegiment – an instance of a training regiment. Contains general info including name, Firestore ID in regiment collection, type of training, description, length of schedule and the schedule itself.
+ TrainingType – type of training, contains an icon for visual interface.
+ TrainingSession – an instance of a training session. Contains Firestore ID in session collection, name, notes and list of exercises.It is also a parent class. If a new type of training is added to the application, this class needs to be inherited (e.g. SwimmingTrainingSession).
+ Exercise – an instance of an exercise. Contains type of exercise (movement) and notes. It is a parent class just like the previous one. Needs to be inherited to add new training type.
+ ExerciseType – type of movement (e.g. Squat, Bench Press, Run, etc). It is retrieved from Firestore and searched through with CustomSearchDelegate.
+ GoalWatcher – goal manager. Notifies the user when a goal is due.
+ Goal – goal instance. Contains goal description, exercise and deadline for a goal

