//
//  CPCrashTrend.m
//  BuglyHelper
//
//  Created by Parsifal on 2017/7/6.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

#import "CPCrashTrend.h"
#import "CPCrashInfo.h"

@implementation CPCrashTrend

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"crashInfos": @"data"};
}

+ (NSValueTransformer *)crashInfosJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:CPCrashInfo.class];
}

@end
