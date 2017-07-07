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
             @"crashNum": @"crash_num",
             @"crashUser": @"crash_user",
             @"appVersion": @"app_version",
             @"appVersion": @"productVersion",
             @"date": @"date",
             @"date": @"dateTime",
             };
}

@end
