//
//  AppMonitorEncryptionManager.h
//  AppMonitor
//
//  Created by Rahul CK on 11/11/16.
//  Copyright © 2016 Robosoft Technologies Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppMonitorPersistanceManager : NSObject

/*!
 @abstract  Encrypt and save app launch count
 @param     appLaunchCount App Lauch count
 */

+(void) encryptAndSaveAppLaunchCount:(NSInteger)appLaunchCount;
/*!
 @abstract  Encrypt and save app app spent time
 @param     appSpentTime App Spent time
 */

+(void) encryptAndSaveAppSpentTime:(NSTimeInterval)appSpentTime;

/*!
 @abstract  Decrypt and return app launch count
 @return appLaunch Count
 */

+(NSInteger) decryptAndRetrieveAppLaunchCount;
/*!
 @abstract  Decrypt and return app Spent time
 @return appSpentTime
 */

+(NSTimeInterval) decryptAndRetrieveAppSpentTime;

@end
