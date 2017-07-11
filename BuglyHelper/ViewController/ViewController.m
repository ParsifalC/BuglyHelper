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

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)calculateinfo {
    NSArray *dateArray = [[CPDateHelper sharedHelper] dateStringBeforDate:[NSDate yesterday]
                                                                count:7];
    NSMutableArray *mAllCrashInfos = @[].mutableCopy;
    for (NSString *dateStr in dateArray) {
        NSString *fileName = [NSString stringWithFormat:@"%@_%@23", kCPAppName, dateStr];
        NSString *path = [NSString pathForFile:fileName];
        CPRealTimeTrend *trend = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        [mAllCrashInfos addObjectsFromArray:trend.crashInfos];
    }
    
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@", dateArray.lastObject, dateArray.firstObject];
    
    NSMutableArray *mInfosInVersion = @[].mutableCopy;
    for (CPRealTimeCrashInfo *info in mAllCrashInfos) {
        CPRealTimeCrashInfo *infoInVersion = nil;
        for (CPRealTimeCrashInfo *cachedInfo in mInfosInVersion) {
            if ([cachedInfo.appVersion isEqualToString:info.appVersion]) {
                infoInVersion = cachedInfo;
                break;
            }
        }
        
        if (!infoInVersion) {
            infoInVersion = [info clone];
            infoInVersion.date = dateStr;
            [mInfosInVersion addObject:infoInVersion];
            continue;
        }
        
        infoInVersion.accessUser += info.accessUser;
        infoInVersion.accessNum += info.accessNum;
        infoInVersion.crashUser += info.crashUser;
        infoInVersion.crashNum += info.crashNum;
    }
    
    NSLog(@"%@", mInfosInVersion);
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

- (IBAction)calculateBtnTapped:(NSButton *)sender {
    [self calculateinfo];
}

- (IBAction)fetchTrendBtnTapped:(NSButton *)sender {
    NSArray *array = [[CPDateHelper sharedHelper] dateStringBeforDate:[NSDate date]
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
