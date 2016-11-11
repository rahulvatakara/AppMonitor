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

static AppMonitorLoggingLevel loggingLevel;

@implementation AppMonitorLogger

+(void)setLoggingLevel:(AppMonitorLoggingLevel)inLoggingLevel
{
    loggingLevel = inLoggingLevel;
}
+ (void)logWithLogLevel:(AppMonitorLoggingLevel)inLogLevel  message:(NSString *)format, ...
{
#ifdef DEBUG
    if (inLogLevel >= loggingLevel) {
        va_list args;
        va_start(args, format);
        NSLogv(format, args);
        va_end(args);    }
#else
    //RELEASE
    if (inLogLevel == AppMonitorLoggingLevelErrors) {
        va_list args;
        va_start(args, format);
        NSLogv(format, args);
        va_end(args);
    }
#endif
}

+(void) LogFrameworkCopyRights
{
    NSLog(@"%@", [[AppMonitor sharedSDK]framewokCopyRight]);
}

+(void) LogFrameworkVersion
{
    NSLog(@"%@", [[AppMonitor sharedSDK]framewokVersion]);
    
}
@end
