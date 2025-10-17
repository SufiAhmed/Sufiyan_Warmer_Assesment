# Warmer Assesment By Sufiyan Ahmed

This is a project that utilzies SwiftUI and Warmer Prod/Staging API's to build a web like mobile iOS application. This app allows you to login with Warmer production auth credentials and stores the token in userdefaults for later use. Upon login you will be brought to the "Browse Topics" sections where you can choose which category of an issue you would like to talk with someone about, after clicking on a row you will be navigated to the deatial section with multiple experts who can talk to you about the category choose. Don't want to scroll through all the topics? there is a bulit in search feature that allows you to search for the category you are looking for. In the middle tab we have the "AI Match" section, here you can insert a prompt and and AI tool will match you with an expert. Don't like the expert? ask it to match again and it will find another resource for you. The last tab is your sessions tab, currently supports showing upcoming sessions you have scheduced. This view will show you a card about the upcoming session and give you small meta data regarding it like, the expert's name, their related story, date and time. 

# Assumtions Taken:
-  We want to match the UI and consistent as much as possible from the Web app, so I did some playing around with the features I was integrating to keep similarity. 
- We have multiple API's all of different API models, created a generic API calling system to allow for easy api integration.
- Images seems consitent throughout the app, integrated a lightweight cahce system for faster load times.
- Since Product likes to design in SwitUI tried to keep the View logic as seperated as possible from bussiness logic to allow for easy integrations from both sides. 


# Contains: 
 - MVVM architecture, Models for each API, ViewModels for views that need to conduct bussiness logic, and view files to support UI.
 - Utilzies a separated out AsyncAPI handler for all api calls.
 - AsyncAPI handler supports generic decoding and auto-retry feature built in in case of other error resposne codes.
 - Uses Async/Await concurrency techniues for app data loads and api requets. 
 - NavigationStack, with Navigation Links to change views and a presistent Tab bar for global navigation.
 - Multiple built in swiftUI views such as ScrollViews, Custom Search Bar, Lists, Buttons, and more.
 - Multiple resuable componets for more modular code which includes the WarmerBackground view with the gradient colors, offeringRowItemView which was used in two differnet view componets, and Loading view for a loading overlay. 
 - Loading inidcators when certain tasks are being loaded or taking time to give user visual feedback.
 - Error handling in the API calls by conducting auto-retry, dynamic login error handling by using the error response form the api to display specific error, and empty states for views incase no data is found.
 - Seperated out utilites like Time file which supports changing certain time strings to more formatted strings, Strings file to easily maintain strings throughtout the app and reduce "Magic Strings", Route service to store all hardocded API Urls. 
 - XCT tests for bussiness logic of the BrowserViewModel.
 - Added a share button at the top right of the tool bar to show a share sheet to send the app's beta preview to any contacts of friends. Can't share app url since this app is not in the app store, but a beta preview messages is sent. 
 - The app viewModels import in Combine framework, however no Combine was used for this project. I did the mistake of upgrading my laptop and it upgraded my Xcode to Xcode 26 and in this Xcode verison there is known bug for when you add the ObservableObject protocol to a class that this error shows -> "Xcode 26.0.1 Type 'BrowserViewModel' does not conform to protocol 'ObservableObject". To bypass this bug/issue you need to import in Combine. Here is the StackOverflow link -> https://stackoverflow.com/questions/79779756/xcode-26-0-1-type-datacontroller-does-not-conform-to-protocol-observableobjec
 
# Build Tools & Version
- Xcode Version 26
- Built for devices iOS 17.6 & up
- Tested using iPhone 13 Pro Max, iOS 18.5
- SwiftUI, UIKit, Foundation, XCTest

# More Time:
- Some things I would like to do if I had more time would be:
-  Include a signed In state, current app version has you login and will ask you to signin everytime you open the app. Utilize the global boolean to keep you signed in. 
-  Add better UI for the star rating, I would like to take time to implement the logic for how many stars should show
-  handle Pagination for the API Requests. This is common in the industry and something that should be included in. 
-  Better UI matching with the web componets, I tried to best use and match with current web UI but would like to polish it more.
-  Make more componets resuable, I see some componets througout the app I can inject in different places after making it modular.
-  Offline Support so like cahcing essential data and allow basic functionality when offline.
-  Better handling of a the token, its always best practice to store the tokens using KeyChain which Apple provides. Keeps is more secured.
-  Some of the functions in the Time utility file can be comined, if had more time I would try to combine those methods if possible.




