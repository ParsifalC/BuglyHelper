//
//  CPCrashTrend+Util.m
//  BuglyHelper
//
//  Created by Parsifal on 2017/7/7.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

#import "CPCrashTrend+Util.h"
#import "CPCrashInfo.h"
#import "NSString+Util.h"

@implementation CPCrashTrend (Util)

- (CPCrashInfo *)totalCrashInfo {
    CPCrashInfo *totalInfo = [CPCrashInfo new];
    CPCrashInfo *firstInfo = self.crashInfos.firstObject;
    CPCrashInfo *lastInfo = self.crashInfos.lastObject;
    totalInfo.appVersion = firstInfo.appVersion;
    totalInfo.date = [NSString stringWithFormat:@"%@-%@", lastInfo.date, firstInfo.date];
    
    for (CPCrashInfo *info in self.crashInfos) {
        totalInfo.accessNum = [info.accessNum plus:totalInfo.accessNum];
        totalInfo.accessUser = [info.accessUser plus:totalInfo.accessUser];
        totalInfo.crashNum = [info.crashNum plus:totalInfo.crashNum];
        totalInfo.crashUser = [info.crashUser plus:totalInfo.crashUser];
    }
    
    return totalInfo;
}

@end
