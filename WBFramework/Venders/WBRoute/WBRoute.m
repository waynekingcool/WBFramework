//
//  WBRoute.m
//  WBFramework
//
//  Created by wayneking on 2018/7/16.
//  Copyright © 2018年 wayneking. All rights reserved.
//

#import "WBRoute.h"

@implementation WBRoute

+(void)routeUrl:(NSString *)url{
    NSURL *temp = [NSURL URLWithString:url];
    if ([JLRoutes routeURL:temp]) {
        //路由返回yes
    }else{
        //路由返回no
        [[UIApplication sharedApplication]openURL:temp options:@{@"name":@"xxx"} completionHandler:nil];
    }
}

+ (void)routeVC:(NSString *)className WithParam:(NSMutableDictionary *)param{
    //拼接参数
    NSString *params = @"?";
    for (NSString *key in [param allKeys]) {
        NSString *value = param[key];
        params = [NSString stringWithFormat:@"%@%@=%@&",params,key,value];
    }
    NSString *pushUrl = [NSString stringWithFormat:@"/myAppPush/%@%@",className,[params substringToIndex:params.length-1]];
    //包含url或者中文需要通过该方法进行转换
    NSString *newUrl = [pushUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    WBLog(@"整合后的路由: %@",pushUrl);
    [WBRoute routeUrl:newUrl];
}

@end
