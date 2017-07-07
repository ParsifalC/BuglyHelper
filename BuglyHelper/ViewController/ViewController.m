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

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

- (IBAction)btnTapped:(NSButton *)sender {
    NSArray *array = [[CPDateHelper sharedHelper] dateStringBeforDate:[NSDate date]
                                                                count:8];
    [CPNetworkService fetchCrashTrendSince:array.lastObject
                                        to:array.firstObject
                                appVersion:nil
                                     appId:@"0"
                                    appKey:@"0"
                           completionBlock:^(CPCrashTrend *trend, NSError *error) {
                               if (!error) {
                                   NSLog(@"%@", trend.totalCrashInfo);
                               } else {
                                   NSLog(@"%@", error);
                               }
                           }];
}

@end
