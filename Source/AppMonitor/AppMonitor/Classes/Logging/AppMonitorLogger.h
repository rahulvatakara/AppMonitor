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
 @param     logLevel , Logging level
 */
+(void) setLoggingLevel:(AppMonitorLogLevel)logLevel;

/*!
 @abstract  This method will log error message to console
 @param     format message to be logged
 */
+ (void)logError:(NSString *)format, ...;
/*!
 @abstract  This method will log warning message to console
 @param     format message to be logged
 */
+ (void)logWarning:(NSString *)format, ...;
/*!
 @abstract  This method will log message to console
 @param     format message to be logged
 */
+ (void)log:(NSString *)format, ...;

/*!
 @abstract  This method will log framework version and copy rights to console
 */
+(void) logVersionAndCopyRights;

@end
