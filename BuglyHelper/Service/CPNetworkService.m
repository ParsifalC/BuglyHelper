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
#import "CPRealTimeCrashInfo.h"
#import "CPRealTimeTrend.h"
#import "NSString+Util.h"

static NSString * const kCPBuglyBaseURLString = @"https://api.bugly.qq.com/";
static NSString * const kCPServiceErrorDomain = @"com.BuglyHelper.error";

@implementation CPNetworkService

+ (void)fetchCrashTrendSince:(NSString *)startDate
                          to:(NSString *)endDate
                  appVersion:(NSString *)appVersion
                       appId:(NSString *)appId
                      appKey:(NSString *)appKey
             completionBlock:(CPTaskCompletionBlock)block {
    if (!appId.length || !appKey.length || !startDate.length || !endDate.length) {
        NSError *error = [NSError errorWithDomain:kCPServiceErrorDomain code:1000 userInfo:@{@"message":@"appId和appKey不能为空"}];
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

+ (void)fetchCrashInfoAtDate:(NSString *)date
                       appId:(NSString *)appId
                      appKey:(NSString *)appKey
             completionBlock:(CPTaskCompletionBlock)block {
    if (!appId.length || !appKey.length) {
        NSError *error = [NSError errorWithDomain:kCPServiceErrorDomain code:1000 userInfo:@{@"message":@"appId和appKey不能为空"}];
        !block?:block(nil, error);
        return;
    }
    
    NSString *dateStr = [NSString stringWithFormat:@"%@23", date];
    NSString *path = [NSString pathForFile:dateStr];
    
    //优先返回持久化数据
    CPRealTimeTrend *trend = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (trend.crashInfos.count) {
        !block?:block(trend, nil);
        NSLog(@"命中缓存:%@", dateStr);
        return;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *bodyParameters = @{
                                     @"start_date":dateStr,
                                     @"api_version":@"1",
                                     @"app_id":appId,
                                     @"pid":@"2",
                                     };
    
    NSString *urlStr =
    [NSString stringWithFormat:@"%@openapi/stat/realtimeAppendCrash/trend?app_key=%@", kCPBuglyBaseURLString, appKey];
    
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
                    if (error) {
                        !block?:block(trend, error);
                        return ;
                    }

                    NSError *mtlError;
                    CPRealTimeTrend *trend = [MTLJSONAdapter modelOfClass:[CPRealTimeTrend class] fromJSONDictionary:responseObject[@"data"] error:&mtlError];
                    if (mtlError) {
                        !block?:block(trend, mtlError);
                        return ;
                    }
                    
                    if (trend.crashInfos.count) {
                        BOOL isSuccessful = [NSKeyedArchiver archiveRootObject:trend
                                                                        toFile:path];
                        NSError *archiveError = isSuccessful?nil:[NSError errorWithDomain:kCPServiceErrorDomain code:2000 userInfo:@{@"message":@"archiveRootObject error"}];
                        !block?:block(trend, archiveError);
                    } else {
                        !block?:block(trend, nil);
                    }
                }] resume];
}

@end
