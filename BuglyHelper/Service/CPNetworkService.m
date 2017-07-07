//
//  CPNetworkService.m
//  BuglyHelper
//
//  Created by Parsifal on 2017/7/6.
//  Copyright © 2017年 Parsifal. All rights reserved.
//

#import "CPNetworkService.h"
#import <AFNetworking/AFNetworking.h>
#import "CPCrashTrend.h"
#import "CPCrashInfo.h"

static NSString * const kCPBuglyBaseURLString = @"https://api.bugly.qq.com/";

@implementation CPNetworkService

+ (void)fetchCrashTrendSince:(NSString *)startDate
                          to:(NSString *)endDate
                  appVersion:(NSString *)appVersion
                       appId:(NSString *)appId
                      appKey:(NSString *)appKey
             completionBlock:(CPTaskCompletionBlock)block {
    if (!appId.length || !appKey.length || !startDate.length || !endDate.length) {
        NSError *error = [NSError errorWithDomain:@"com.BuglyHelper.error" code:1000 userInfo:@{@"message":@"appId和appKey不能为空"}];
        !block?:block(nil, error);
        return;
    }
    
    NSString *version = appVersion?appVersion:@"-1";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *bodyParameters = @{
                                     @"app_version":version,
                                     @"end_date":endDate,
                                     @"start_date":startDate,
                                     @"api_version":@"1",
                                     @"app_id":appId,
                                     @"pid":@"2",
                                     };
    
    NSString *urlStr =
    [NSString stringWithFormat:@"%@openapi/stat/crash/trend?app_key=%@", kCPBuglyBaseURLString, appKey];
    
    NSError *serializerError = nil;
    NSURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlStr parameters:bodyParameters error:&serializerError];
    
    if (serializerError) {
        !block?:block(nil, serializerError);
        return;
    }
    
    [[manager dataTaskWithRequest:request
                  uploadProgress:nil
                downloadProgress:nil
               completionHandler:^(NSURLResponse * _Nonnull response, NSDictionary *responseObject, NSError * _Nullable error) {
                   NSError *mtlError;
                   CPCrashTrend *trend = [MTLJSONAdapter modelOfClass:[CPCrashTrend class] fromJSONDictionary:responseObject[@"data"] error:&mtlError];
                   !block?:block(trend, error?:mtlError);
               }] resume];
}

@end
