//
//  CPDateHelper.m
//  BuglyHelper
//
//  Created by Parsifal on 2017/7/6.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

#import "CPDateHelper.h"

@interface CPDateHelper ()

@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation CPDateHelper

+ (instancetype)sharedHelper {
    static id _sharedHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedHelper = [self new];
    });
    return _sharedHelper;
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [NSDateFormatter new];
        [_dateFormatter setDateFormat:@"yyyyMMdd"];
    }
    
    return _dateFormatter;
}

- (NSArray<NSString *> *)dateStringStartDate:(NSDate *)startDate
                                     endDate:(NSDate *)endDate {
    NSMutableArray *dateStrings = @[].mutableCopy;
    NSTimeInterval startTimeInterval = [startDate timeIntervalSince1970];
    NSTimeInterval endTimeInterval = [endDate timeIntervalSince1970];
    
    if (startTimeInterval>endTimeInterval) {
        NSTimeInterval temp = startTimeInterval;
        startTimeInterval = endTimeInterval;
        endTimeInterval = temp;
    }
    
    NSUInteger index = 0;
    
    while (endTimeInterval>startTimeInterval) {
        @autoreleasepool {
            endTimeInterval -= index*86400;
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:endTimeInterval];
            NSString *dateStr = [self.dateFormatter stringFromDate:date];
            [dateStrings addObject:dateStr];
        }
    }
    
    return dateStrings;
}

- (NSArray<NSString *> *)dateStringBeforDate:(NSDate *)date
                                       count:(NSUInteger)count {
    NSMutableArray *dateStrings = @[].mutableCopy;
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    
    for (NSUInteger index = 0; index<count; index++) {
        @autoreleasepool {
            NSTimeInterval temp = timeInterval-index*86400;
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:temp];
            NSString *dateStr = [self.dateFormatter stringFromDate:date];
            [dateStrings addObject:dateStr];
        }
    }
    
    return dateStrings;
    
}

@end
