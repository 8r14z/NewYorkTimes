# NewYourTimes

*This is a demo for NYTimes APIs which applys **VIPER, POP, Core Data,** ...*

# VIPER
*This project will apply VIPER*

> VIPER is an application of Clean Architecture to iOS apps. The word VIPER is a backronym for View, Interactor, Presenter, Entity, and Routing.


# Project Structure:
## 3 main folders:
* [NewYourTimes](#newyourtimes-1)
* [NewYourTimesTests](#newyourtimestests)
* [NewYourTimesUITests](#head3)

### <a name="head1"></a>NewYourTimes
Contains App Bundle with 3 main folders:
* [Source](#head1.1) which contains all source code
* [Resources](#head1.2) which contains all resources such as: images, localizable strings,...
* [Supporting Files](#head1.3) which contains supporting files for the project: info.plist,...

#### <a name="head1.1"></a> Source
* **AppDelegate.swift** 
* **UI**: contains all UI related code
  * **Custom**: contains all custom UI
  * **Base**: contains all base protocols/classes
  * **Screens**: contains all in-app screens
* **Components**: contains all backend supporting code
  * **Repositories**: contains all data access layers using in the project
  * ...
* **Common**: contains constants and utility methods that uses in the project

### <a name="head2"></a>NewYourTimesTests
Contains Unit Tests

### <a name="head3"></a>NewYourTimesUITests
Contains UI Tests
