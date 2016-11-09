# AppMonitor



[![Screenshot 2016-11-09 19.04.45.png](https://s14.postimg.org/cz8p6rsep/Screenshot_2016_11_09_19_04_45.png)](https://postimg.org/image/68s7xc58t/)

AppMonitor is a dynamic framework for ios which moniters your application for the app lunch count and spent time by the user.

## Requirements

- iOS 8.0+ 
- Xcode 6.0+

## Communication

- If you **need help**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/appmonitor). (Tag 'appmonitor')
- If you'd like to **ask a general question**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/appmonitor).
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Installation
You can install AppMonitor to your projects in two ways
### Instalation using  CocoaPods (Recommented)
[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```
> CocoaPods 1.1.0+ is required to build Alamofire 4.0.0+.

To integrate AppMonitor into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
pod 'AppMonitor', '~> 1.2'
end
```
### Manual Instalation
For Manual integration follow below steps

######     1. Download the AppMonitor.framework file to your system

######     2. Drag and drop framework to your Xcode project .In the displayed dialog, choose Create groups for any added folders and select Copy items into destination group's folder. This will copy framework to your project folder.

######    3. Add AppMonitor framework to the embeded framework section of your Xcode project (Target -> General Tab -> Embeded Binaries


You are done.

## Usage

### Intialising Framework
SDK should be initialised before calling invoking any APIs available in the framewok. 

```ObjC
#import <AppMonitor/AppMonitor.h>

[AppMonitor initializeWithAPIKey:<YOUR_API_KEY> logLevel:AppMonitorLoggingLevelAllLogs];
```

### Posting Events

You can post events with name and attributes.

```ObjC
[[AppMonitor sharedSDK]postEvent:@"Test Event" withAttributes:@[@"arg1",@"arg2"]];
```

### Retrieving App Launch Count
This API will returns the app lunch count till that time . It will be returning an `NSInteger`.

```ObjC
[[AppMonitor sharedSDK]appLaunchCount]];
```

### Retrieving App spent time
This API will returns the spent time of user in the application till that time . It will be returning an `NSTimeInterval`.
```ObjC
[[AppMonitor sharedSDK]appLaunchCount]];
```
## TroubleShooting

1.After manual integration if your are getting below error

dyld: Library not loaded: @rpath/AppMonitor.framework/AppMonitor
Referenced from: /Users/rahul/Library/Developer/CoreSimulator/Devices/2BDC82C0-4F17-4CEB-A5B7-363EC49DB4FE/data/Containers/Bundle/Application/476ABE1D-7E7C-41D5-BEAA-EAE3B5623E23/Test.app/Test
Reason: image not found

######   This means you haven't followed the manual integration steps.But don't worry adding AppMonitor framework in emebeded binaries section of your Xcode project will fix this issue.


2.If you are getting Invalid API key error 

2016-11-09 20:20:50.762 Test[2851:1610829] AppMonitor::INVALID API KEY
2016-11-09 20:20:50.867 Test[2851:1610829] *** Terminating app due to uncaught exception of class'__NSCFConstantString'
libc++abi.dylib: terminating with uncaught exception of type __NSCFConstantString
(lldb) 

######  You  will get this error when you have initialised with an invalid API key.


3.If you are SDK not initialied error 

2016-11-09 20:33:13.769 SampleApp[3142:1671162] AppMonitor::SDK NOT INIATIALIZED 

######  You have forgot to initialise SDK before usage.

## License

Check the license file 
