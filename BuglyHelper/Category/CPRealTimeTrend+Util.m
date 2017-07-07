//
//  CPRealTimeTrend+Util.m
//  BuglyHelper
//
//  Created by Parsifal on 2017/7/7.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

#import "CPRealTimeTrend+Util.h"
#import "CPRealTimeCrashInfo.h"

@implementation CPRealTimeTrend (Util)

- (NSArray *)allAppVersion {
    NSMutableArray *versionArray = @[].mutableCopy;
    
    for (CPRealTimeCrashInfo *info in self.crashInfos) {
        if (info.appVersion) {
            [versionArray addObject:info.appVersion];
        }
    }
    
    return versionArray;
}

@end
