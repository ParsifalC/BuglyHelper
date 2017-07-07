//
//  CPCrashInfo.h
//  BuglyHelper
//
//  Created by Parsifal on 2017/7/6.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CPCrashInfo : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic) NSString *accessNum;
@property (copy, nonatomic) NSString *accessUser;
@property (copy, nonatomic) NSString *appVersion;
@property (copy, nonatomic) NSString *crashNum;
@property (copy, nonatomic) NSString *crashUser;
@property (copy, nonatomic) NSString *date;

@end
