//
//  AppMonitor.h
//  AppMonitor
//
//  Created by RAHUL CK on 11/4/16.
//  Copyright © 2016 Robosoft Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for AppMonitor.
FOUNDATION_EXPORT double AppMonitorVersionNumber;

//! Project version string for AppMonitor.
FOUNDATION_EXPORT const unsigned char AppMonitorVersionString[];

/*!
 @enum      AppMonitorLoggingLevel
 @abstract  AppMonitor Logging Level
 @field     AppMonitorLoggingLevelAllLogs, Enable all types of logs
 @field     AppMonitorLoggingLevelMinimal, Enable  minimal logs only
 @field     AppMonitorLoggingLevelErrors, Enable error logs only
 */
typedef NS_ENUM(NSUInteger, AppMonitorLoggingLevel) {
    AppMonitorLoggingLevelAllLogs,
    AppMonitorLoggingLevelMinimal,
    AppMonitorLoggingLevelErrors
};


@interface AppMonitor : NSObject

/**
 * @abstract  This method will return the singleton instance of SDK
 */
+ (AppMonitor *)sharedSDK;

/*
 @function   initializeWithAPIKey:logLevel:
 @abstract  This method will initialise the sdk.SDK should be initialised before calling any other apis
 @param     apiKey, Valid api key need for initialising the SDK.
 @param     logLevel,Logging level
 */
+(void) initializeWithAPIKey:(NSString*)apiKey logLevel:(AppMonitorLoggingLevel)logLevel;

/*!
 @abstract  This method will post event
 @param     eventName name of the event
 @param     attributes for event
 */
-(void) postEvent:(NSString*) eventName withAttributes:(NSArray*)attributes;

/*!
 @abstract  This method will reurn app launch count
 @return    AppLaunchCount
 */
-(NSInteger) appLaunchCount;

/*!
 @abstract  This method will return app spent time
 @return    App spent time
 */
-(NSTimeInterval) appSpentTime;
/*!
 @abstract  This method will return the framework version
 @return    Framework Version
 */
-(NSString*) framewokVersion;

/*!
 @abstract  This method will return the copy rights
 @return    Framework CopyRight
 */
-(NSString*) framewokCopyRight;


@end
