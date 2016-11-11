//
//  AppMonitorEvent.h
//  AppMonitor
//
//  Created by RAHUL CK on 11/4/16.
//  Copyright © 2016 Robosoft Technologies Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppMonitorEventManager : NSObject

/*!
 @abstract  Post Event with Name and attributes
 */
+(void) postEventWithName:(NSString*)eventName attributes:(NSArray*)attributes;

@end
