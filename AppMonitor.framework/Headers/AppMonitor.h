//
//  AppMonitor.h
//  AppMonitor
//
//  Created by RAHUL CK on 11/4/16.
//  Copyright © 2016 Robosoft Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for AppMonitor.
FOUNDATION_EXPORT double AppMonitorVersionNumber;

//! Project version string for AppMonitor.
FOUNDATION_EXPORT const unsigned char AppMonitorVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <AppMonitor/PublicHeader.h>

#import <AppMonitor/AppMonitorLogger.h>
#import <AppMonitor/AppMonitorEvent.h>



@interface AppMonitor : NSObject

+ (AppMonitor *)sharedSDK;

+(void) initializeWithAPIKey:(NSString*)apiKey logLevel:(AppMonitorLoggingLevel)logLevel;

-(void) postEvent:(NSString*) eventName withAttributes:(NSArray*)attributes;

-(NSInteger) getAppLaunchCount;

-(NSTimeInterval) getAppSpentTime;

-(NSString*) getFramewokVersion;

-(NSString*) getFramewokCopyRight;


@end
