//
//  BaseLogic.h
//  VXuePin
//
//  Created by apple on 2018/9/14.
//  Copyright © 2018年 vxp. All rights reserved.
//  逻辑基类

#import <Foundation/Foundation.h>

@class BaseLogic;

@protocol BaseLogicDelegate<NSObject>
@required

///加载完成返回msg success data
- (void)requestDataComplete:(NSString *)msg Success:(NSNumber *)code data:(id)data logic:(BaseLogic *)logic;

@optional


///开始加载
- (void)requestBegin;

///加载失败
- (void)requestFail:(NSInteger)code;

///无更多数据
- (void)requestNoMoreData;

@end

@interface BaseLogic : NSObject
///用来区分logic
@property(nonatomic,copy) NSString *identifyStr;
///数据
@property(nonatomic,strong) NSMutableArray *dataArray;
///页数
@property(nonatomic,assign) NSInteger page;
@property(nonatomic,weak) id<BaseLogicDelegate> delegate;

///加载数据
- (void)loadData;

///加载更多
- (void)loadMoreData;

///刷新
- (void)refreshData;

@end
