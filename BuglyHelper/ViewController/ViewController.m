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
                                     appId:@""
                                    appKey:@""
                           completionBlock:^(id responseObj, NSError *error) {
                               if (!error) {
                                   NSLog(@"%@", responseObj);
                               } else {
                                   NSLog(@"%@", error);
                               }
                           }];
}

@end
