Original App Design Project
===

# Aura

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)
3. [Project Plan](#Project-Plan)

## Overview
### Description
The user inputs mood entries that align with a color, enabling them to track their mental health and mood changes over an extended period of time. Aura will also include end of the week reviews that generate resources for the user based on their percentage of happiness. It will be intergrated with Apple HealthKit in order to suggest the appropiate resources based on the correlation between the user's mood entries and health stats (i.e. sleeps, steps, weight).

### App Evaluation
- **Category:** Health & Fitness
- **Mobile:** Aura will initially be developed for mobile use, but could possibly be viable on a computer or in a desktop setting. However, developing for moblie would be ideal as users should be able to make entries at any time without being in front of a computer.
- **Market:** Any individual could choose to use Aura, either for recreational purposes and/or to learn more about themselves emotionally, or by people who have pre-existing mental health disorders to help them monitor and/or keep track of the state of their mental health by tracking their moods.
- **Habit:** Ideally, the user would get into the habit of using Aura every day so that they can see their progress over the course of a week, a month, etc. Because the app is color-oriented, using Aura every day would make it much easier for the user to reflect on their mood changes in a calender view or chart view format.
- **Scope:** First, I will implement the ablility for the user to log in and set the time that they recieve notifications for their daily entries, then I would introduce both a calander view and chart view format so the user can evaulate their mood changes over specific periods of time. Finally, I will implement the ability for Aura to suggest resources based on the user's entries and HealthKit data.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can log in/sign up to access their personal data
* User can log out
* User chooses the time of daily entry reminder
* User can create a mood entry based on a selection of phrases paired with colors/icons
* User can see color-oriented calendar and chart views of their entries over time
* User can view and edit their HealthKit data on profile screen
* User recieves weekly resources based on their entries
* Settings

**Optional Nice-to-have Stories**

* A past reports screen
* A tab for mini games
* A tutorial for new users

### 2. Screen Archetypes

* Log in
    * User can log in to access their personal data
* Sign up
    * User can sign up to save their entries
* Home/Entry screen
    * User creates a mood entry
* Logged entry screen
    * User can review/edit their mood entry
* Calendar view
    * User can see a color-oriented overview of their entries in calander format
* Chart view
    * User can see a color-oriented overview of their entries in chart format
* Profile
    * User can view resources and manage their HealthKit data
* Settings
    * User can toggle between dark/light mode, turn notifications on/off, change the time of daily enty reminder, and log out
* Past reports
    * User can view their past 8 weekly reports
* Mini games
    * User can play mini games to cope with anxiety/stress

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home/Entry
* Statistics
* Mini Games
* Profile

**Flow Navigation** (Screen to Screen)

* Log in -> Sign up or Home/Entry
* Home/Enty -> Logged entry
* Calendar -> Chart
* Profile -> Settings or Past reports
* Mini games -> null

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="YOUR_WIREFRAME_IMAGE_URL" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
### Models
Entry
|Property|Type|Description|
|-|-|-|
|objectID|String|unique id for the user entry (default field)|
|author|Pointer to User|entry author|
|face|Image|face icon that user selects|
|mood|String|phrase that describes user's mood|
|createdAt|DateTime|date when entry is created (default field)|
|updatedAt|DateTime|date when entry is last updated (default field)|

User
|Property|Type|Description|
|-|-|-|
|objectID|String|unique id for the user entry (default field)|
|entries|Array|user's entries|
|name|String|user's name|
|username|String|user's username|
|password|String|user's password|
|profilePicture|Image|user's profile picture|
|consecutiveDays|Number|number of consecutive days that user creates entries|
### Networking
- Log in Screen
    - (Read/GET) Get user log in information
- Home/Entry Screen
    - (Create/POST) Create a new entry object
- Logged Entry Screen
    - (Read/GET) Get entry
- Calendar View Screen
    - (Read/GET) Query all entries where user is author
- Chart View Screen
    - (Read/GET) Query all entries where user is author
- Profile Screen
    - (Read/GET) Query logged in user object
    - (Update/PUT) Update user profile image
    - (Update/PUT) Update user profile name
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]

## Project Plan
