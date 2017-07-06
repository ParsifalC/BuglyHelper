//
//  CPNetworkService.h
//  BuglyHelper
//
//  Created by Parsifal on 2017/7/6.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CPTaskCompletionBlock)(id responseObj, NSError *error);

@interface CPNetworkService : NSObject

+ (void)fetchCrashTrendSince:(NSString *)startDate
                          to:(NSString *)endDate
                  appVersion:(NSString *)appVersion
                       appId:(NSString *)appId
                      appKey:(NSString *)appKey
             completionBlock:(CPTaskCompletionBlock)block;

@end
