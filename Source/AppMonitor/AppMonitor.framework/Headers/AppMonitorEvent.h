//
//  AppMonitorEvent.h
//  AppMonitor
//
//  Created by RAHUL CK on 11/4/16.
//  Copyright © 2016 Robosoft Technologies Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppMonitorEvent : NSObject

@property (nonatomic ,strong) NSString *eventName;
@property (nonatomic ,strong) NSArray *attributes;

-(instancetype) initWithName:(NSString*)name attributes:(NSArray*)attributes;

-(void) postEvent;

@end
