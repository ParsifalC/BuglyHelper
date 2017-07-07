//
//  CPRealTimeTrend.h
//  BuglyHelper
//
//  Created by Parsifal on 2017/7/7.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

#import <Mantle/Mantle.h>

@class CPRealTimeCrashInfo;
@interface CPRealTimeTrend : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic) NSArray<CPRealTimeCrashInfo *> *crashInfos;

@end
