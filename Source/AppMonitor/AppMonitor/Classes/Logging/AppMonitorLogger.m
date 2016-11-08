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

@interface AppMonitorLogger ()
{
    AppMonitorLoggingLevel loggingLevel;

}
@end

@implementation AppMonitorLogger

+ (AppMonitorLogger *)shared {
    
    static AppMonitorLogger *appMonitorLogger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        appMonitorLogger = [AppMonitorLogger new];
    });
    
    return appMonitorLogger;
}
-(instancetype) init
{
    self = [super init];
    
    if (self) {
        
        loggingLevel = AppMonitorLoggingLevelMinimal;
    }
    return self;
}
-(void)setLoggingLevel:(AppMonitorLoggingLevel)inLoggingLevel
{
    loggingLevel = inLoggingLevel;
}
-(void) Log:(NSString*)logMessage withLogLevel:(AppMonitorLoggingLevel)inLogLevel
{
   #ifdef DEBUG
    if (inLogLevel >= loggingLevel) {
        NSLog(@"%@::%@",TAG,logMessage);
    }
   #else
    //RELEASE
    if (inLogLevel == AppMonitorLoggingLevelErrors) {
       
        NSLog(@"%@::%@",TAG,logMessage);

    }
  #endif
}
-(void) LogFrameworkCopyRights
{
    NSLog(@"%@", [[AppMonitor sharedSDK]getFramewokCopyRight]);
}

-(void) LogFrameworkVersion
{
    NSLog(@"%@", [[AppMonitor sharedSDK]getFramewokVersion]);
    
}
@end
