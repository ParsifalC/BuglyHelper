//
//  CPRealTimeCrashInfo+Util.m
//  BuglyHelper
//
//  Created by Parsifal on 2017/7/10.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

#import "CPRealTimeCrashInfo+Util.h"

@implementation CPRealTimeCrashInfo (Util)

- (instancetype)clone {
    CPRealTimeCrashInfo *info = [CPRealTimeCrashInfo new];
    info.accessNum = self.accessNum;
    info.accessUser = self.accessUser;
    info.crashNum = self.crashNum;
    info.crashUser = self.crashUser;
    info.appVersion = self.appVersion;
    info.date = self.date;
    return info;
}

- (NSString *)excelDescription {
    return [NSString stringWithFormat:@"%@,%@,%@,%@,%@", [self.appVersion stringByRemovingPercentEncoding], @(self.crashNum), @(self.crashUser), @(self.accessNum), @(self.accessUser)];
}

@end
