//
//  AppMonitorManager.h
//  AppMonitor
//
//  Created by RAHUL CK on 11/5/16.
//  Copyright © 2016 Robosoft Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppMonitorManager : NSObject

/*!
 @abstract  Returns app launch count
 @return    appLaunchCount
 */
-(NSInteger) appLaunchCount;

/*!
 @abstract   Returns app spent time
 @return     appSpentTime
 */
-(NSTimeInterval) appSpentTime;

/*!
 @abstract  Start monitoring the app
 */
-(void) startMonitor;

/*!
 @abstract  Stop monitoring the app
 */
-(void) stopMonitor;

@end
