//
//  NSString+Util.m
//  BuglyHelper
//
//  Created by Parsifal on 2017/7/7.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

#import "NSString+Util.h"
#import "BuglyHelperMacro.h"

@implementation NSString (Util)

- (NSString *)plus:(NSString *)numStr {
    return [@([self integerValue] + [numStr integerValue]) stringValue];
}

+ (NSString *)pathForFile:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dirPath = [documentsDirectory stringByAppendingPathComponent:kCPAppName];
    [[NSFileManager defaultManager] createDirectoryAtPath:dirPath
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:nil];
    NSString *path = [dirPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", fileName]];
    return path;
}

@end
