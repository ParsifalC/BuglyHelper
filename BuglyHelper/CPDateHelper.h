//
//  CPDateHelper.h
//  BuglyHelper
//
//  Created by Parsifal on 2017/7/6.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPDateHelper : NSObject

+ (instancetype)sharedHelper;

//返回两个date间的所有日期 以yyMMdd格式字符串形式
- (NSArray<NSString *> *)dateStringStartDate:(NSDate *)startDate
                                     endDate:(NSDate *)endDate;

//返回date往前count天内的所有日期 以yyMMdd格式字符串形式
- (NSArray<NSString *> *)dateStringBeforDate:(NSDate *)date
                                       count:(NSUInteger)count;

@end
