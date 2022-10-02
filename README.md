# CurrencyConverter
This is a very simple app which would show account balances of different currencies which can be converter by the user to another currency via API. Here are some of the constraints and features - 
1. there may be a commission fee for the currency conversion operation. The ```first five currency conversions are free of charge``` but afterwards currency conversions are charged ```0.7% of the currency being traded```. The commission fee should be displayed in the message that appears after the conversion.
2. The application supports only ```EUR, USD, JPY``` currencies and initial state should be ```1000.00 EUR, 0.00 USD, 0 JPY```.
3. There is a possibility of expanding the calculation of a more flexible commission. It is possible to come up with various new rules, for example - every tenth conversion is free, conversion of up to 200 Euros is free of charge etc.

# Requirements to run the project
In the whole app, ```only one third party library (Realm) is used which is installed via cocoaPods```. to run the project,
1. Go to project directory
2. Run these following commands one by one -
```
sudo gem install cocoapods
pod init
pod install
```
3. Open the .xcframework file and run the project in any device having iOS 13+

# Architecure
For design pattern, ```MVVM``` should be used and also ```SOLID architecture``` would be a must as we need to create scope for future requirements. Here is a top level view of the architecture 
![Architecture](https://user-images.githubusercontent.com/51700181/193473657-21ba643e-e18a-4406-954c-cd25904c33e3.JPG)

# Solution overview
At this project, I really wanted to show my skills/knowledge set of different approaches. So I used 
```
-> async/await in API calls
-> closure completion of data fetching
-> protocol delegate as well as notification observer for data communication. 
-> generic classes to reuse code. 
-> maintained SOLID, clean architecture. So adding new feature wont break the code
-> For design pattern, I followed MVVM.
```

Following one approach throughout the whole app is good practice, but as this project is a reference for my knowledge set, I wanted to use all of them. Here are the details - 

1. For Model - As this is a simple project, all the data model is very simple. Model is also responsible to communicate with serviceManager.

2. For View - For the color combination, I used (https://www.canva.com/learn/100-color-combinations/) this link. For the UI design, I could have implemented alert taost instead of alerts. The reason why alert toast is better in some cases is, user have to tap on the app less which is better for user experience. However, overall 8-9 hours have been spent in views. The reason why it took so long is, because for the past couple of months, I am involved in a swiftUI project where I am deeply learning things to know my way arounds. Took a while to get out of the comfort zone I created and also every subviews are customized which does require time

3. For ViewModel - Used protocol delegate, notification observer to pass data to the views. As I am learning my way around in SwiftUI with @EnvironmentObject @StateObject, I made the choice to learn combine as secondary objective. If I start working with swift storyboard again, ```I will definitely learn combine in future```

4. For ServiceManager - Here serviceManager controlls networkManager and storageManager. For API calls, i used async/await appraoch and ```in database, I used Realm```. Even though the data is very simple and ```I could easily use UserDefaults or CoreData```, I wanted to learn and preserve this skill. However, as name suggests, networkManager is responsible for API communications and storageManger is responsible to save, fetch and update data. ```I created API call a generic method for code re-usability```

5. For CommissionManager - As feature might be added in near future, I implemented the class accordingly. Here, commissionManagers responsibility is to check if the user have enough balance to convert the currency and also bear the fees.

It took around ```3 working days (24 hours)``` for me to complete this project. App supports ```iOS13 with iPhone (Portrait), iPad(Both)```. Also ```Priority given for separation of concern and Test Code is written for all the Manager class```

# App workflow overview
After the app comes to foreground, ViewModel asks model to provide data models. Model then communicate with storageManager. StorageManager checks if any data already exists in the database. If not, creates a new database with project required initializer and sends it back to model. ViewModel then injects the data to View. Views responsibility is to take the input from user and update the view/pass the data between controllers. All sort of validation responsibility including business logic is taken by ViewModel. After user selects a sellCurrency, buyCurrency and sellAmount, after 1 second API call is requested from view to ViewModel to Model to ServiceManager to NetworkService. The data also passes through the same media. After clicking on submit button, the temporary saved transaction gets permanent and ViewModel asks Model to update the data. Model updates its data and also sends to database to update

# App ScreenShot
<img width="565" alt="Screenshot 2022-10-03 at 1 33 28 AM" src="https://user-images.githubusercontent.com/51700181/193473487-dfdcc64b-198c-4b6f-bea5-9daf94c46e05.png">
<img width="1049" alt="Screenshot 2022-10-03 at 1 34 01 AM" src="https://user-images.githubusercontent.com/51700181/193473488-f12dd35f-e70c-4802-9e8c-7183c45e3876.png">
<img width="565" alt="Screenshot 2022-10-03 at 1 34 11 AM" src="https://user-images.githubusercontent.com/51700181/193473489-ec6bc843-21d7-4b23-8a51-1c7c71bf7df3.png">
