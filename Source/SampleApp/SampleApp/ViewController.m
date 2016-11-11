//
//  ViewController.m
//  SampleApp
//
//  Created by RAHUL CK on 11/4/16.
//  Copyright © 2016 Robosoft Technologies Pvt Ltd. All rights reserved.
//

#import "ViewController.h"
#import <AppMonitor/AppMonitor.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *appLauchCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *appSpentTimeLabel;
@property (strong,nonatomic) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.appLauchCountLabel.text = [NSString stringWithFormat:@"%ld",(long)[[AppMonitor sharedSDK]appLaunchCount]];
    self.appSpentTimeLabel.text = [NSString stringWithFormat:@"%f",[[AppMonitor sharedSDK]appSpentTime]];
    
    __block ViewController *weakSelf = self;
  
     self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
         weakSelf.appSpentTimeLabel.text = [NSString stringWithFormat:@"%f",[[AppMonitor sharedSDK]appSpentTime]];
     }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.timer fire];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [self.timer invalidate];
}
- (IBAction)updateDetailClicked:(id)sender
{
    self.appLauchCountLabel.text = [NSString stringWithFormat:@"%ld",(long)[[AppMonitor sharedSDK]appLaunchCount]];
    self.appSpentTimeLabel.text = [NSString stringWithFormat:@"%f",[[AppMonitor sharedSDK]appSpentTime]];

}
- (IBAction)postEventClicked:(id)sender
{
    [[AppMonitor sharedSDK]postEvent:@"Test" withAttributes:@[@"arg1",@"arg2"]];
}

@end
