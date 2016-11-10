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
static NSString * const kAppLaunchCount = @"AppMonitorAppLaunchCount";
static NSString * const kAppSpentTime   = @"AppMonitorAppSpentTime";


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
      
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
        NSInteger currentLuanchCount = [[[NSUserDefaults standardUserDefaults]objectForKey:
                                         kAppLaunchCount]integerValue];
         currentLuanchCount ++;
        [[NSUserDefaults standardUserDefaults]setObject:
             [NSNumber numberWithInteger:currentLuanchCount] forKey:kAppLaunchCount];
            
        });
    }
    return self;
}

-(NSInteger) appLaunchCount
{
    NSInteger currentLuanchCount = 0;
    
    @try {
        currentLuanchCount = [[[NSUserDefaults standardUserDefaults]objectForKey:
                               kAppLaunchCount]integerValue];
        
    } @catch (NSException *exception) {
        
        currentLuanchCount = -1;
        [[AppMonitorLogger shared]Log:LOG_MESSAGE_SDK_UNKNOW_ERROR_OCCURED
                         withLogLevel:AppMonitorLoggingLevelErrors];
        
    }
    return currentLuanchCount;
}

-(NSTimeInterval) appSpentTime
{
    NSTimeInterval spentTimeTillNow = 0;
  
    @try {
        [self updateAppSpentTime];
        spentTimeTillNow = [[[NSUserDefaults standardUserDefaults]objectForKey:kAppSpentTime]
                            doubleValue];
    }
    @catch (NSException *exception) {
        spentTimeTillNow = -1;
        [[AppMonitorLogger shared]Log:LOG_MESSAGE_SDK_UNKNOW_ERROR_OCCURED
                         withLogLevel:AppMonitorLoggingLevelErrors];
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
-(void)dealloc
{
    NSString *logMessage = [NSString stringWithFormat:@"Deallocated %@",NSStringFromClass([self class])];
    [[AppMonitorLogger shared]Log:logMessage withLogLevel:AppMonitorLoggingLevelAllLogs];
}
-(void) updateAppSpentTime
{
    NSTimeInterval earlierSpentTime = [[[NSUserDefaults standardUserDefaults]objectForKey:kAppSpentTime]
                                       doubleValue];
    NSTimeInterval spentTimeTillNow = fabs([self.startDate timeIntervalSinceDate:[NSDate date]])
                                       + earlierSpentTime;
    
    
    [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithDouble:spentTimeTillNow]
                                             forKey:kAppSpentTime];
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
