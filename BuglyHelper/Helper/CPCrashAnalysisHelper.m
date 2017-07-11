//
//  CPCrashAnalysisHelper.m
//  BuglyHelper
//
//  Created by Parsifal on 2017/7/11.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

#import "CPCrashAnalysisHelper.h"
#import "CPRealTimeCrashInfo+Util.h"
#import "NSString+Util.h"
#import "BuglyHelperMacro.h"
#import "CPDateHelper.h"
#import "NSDate+Util.h"
#import "CPRealTimeTrend+Util.h"

@implementation CPCrashAnalysisHelper

+ (void)analysisLocalCrashInfoThePastDays:(NSUInteger)dayCount
                          completionBlock:(CPAnalysisResultBlock)block {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *dateArray = [[CPDateHelper sharedHelper] dateStringBeforDate:[NSDate yesterday]
                                                                        count:dayCount];
        NSMutableArray *mAllCrashInfos = @[].mutableCopy;
        for (NSString *dateStr in dateArray) {
            NSString *fileName = [NSString stringWithFormat:@"%@23", dateStr];
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
        
        dispatch_async(dispatch_get_main_queue(), ^{
            !block?:block(mInfosInVersion);
        });
    });
}

@end
