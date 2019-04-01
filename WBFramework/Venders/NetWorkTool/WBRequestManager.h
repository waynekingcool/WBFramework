//
//  WBRequestManager.h
//  WBFramework
//
//  Created by wayneking on 2018/7/16.
//  Copyright © 2018年 wayneking. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBRequestManager : NSObject
///接口名称
@property(nonatomic,copy) NSString *act;
///请求参数
@property(nonatomic,strong) NSMutableDictionary *params;
///请求参数放到Body里面
@property(nonatomic,strong) NSMutableDictionary *bodyParams;
///头部field
@property(nonatomic,strong) NSMutableDictionary *headFieldParams;
///超时时间
@property(nonatomic, assign) CGFloat timeOutInterval;

///初始化
+ (instancetype)manager;

//Get
- (void)GET:(void(^)(void))startBlock failBlock:(void(^)(NSError *))failBlock success:(void(^)(NSDictionary *))successBlock;
- (void)GET:(void(^)(void))startBlock failBlock:(void(^)(NSError *))failBlock success:(void(^)(NSDictionary *))successBlock progress:(void(^)(NSString *))progressBlock;
- (void)GetDataInBody:(void(^)(void))startBlock failBlock:(void(^)(NSError *))failBlock success:(void(^)(NSDictionary *))successBlock;

//Post
- (void)POST:(void(^)(void))startBlock failBlock:(void(^)(NSError *))failBlock success:(void(^)(NSDictionary *))successBlock;
- (void)POST:(void(^)(void))startBlock failBlock:(void(^)(NSError *))failBlock success:(void(^)(NSDictionary *))successBlock progress:(void(^)(NSString *))progressBlock;
- (void)PostDataInBody:(void(^)(void))startBlock failBlock:(void(^)(NSError *))failBlock success:(void(^)(NSDictionary *))successBlock;

//Put
- (void)PUT:(void(^)(void))startBlock failBlock:(void(^)(NSError *))failBlock success:(void(^)(NSDictionary *))successBlock;

//upload
- (void)uploadDataWithAct:(NSString *)url data:(NSData *)data start:(void (^)(void))startBlock fail:(void (^)(NSError *))failBlock success:(void (^)(NSDictionary *))successBlock progress:(void(^)(NSString *))progress;
@end
