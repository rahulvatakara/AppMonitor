//
//  AppMonitorLogger.h
//  AppMonitor
//
//  Created by RAHUL CK on 11/4/16.
//  Copyright © 2016 Robosoft Technologies Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppMonitor.h"


@interface AppMonitorLogger : NSObject

/*!
 @abstract  This method will return the singleton instance of AppMonitorLogger
 */
+ (AppMonitorLogger *)shared;

/*!
 @abstract  This method set logging level
 @param     loggingLevel Logging level
 */
-(void) setLoggingLevel:(AppMonitorLoggingLevel)loggingLevel;

/*!
 @abstract  This method will log message to console
 @param     logMessage message to be logged
 @param     logLevel Logging level
 */
-(void) Log:(NSString*)logMessage withLogLevel:(AppMonitorLoggingLevel)logLevel;


/*!
 @abstract  This method will log framework copy rights to console
 */
-(void) LogFrameworkCopyRights;


/*!
 @abstract  This method will log framework version to console
  */
-(void) LogFrameworkVersion;


@end
