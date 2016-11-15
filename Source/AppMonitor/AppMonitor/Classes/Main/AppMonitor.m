//
//  AppMonitor.m
//  AppMonitor
//
//  Created by RAHUL CK on 11/4/16.
//  Copyright © 2016 Robosoft Technologies Pvt Ltd. All rights reserved.
//

#import "AppMonitor.h"
#import "AppMonitorContants.h"
#import "AppMonitorLogger.h"
#import "AppMonitorEventManager.h"
#import "AppMonitorPersistanceManager.h"
#define  COPY_RIGHTS @"Copyright © 2016 Robosoft Technologies Pvt Ltd. All rights reserved."

static BOOL isInitialized = NO;

@interface AppMonitor ()
@property (nonatomic,strong) NSDate *startDate;
@property (nonatomic,assign) BOOL isAppActiveNow;
@end

@implementation AppMonitor

+ (AppMonitor *)sharedSDK
{
    static AppMonitor *appMonitor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appMonitor = [AppMonitor new];
    });
    
    return appMonitor;
}



+(void) initializeWithAPIKey:(NSString*)apiKey
{
    if ([[AppMonitor validAPIkeys] containsObject:apiKey]) {
        
        if (isInitialized)
            [AppMonitor throwExceptionWithErrorMessage:LOG_MESSAGE_SDK_ALREADY_INITIALIZED];
        
        else
        {
            isInitialized = YES;
            [AppMonitorLogger setLoggingLevel:AppMonitorLogLevelMinimal];
            [AppMonitorLogger logVersionAndCopyRights];
            [AppMonitorLogger log:LOG_MESSAGE_SDK_INITIALIZED];
            [[AppMonitor sharedSDK]startMonitor];
            [[AppMonitor sharedSDK]updateAppLaunchCount];
            
        }
    }
    else
        [AppMonitor throwExceptionWithErrorMessage:LOG_MESSAGE_SDK_ALREADY_INITIALIZED];
    
}
+(void) setLogLevel:(AppMonitorLogLevel)logLevel
{
    [AppMonitorLogger setLoggingLevel:logLevel];
}

+(void) postEvent:(NSString*) eventName withAttributes:(NSArray*)attributes
{
    if (isInitialized)
        [AppMonitorEventManager postEventWithName:eventName attributes:attributes];
    else
        [AppMonitor throwExceptionWithErrorMessage:LOG_MESSAGE_SDK_NOT_INITIALIZED];
    
}

+(NSInteger) appLaunchCount;
{
    
    if (isInitialized)
        return [AppMonitorPersistanceManager decryptAndRetrieveAppLaunchCount];
    
    else
        [AppMonitor throwExceptionWithErrorMessage:LOG_MESSAGE_SDK_NOT_INITIALIZED];
    
    return 0;
}

+(NSTimeInterval) appSpentTime
{
    
    if (isInitialized)
    {
        [[AppMonitor sharedSDK]updateAppSpentTime];
        return [AppMonitorPersistanceManager decryptAndRetrieveAppSpentTime];
    }
    else
        [AppMonitor throwExceptionWithErrorMessage:LOG_MESSAGE_SDK_NOT_INITIALIZED];
    
    return 0;
    
}
#pragma mark - Monitoring
-(void) startMonitor
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActiveNotification:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActiveNotification:)
                                                 name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveMemoryWarning)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];
}
-(void) stopMonitor
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillResignActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

#pragma mark-  Notification callbacks

-(void) applicationDidBecomeActiveNotification:(NSNotification*)notification
{
    self.startDate = [NSDate date];
    self.isAppActiveNow = YES;
    
}
-(void) applicationWillResignActiveNotification:(NSNotification*)notification
{
    [self updateAppSpentTime];
    self.isAppActiveNow = NO;
    
}
-(void) didReceiveMemoryWarning:(NSNotification*)notification
{
    [self stopMonitor];
}

-(void) updateAppSpentTime
{
    if (self.isAppActiveNow) {
        
        NSTimeInterval earlierSpentTime = [AppMonitorPersistanceManager decryptAndRetrieveAppSpentTime];
        NSTimeInterval spentTimeTillNow = fabs([self.startDate timeIntervalSinceDate:[NSDate date]])
        + earlierSpentTime;
        self.startDate = [NSDate date];
        [AppMonitorPersistanceManager encryptAndSaveAppSpentTime:spentTimeTillNow];
    }
}
-(void) updateAppLaunchCount
{
    NSInteger currentLuanchCount = [AppMonitorPersistanceManager decryptAndRetrieveAppLaunchCount];
    currentLuanchCount ++;
    [AppMonitorPersistanceManager encryptAndSaveAppLaunchCount:currentLuanchCount];
}

-(void)dealloc
{
    [self stopMonitor];
    NSString *logMessage = [NSString stringWithFormat:@"Deallocated %@",NSStringFromClass([self class])];
    [AppMonitorLogger log:logMessage];
}

+(NSString*) version
{
    return [NSString stringWithFormat:@"AppMonitor Version :%1.1f",AppMonitorVersionNumber];
}
+(NSString*) copyRighs
{
    return COPY_RIGHTS;
}


#pragma mark-Util Methods
+(void)throwExceptionWithErrorMessage:(NSString*)errorMessage
{
    [AppMonitorLogger logError:errorMessage];
    @throw NSInvalidArgumentException;
}

#pragma mark-API keys
+(NSArray*)validAPIkeys
{
    return @[@"12345",@"45678",@"abcde",@"abc123"];
}

@end
