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
 @enum      AppMonitorLogLevel
 @abstract  AppMonitor Logging Level
 @field     AppMonitorLoggingLevelErrors, Enable error logs only
 @field     AppMonitorLoggingLevelMinimal, Enable  minimal logs only
 @field     AppMonitorLogLevelAllLogs, Enable all types of logs
 */
typedef NS_ENUM(NSUInteger, AppMonitorLogLevel) {
    AppMonitorLogLevelErrors,
    AppMonitorLogLevelMinimal,
    AppMonitorLogLevelAllLogs
};

@interface AppMonitor : NSObject

/*
 @function   initializeWithAPIKey:
 @abstract  This method will initialise the sdk.SDK should be initialised before calling any other apis
 @param     apiKey, Valid api key need for initialising the SDK.
 */

+(void) initializeWithAPIKey:(NSString*)apiKey;

/*
 @function   setLogLevel:
 @abstract  This method will initialise the sdk.SDK should be initialised before calling any other apis
 @param     logLevel, Desired logLevel.
 */
+(void) setLogLevel:(AppMonitorLogLevel)logLevel;
/*!
 @abstract  This method will post event
 @param     eventName name of the event
 @param     attributes for event
 */
+(void) postEvent:(NSString*) eventName withAttributes:(NSArray*)attributes;

/*!
 @abstract  This method will reurn app launch count
 @return    AppLaunchCount
 */
+(NSInteger) appLaunchCount;

/*!
 @abstract  This method will return app spent time in seconds
 @return    App spent time
 */
+(NSTimeInterval) appSpentTime;
/*!
 @abstract  This method will return the framework version
 @return    Framework Version
 */
+(NSString*) version;
/*!
 @abstract  This method will return the framework copy right
 @return    Framework Copy rights
 */
+(NSString*) copyRighs;
@end
