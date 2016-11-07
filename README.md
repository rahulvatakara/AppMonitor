# AppMonitor

AppMonitor is a framewok which can be used for monitoring your app launch count and app spent time

Instalation 
AppMonitor provides two type of integration

CocoaPod Integration

Podfile

To integrate AFNetworking into your Xcode project using CocoaPods, specify it in your Podfile:

source 'https://github.com/rahulvatakara/AppMonitor.git'
platform :ios, '8.0'

target 'TargetName' do
pod 'AppMonitor', '~> 1.0'
end


Manual Integration
Copy and link AppMonitor.framework to your Xcode project


Usage

Initialise framwork
    [AppMonitor initializeWithAPIKey:<YOUR_APPID> logLevel:AppMonitorLoggingLevelAllLogs];
	

Getting App Count

[[AppMonitor sharedSDK]getAppLaunchCount]]

Getting App Spet time

[[AppMonitor sharedSDK]getAppSpentTime]]
	
