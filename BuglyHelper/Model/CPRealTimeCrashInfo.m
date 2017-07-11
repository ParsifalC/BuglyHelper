//
//  CPRealTimeCrashInfo.m
//  BuglyHelper
//
//  Created by Parsifal on 2017/7/7.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

#import "CPRealTimeCrashInfo.h"

@implementation CPRealTimeCrashInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"appVersion": @"productVersion",
             @"date": @"dateTime",
             @"accessNum": @"accessNum",
             @"accessUser": @"accessUser",
             @"crashNum": @"crashNum",
             @"crashUser": @"crashUser",
             };
}

@end
