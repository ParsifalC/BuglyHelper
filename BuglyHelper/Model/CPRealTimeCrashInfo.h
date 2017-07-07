//
//  CPRealTimeCrashInfo.h
//  BuglyHelper
//
//  Created by Parsifal on 2017/7/7.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CPRealTimeCrashInfo : MTLModel <MTLJSONSerializing>

@property (assign, nonatomic) NSUInteger accessNum;
@property (assign, nonatomic) NSUInteger accessUser;
@property (assign, nonatomic) NSUInteger crashNum;
@property (assign, nonatomic) NSUInteger crashUser;
@property (copy, nonatomic) NSString *appVersion;
@property (copy, nonatomic) NSString *date;

@end
