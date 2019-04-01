//
//  WBRoute.h
//  WBFramework
//
//  Created by wayneking on 2018/7/16.
//  Copyright © 2018年 wayneking. All rights reserved.
//  封装下路由

#import <Foundation/Foundation.h>
#import <JLRoutes.h>

@interface WBRoute : NSObject
///根据url跳转
+(void)routeUrl:(NSString *)url;

/**
 根据className跳转到对应的controller

 @param className 控制器名称
 @param param 控制器参数
 */
+ (void)routeVC:(NSString *)className WithParam:(NSMutableDictionary *)param;
@end
