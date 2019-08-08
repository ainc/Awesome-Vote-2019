## Introduction
   
![Alt text](/assets/images/5-Across-Logo.png?raw=true "Title")

~~The Awesome Vote app was created to provide a unique and useful
way to upload and vote on pitch ideas from one's own mobile device.
Loosely based on awesome-vote (2016), the former Mean.js-based
application.~~

With the recent death of the awesome-vote project of 2016, a desire
for a new way to connect with 5Across participants has come about. 
Thus the idea for the 5Across voting game app was developed. The
idea of the game is to allow users to "bet" points on the 5 ideas 
being pitched. If they bet correctly, they will generate more points,
allowing them to bet even more at the next event. This will generate
excitement for the vent and motivate attendees to come back again.

Possible features include uploading data about current pitches, voting
on ideas, accumulating points, and a leaderboard of users with the
most points.

This app uses Google's Flutter app development API, along with 
Cloud Firestore and Authentication of Firebase as its backend database. 
This allows for the data stored by the app to eventually be ported to
a supplementary website/app if wanted, along with allowing users from 
all OS's to play nicely together.

Author: Mark Hisle (mark.hisle@awesomeinc.org)

Current features:
- Login page and transition backend with basic UI/styling
- Registration with some error handling
    - new users receive a set number of points/money to start with
    - emails cannot be repeated
    - linked to Firebase Auth database (more below)
    - kinda sorta handles invalid registrations, could be fleshed out
- loading screen of app (textless 5across logo), might not work on iOS
- home page containing user data and 5 pitches pulled from Firebase
    - user data is in the user_data collection in the firebase, holding a firebase ID,
      username retrieved by said ID, and points allocated to each user
    - pitch data is held in pitch_ideas, allowing admins to easily change data by 
      logging into the firebase
    - firebase can be accessed through awesomeinclexington@gmail.com account
- a few images for styling

TODO:
- description page/hero animations for pitches
- BUG: error handling/invalid login or registration processing
- betting process
- reset password
- leaderboard?
- clean up page transition process, backend (bugs) and frontend (animations)
- ios 
- documentation

## Getting Started

Note: Currently not fully implemented for iOS, more configuring will need to be set up on a different environment.

For help getting started with Flutter, view
[documentation](http://flutter.io/).
