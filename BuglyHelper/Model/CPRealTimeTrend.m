//
//  CPRealTimeTrend.m
//  BuglyHelper
//
//  Created by Parsifal on 2017/7/7.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

#import "CPRealTimeTrend.h"
#import "CPRealTimeCrashInfo.h"

@implementation CPRealTimeTrend

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"crashInfos": @"data"};
}

+ (NSValueTransformer *)crashInfosJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:CPRealTimeCrashInfo.class];
}

@end
