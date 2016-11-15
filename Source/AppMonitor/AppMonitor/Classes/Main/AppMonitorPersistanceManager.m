//
//  AppMonitorEncryptionManager.m
//  AppMonitor
//
//  Created by Rahul CK on 11/11/16.
//  Copyright © 2016 Robosoft Technologies Pvt Ltd. All rights reserved.
//

#import "AppMonitorPersistanceManager.h"
#import "NSData+AES256.h"
#import "AppMonitorEncryptionKeys.h"

static NSString * const kAppLaunchCount = @"AppMonitorAppLaunchCount";
static NSString * const kAppSpentTime   = @"AppMonitorAppSpentTime";

@implementation AppMonitorPersistanceManager

+(void) encryptAndSaveAppLaunchCount:(NSInteger)appLaunchCount
{
    NSNumber *appLaunchCountNumber = [NSNumber numberWithInteger:appLaunchCount];
    NSData *unencrypedData = [NSKeyedArchiver archivedDataWithRootObject:appLaunchCountNumber];
    NSData *encrypedData = [unencrypedData AES256EncryptWithKey:AES_ENCRIPTION_KEY];
    [[NSUserDefaults standardUserDefaults]setObject:encrypedData forKey:kAppLaunchCount];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}
+(void) encryptAndSaveAppSpentTime:(NSTimeInterval)appSpentTime
{
    NSNumber *appSpentTimeNumber = [NSNumber numberWithDouble:appSpentTime];
    NSData *unencrypedData = [NSKeyedArchiver archivedDataWithRootObject:appSpentTimeNumber];
    NSData *encrypedData = [unencrypedData AES256EncryptWithKey:AES_ENCRIPTION_KEY];
    [[NSUserDefaults standardUserDefaults]setObject:encrypedData forKey:kAppSpentTime];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}
+(NSInteger) decryptAndRetrieveAppLaunchCount
{
    NSInteger appLauchCount = 0;
    
    NSData *encryptedData = [[NSUserDefaults standardUserDefaults]objectForKey:kAppLaunchCount];
    if (encryptedData) {
        NSData *unEcryptedData = [encryptedData AES256DecryptWithKey:AES_ENCRIPTION_KEY];
        appLauchCount = [[NSKeyedUnarchiver unarchiveObjectWithData:unEcryptedData]integerValue];
    }
    return appLauchCount;
}

+(NSTimeInterval) decryptAndRetrieveAppSpentTime
{
    NSTimeInterval appSpentTime = 0;
    NSData *encryptedData = [[NSUserDefaults standardUserDefaults]objectForKey:kAppSpentTime];
    
    if (encryptedData) {
        NSData *unEcryptedData = [encryptedData AES256DecryptWithKey:AES_ENCRIPTION_KEY];
        appSpentTime = [[NSKeyedUnarchiver unarchiveObjectWithData:unEcryptedData]doubleValue];
    }
    
    return appSpentTime;
    
}
@end
