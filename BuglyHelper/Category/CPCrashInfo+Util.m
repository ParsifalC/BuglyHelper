//
//  CPCrashInfo+Util.m
//  BuglyHelper
//
//  Created by Parsifal on 2017/7/12.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

#import "CPCrashInfo+Util.h"

@implementation CPCrashInfo (Util)

- (NSString *)excelDescription {
    return [NSString stringWithFormat:@"%@,%@,%@,%@,%@", [self.appVersion stringByRemovingPercentEncoding], self.crashNum, self.crashUser, self.accessNum, self.accessUser];
}

@end
