//
//  AppMonitorLogger.m
//  AppMonitor
//
//  Created by RAHUL CK on 11/4/16.
//  Copyright © 2016 Robosoft Technologies Pvt Ltd. All rights reserved.
//

#import "AppMonitorLogger.h"
#import "AppMonitor.h"

#define TAG  @"AppMonitor"

static AppMonitorLogLevel logLevel;

@implementation AppMonitorLogger

+(void)setLoggingLevel:(AppMonitorLogLevel)inLogLevel
{
    logLevel = inLogLevel;
}
+ (void)logError:(NSString *)format, ...
{
    va_list args;
    va_start(args, format);
    NSLogv(format, args);
    va_end(args);
}


+ (void)logWarning:(NSString *)format, ...
{
  #ifdef DEBUG
    va_list args;
    va_start(args, format);
    NSLogv(format, args);
    va_end(args);
  #endif

}

+ (void)log:(NSString *)format, ...
{
   #ifdef DEBUG
    va_list args;
    va_start(args, format);
    NSLogv(format, args);
    va_end(args);
    #endif
}

+(void) logVersionAndCopyRights;
{
    NSLog(@"%@ \n %@",[AppMonitor version],[AppMonitor copyRighs]);
}

@end
