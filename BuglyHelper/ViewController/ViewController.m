//
//  ViewController.m
//  BuglyHelper
//
//  Created by Parsifal on 2017/7/5.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

#import "ViewController.h"
#import "CPNetworkService.h"
#import "CPDateHelper.h"
#import "CPCrashTrend+Util.h"
#import "CPCrashInfo+Util.h"
#import "CPRealTimeTrend+Util.h"
#import "CPRealTimeCrashInfo+Util.h"
#import "NSString+Util.h"
#import "NSDate+Util.h"
#import "BuglyHelperMacro.h"
#import "CPCrashAnalysisHelper.h"

@implementation ViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
}
    
- (void)calculateinfo {
}
    
- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}
    
- (IBAction)calculateBtnTapped:(NSButton *)sender {
    [CPCrashAnalysisHelper analysisLocalCrashInfoThePastDays:7
                                             completionBlock:^(NSArray<CPRealTimeCrashInfo *> *infos) {
                                                 NSString *allDes = @"";
                                                 CPRealTimeCrashInfo *totalInfo = [CPRealTimeCrashInfo new];
                                                 totalInfo.appVersion = @"全版本";
                                                 for (CPRealTimeCrashInfo *info in infos) {
                                                     allDes = [NSString stringWithFormat:@"%@\r\n%@", allDes, [info excelDescription]];
                                                     if (![info.appVersion isEqualToString:@"-1"]) {
                                                         totalInfo.accessNum += info.accessNum;
                                                         totalInfo.accessUser += info.accessUser;
                                                         totalInfo.crashNum += info.crashNum;
                                                         totalInfo.crashUser += info.crashUser;
                                                     }
                                                 }
                                                 
                                                 allDes = [NSString stringWithFormat:@"%@\r\n%@", allDes, [totalInfo excelDescription]];
                                                 NSLog(@"%@", allDes);
                                             }];
}
    
- (IBAction)fetchTrendBtnTapped:(NSButton *)sender {
    NSArray *versionArray = @[@"-1",];
    
    __block NSString *str = @"";
    for (NSString *version in versionArray) {
        NSArray *array = [[CPDateHelper sharedHelper] dateStringBeforDate:[NSDate date]
                                                                    count:8];
        [CPNetworkService fetchCrashTrendSince:array.lastObject
                                            to:array.firstObject
                                    appVersion:version
                                         appId:kCPAppID
                                        appKey:kCPAppKey
                               completionBlock:^(CPCrashTrend *trend, NSError *error) {
                                   if (!error) {
                                       //                                       NSLog(@"%@", trend.totalCrashInfo.excelDescription);
                                       str = [NSString stringWithFormat:@"%@\r\n%@", str, trend.totalCrashInfo.excelDescription];
                                   } else {
                                       NSLog(@"%@", error);
                                   }
                               }];
        sleep(0.5);
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%@", str);
    });
}
    
- (IBAction)fetchInfoBtnTapped:(NSButton *)sender {
    NSArray *array = [[CPDateHelper sharedHelper] dateStringBeforDate:[NSDate yesterday]
                                                                count:3];
    for (NSString *dateStr in array) {
        [CPNetworkService fetchCrashInfoAtDate:dateStr
                                         appId:kCPAppID
                                        appKey:kCPAppKey
                               completionBlock:^(CPRealTimeTrend *trend, NSError *error) {
                                   if (!error) {
                                       NSLog(@"%@", trend.allAppVersion);
                                   } else {
                                       NSLog(@"%@", error);
                                   }
                               }];
        sleep(0.5);
    }
}
    
    
    @end
