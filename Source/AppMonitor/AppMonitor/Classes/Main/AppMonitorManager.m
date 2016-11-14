//
//  AppMonitorManager.m
//  AppMonitor
//
//  Created by RAHUL CK on 11/5/16.
//  Copyright © 2016 Robosoft Technologies Pvt Ltd. All rights reserved.
//

#import "AppMonitorManager.h"
#import "AppMonitorLogger.h"
#import "AppMonitorContants.h"
#import "AppMonitorPersistanceManager.h"

@interface AppMonitorManager ()

@property (nonatomic, assign) BOOL isMonitoring;

@property (nonatomic, strong) NSDate *startDate;



@end
@implementation AppMonitorManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isMonitoring = NO;
        NSInteger currentLuanchCount = [AppMonitorPersistanceManager decryptAndRetrieveAppLaunchCount];
        currentLuanchCount ++;
        [AppMonitorPersistanceManager encryptAndSaveAppLaunchCount:currentLuanchCount];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveMemoryWarning)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
    }
    return self;
}

-(NSInteger) appLaunchCount
{
    NSInteger currentLuanchCount = 0;
    
    @try {
        
        //This will start monitoting if it is not already monitoring
        [self startMonitor];
        
        currentLuanchCount = [AppMonitorPersistanceManager decryptAndRetrieveAppLaunchCount];
        
    } @catch (NSException *exception) {
        
        currentLuanchCount = -1;
        [AppMonitorLogger logWithLogLevel:AppMonitorLoggingLevelErrors
                                   message:@"%@",LOG_MESSAGE_SDK_UNKNOW_ERROR_OCCURED];
        
    }
    return currentLuanchCount;
}

-(NSTimeInterval) appSpentTime
{
    NSTimeInterval spentTimeTillNow = 0;
  
    @try {
       
        //This will start monitoting if it is not already monitoring
        [self startMonitor];
        
        [self updateAppSpentTime];
        spentTimeTillNow = [AppMonitorPersistanceManager decryptAndRetrieveAppSpentTime];
    }
    @catch (NSException *exception) {
        spentTimeTillNow = -1;
        [AppMonitorLogger logWithLogLevel:AppMonitorLoggingLevelErrors
                                  message:@"%@",LOG_MESSAGE_SDK_UNKNOW_ERROR_OCCURED];
    }

    return spentTimeTillNow;
}
-(void) startMonitor
{
    
        if (!_isMonitoring) {
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(applicationDidBecomeActiveNotification:)
                                                         name:UIApplicationDidBecomeActiveNotification object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(applicationWillResignActiveNotification:)
                                                         name:UIApplicationWillResignActiveNotification object:nil];
            _isMonitoring = YES;
        }
    
}

-(void) stopMonitor
{
        if (_isMonitoring) {
            
            [[NSNotificationCenter defaultCenter] removeObserver:self
                                                            name:UIApplicationDidBecomeActiveNotification object:nil];
            
            [[NSNotificationCenter defaultCenter] removeObserver:self
                                                            name:UIApplicationWillResignActiveNotification object:nil];
        
            _isMonitoring = NO;
    }
}
-(void) updateAppSpentTime
{
    NSTimeInterval earlierSpentTime = [AppMonitorPersistanceManager decryptAndRetrieveAppSpentTime];
    NSTimeInterval spentTimeTillNow = fabs([self.startDate timeIntervalSinceDate:[NSDate date]])
    + earlierSpentTime;
    self.startDate = [NSDate date];
    
    [AppMonitorPersistanceManager encryptAndSaveAppSpentTime:spentTimeTillNow];
}
-(void)dealloc
{
    [self stopMonitor];
    NSString *logMessage = [NSString stringWithFormat:@"Deallocated %@",NSStringFromClass([self class])];
    [AppMonitorLogger logWithLogLevel:AppMonitorLoggingLevelAllLogs
                              message:@"%@",logMessage];
}
-(void) didReceiveMemoryWarning:(NSNotification*)notification
{
    [self stopMonitor];
}

#pragma mark -AppState Notification
- (void)applicationDidBecomeActiveNotification:(NSNotification *)notification
{
    self.startDate = [NSDate date];
}
- (void)applicationWillResignActiveNotification:(NSNotification *)notification
{
    [self updateAppSpentTime];
}


@end
