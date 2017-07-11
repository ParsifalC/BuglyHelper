//
//  CPCrashAnalysisHelper.h
//  BuglyHelper
//
//  Created by Parsifal on 2017/7/11.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CPRealTimeCrashInfo;
typedef void(^CPAnalysisResultBlock)(NSArray<CPRealTimeCrashInfo *> *infos);

@interface CPCrashAnalysisHelper : NSObject

+ (void)analysisLocalCrashInfoThePastDays:(NSUInteger)dayCount
                          completionBlock:(CPAnalysisResultBlock)block;

@end
