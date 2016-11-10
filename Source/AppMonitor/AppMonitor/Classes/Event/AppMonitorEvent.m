//
//  AppMonitorEvent.m
//  AppMonitor
//
//  Created by RAHUL CK on 11/4/16.
//  Copyright © 2016 Robosoft Technologies Pvt Ltd. All rights reserved.
//

#import "AppMonitorEvent.h"
#import "AppMonitorLogger.h"
#import "AppMonitorContants.h"

NSString* const kEventKey = @"kEventKey";

@implementation AppMonitorEvent

-(instancetype) initWithName:(NSString*)name attributes:(NSArray*)attributes
{
    self = [super init];
    if (self) {
        self.eventName = name;
        self.attributes = attributes;
    }
    return self;
}
-(void) postEvent
{
    
    NSString *postEvent = [NSString stringWithFormat:@"Event with name :%@ attributes : %@",
                           self.eventName,self.attributes];
    
    @try {
        [[NSUserDefaults standardUserDefaults] setObject:postEvent forKey:kEventKey];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    @catch (NSException *exception) {
      
        [[AppMonitorLogger shared]Log:LOG_MESSAGE_SDK_UNKNOW_ERROR_OCCURED
                         withLogLevel:AppMonitorLoggingLevelErrors];
    }
    
    
    
    [[AppMonitorLogger shared]Log:postEvent withLogLevel:AppMonitorLoggingLevelMinimal];
}
-(void)dealloc
{
    NSString *logMessage = [NSString stringWithFormat:@"Deallocated %@",NSStringFromClass([self class])];
    [[AppMonitorLogger shared]Log:logMessage withLogLevel:AppMonitorLoggingLevelAllLogs];
}
@end
