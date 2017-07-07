//
//  CPCrashInfo.m
//  BuglyHelper
//
//  Created by Parsifal on 2017/7/6.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

#import "CPCrashInfo.h"

@implementation CPCrashInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"accessNum": @"access_num",
             @"accessUser": @"access_user",
             @"appVersion": @"app_version",
             @"crashNum": @"crash_num",
             @"crashUser": @"crash_user",
             @"date": @"date",
             };
}

@end
