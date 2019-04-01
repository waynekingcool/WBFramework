//
//  WBRequest.m
//  WBFramework
//
//  Created by wayneking on 2018/7/16.
//  Copyright © 2018年 wayneking. All rights reserved.
//

#import "WBRequest.h"

@implementation WBRequest

+ (void)requestDataWithType:(WBRequestType)type act:(NSString *)act params:(NSMutableDictionary *)params {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    //请求超时30秒
    manager.requestSerializer.timeoutInterval = 30.f;
    //ContentTypes类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html",@"application/json", @"text/json",@"application/xml",@"application/x-www-form-urlencoded",@"application/xhtml+xml",@"image/png",nil];
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseUrl,act];
    
}

@end
