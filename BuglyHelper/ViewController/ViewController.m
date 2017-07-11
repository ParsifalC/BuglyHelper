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
#import "CPCrashInfo.h"
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
                                                 for (CPRealTimeCrashInfo *info in infos) {
                                                     allDes = [NSString stringWithFormat:@"%@\r\n%@", allDes, [info excelDescription]];
                                                 }
                                                 
                                                 NSLog(@"%@", allDes);
                                             }];
}

- (IBAction)fetchTrendBtnTapped:(NSButton *)sender {
    NSArray *array = [[CPDateHelper sharedHelper] dateStringBeforDate:[NSDate yesterday]
                                                                count:4];
    [CPNetworkService fetchCrashTrendSince:array.lastObject
                                        to:array.firstObject
                                appVersion:nil
                                     appId:kCPAppID
                                    appKey:kCPAppKey
                           completionBlock:^(CPCrashTrend *trend, NSError *error) {
                               if (!error) {
                                   NSLog(@"%@", trend.totalCrashInfo);
                               } else {
                                   NSLog(@"%@", error);
                               }
                           }];
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
