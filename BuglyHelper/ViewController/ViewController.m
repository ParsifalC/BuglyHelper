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
#import "CPRealTimeTrend+Util.h"

static NSString * const kCPAppID = @"";
static NSString * const kCPAppKey = @"";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

- (IBAction)fetchTrendBtnTapped:(NSButton *)sender {
    NSArray *array = [[CPDateHelper sharedHelper] dateStringBeforDate:[NSDate date]
                                                                count:8];
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
    [CPNetworkService fetchCrashInfoAtDate:@"20170705"
                                     appId:kCPAppID
                                    appKey:kCPAppKey
                           completionBlock:^(CPRealTimeTrend *trend, NSError *error) {
                               if (!error) {
                                   NSLog(@"%@", trend);
                                   NSLog(@"%@", trend.allAppVersion);
                               } else {
                                   NSLog(@"%@", error);
                               }
                           }];
}

@end
