//
//  AppMonitorLogger.h
//  AppMonitor
//
//  Created by RAHUL CK on 11/4/16.
//  Copyright © 2016 Robosoft Technologies Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

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
@interface AppMonitorLogger : NSObject

+ (AppMonitorLogger *)shared;

-(void) setLoggingLevel:(AppMonitorLoggingLevel)loggingLevel;

-(void) Log:(NSString*)logMessage withLogLevel:(AppMonitorLoggingLevel)logLevel;

@end
