//
//  AppMonitorManager.h
//  AppMonitor
//
//  Created by RAHUL CK on 11/5/16.
//  Copyright © 2016 Robosoft Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppMonitorManager : NSObject

-(NSInteger) getAppLaunchCount;

-(NSTimeInterval) getAppSpentTime;

-(void) startMonitor;

-(void) stopMonitor;

@end
