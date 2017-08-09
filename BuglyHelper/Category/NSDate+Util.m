//
//  NSDate+Util.m
//  BuglyHelper
//
//  Created by Parsifal on 2017/7/11.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

#import "NSDate+Util.h"

@implementation NSDate (Util)

+ (NSDate *)yesterday {
    NSDate *today = [NSDate date];
    return [today dateByAddingTimeInterval:-86400];
}

+ (NSDate *)theDayBeforeDays:(NSUInteger)days {
    NSDate *today = [NSDate date];
    return [today dateByAddingTimeInterval:-(86400*days)];
}

@end
