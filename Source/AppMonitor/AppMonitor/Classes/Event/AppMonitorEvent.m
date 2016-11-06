//
//  AppMonitorEvent.m
//  AppMonitor
//
//  Created by RAHUL CK on 11/4/16.
//  Copyright © 2016 Robosoft Technologies Pvt Ltd. All rights reserved.
//

#import "AppMonitorEvent.h"
#import "AppMonitorLogger.h"

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
    
    [[AppMonitorLogger shared]Log:postEvent withLogLevel:AppMonitorLoggingLevelMinimal];
}
-(void)dealloc
{
    NSString *logMessage = [NSString stringWithFormat:@"Deallocated %@",NSStringFromClass([self class])];
    [[AppMonitorLogger shared]Log:logMessage withLogLevel:AppMonitorLoggingLevelAllLogs];
}
@end
