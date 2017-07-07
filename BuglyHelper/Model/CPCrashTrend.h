//
//  CPCrashTrend.h
//  BuglyHelper
//
//  Created by Parsifal on 2017/7/6.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

#import <Mantle/Mantle.h>

@class CPCrashInfo;
@interface CPCrashTrend : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic) NSArray<CPCrashInfo *> *crashInfos;

@end
