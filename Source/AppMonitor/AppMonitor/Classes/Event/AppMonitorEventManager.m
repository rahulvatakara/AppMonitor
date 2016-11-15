//
//  AppMonitorEvent.m
//  AppMonitor
//
//  Created by RAHUL CK on 11/4/16.
//  Copyright © 2016 Robosoft Technologies Pvt Ltd. All rights reserved.
//

#import "AppMonitorEventManager.h"
#import "AppMonitorLogger.h"
#import "AppMonitorContants.h"

NSString* const kEventKey = @"kEventKey";

@implementation AppMonitorEventManager


+(void) postEventWithName:(NSString*)eventName attributes:(NSArray*)attributes;
{
    
    NSString *postEvent = [NSString stringWithFormat:@"Event with name :%@ attributes : %@",
                           eventName,attributes];

    [AppMonitorLogger log:@"%@",postEvent];
}

@end
