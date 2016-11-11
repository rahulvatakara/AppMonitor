//
//  AppMonitor.m
//  AppMonitor
//
//  Created by RAHUL CK on 11/4/16.
//  Copyright © 2016 Robosoft Technologies Pvt Ltd. All rights reserved.
//

#import "AppMonitor.h"
#import "AppMonitorContants.h"
#import "AppMonitorManager.h"
#import "AppMonitorLogger.h"
#import "AppMonitorEventManager.h"

#define  COPY_RIGHTS @"Copyright © 2016 Robosoft Technologies Pvt Ltd. All rights reserved."

@interface AppMonitor ()

@property (nonatomic,assign) BOOL isInitialized;

@property (nonatomic ,strong) AppMonitorManager *monitorManager;

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

-(instancetype) init
{
    self = [super init];
   
    if (self) {
        self.isInitialized = NO;
        
        self.monitorManager = [[AppMonitorManager alloc]init];
    }
    return self;
}

+(void) initializeWithAPIKey:(NSString*)apiKey logLevel:(AppMonitorLoggingLevel)inLogLevel
{
    if ([[self validAPIkeys] containsObject:apiKey]) {
       
        if ([[AppMonitor sharedSDK]isInitialized]) {
          
           [AppMonitorLogger logWithLogLevel:AppMonitorLoggingLevelMinimal message:LOG_MESSAGE_SDK_ALREADY_INITIALIZED];
            

        }
        else
        {
            [[AppMonitor sharedSDK]setIsInitialized:YES];
            [AppMonitorLogger setLoggingLevel:inLogLevel];
            [AppMonitorLogger LogFrameworkVersion];
            [AppMonitorLogger LogFrameworkCopyRights];

            [AppMonitorLogger logWithLogLevel:AppMonitorLoggingLevelAllLogs message:LOG_MESSAGE_SDK_INITIALIZED];
            [[[AppMonitor sharedSDK]monitorManager]startMonitor];

        }
    }
    else
    {
        [AppMonitorLogger logWithLogLevel:AppMonitorLoggingLevelErrors message:LOG_MESSAGE_SDK_INVALID_APIKEY];
        
        @throw NSInvalidArgumentException;
    }
    
}
-(void) postEvent:(NSString*) eventName withAttributes:(NSArray*)attributes
{
    if ([self isInitialized])
    {
    
        [AppMonitorEventManager postEventWithName:eventName attributes:attributes];
    }
    else
    {
        [AppMonitorLogger logWithLogLevel:AppMonitorLoggingLevelErrors message:LOG_MESSAGE_SDK_NOT_INITIALIZED];
        
        @throw NSInvalidArgumentException;


    }
}

-(NSInteger) appLaunchCount
{
    NSInteger appLaunchCount = 0;
    
    if ([self isInitialized])
    {
        appLaunchCount = [self.monitorManager appLaunchCount];
        
    }
    else
    {
        [AppMonitorLogger logWithLogLevel:AppMonitorLoggingLevelErrors message:LOG_MESSAGE_SDK_NOT_INITIALIZED];

        @throw NSInvalidArgumentException;

    }
    return appLaunchCount;
}

-(NSTimeInterval) appSpentTime
{
    NSTimeInterval appSpentTime = 0.0;
   
    if ([self isInitialized])
    {
        appSpentTime = [self.monitorManager appSpentTime];
        
    }
    else
    {
        [AppMonitorLogger logWithLogLevel:AppMonitorLoggingLevelErrors message:LOG_MESSAGE_SDK_NOT_INITIALIZED];
        
        @throw NSInvalidArgumentException;


    }
    return appSpentTime;

}

-(void)dealloc
{
    NSString *logMessage = [NSString stringWithFormat:@"Deallocated %@",NSStringFromClass([self class])];
    [AppMonitorLogger logWithLogLevel:AppMonitorLoggingLevelAllLogs message:logMessage];
}
#pragma mark - Framework Details
-(NSString*) framewokVersion
{
    return [NSString stringWithFormat:@"AppMonitor Version :%1.1f",AppMonitorVersionNumber];
}

-(NSString*) framewokCopyRight
{
    return COPY_RIGHTS;
}

#pragma mark-API keys
+(NSArray*)validAPIkeys
{
    return @[@"12345",@"45678",@"abcde",@"abc123"];
}
@end
