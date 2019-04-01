//
//  BaseApi.h
//  VXuePin
//
//  Created by apple on 2018/9/18.
//  Copyright © 2018年 vxp. All rights reserved.
//  API基类

#import <Foundation/Foundation.h>
#import "WBRequestManager.h"

@protocol BaseApiDelegate<NSObject>

///开始
- (void)apiBegin;
///失败
- (void)apiFail:(NSError *)error;
///成功
- (void)apiSuccess:(NSDictionary *)data;

@end

@interface BaseApi : NSObject
@property(nonatomic,strong) WBRequestManager *manager;
@property(nonatomic,weak) id<BaseApiDelegate> delegate;

///一个默认的api
- (void)apiWithParams:(NSMutableDictionary *)params;

@end
