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
 @abstract  This method set logging level
 @param     loggingLevel Logging level
 */
+(void) setLoggingLevel:(AppMonitorLoggingLevel)loggingLevel;

/*!
 @abstract  This method will log message to console
 @param     logLevel Logging level
 @param     format message to be logged
 */
+ (void)logWithLogLevel:(AppMonitorLoggingLevel)logLevel  message:(NSString *)format, ...;

/*!
 @abstract  This method will log framework copy rights to console
 */
+(void) LogFrameworkCopyRights;

/*!
 @abstract  This method will log framework version to console
  */
+(void) LogFrameworkVersion;


@end
