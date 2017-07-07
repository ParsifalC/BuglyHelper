//
//  NSString+Util.m
//  BuglyHelper
//
//  Created by Parsifal on 2017/7/7.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

#import "NSString+Util.h"

@implementation NSString (Util)

- (NSString *)plus:(NSString *)numStr {
    return [@([self integerValue] + [numStr integerValue]) stringValue];
}

@end
