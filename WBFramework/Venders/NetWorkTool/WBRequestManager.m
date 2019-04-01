//
//  WBRequestManager.m
//  WBFramework
//
//  Created by wayneking on 2018/7/16.
//  Copyright © 2018年 wayneking. All rights reserved.
//

#import "WBRequestManager.h"

@interface WBRequestManager()

@property(nonatomic,strong) AFHTTPSessionManager *manager;
@property(nonatomic,copy) NSString *URL;

@end

@implementation WBRequestManager

+ (instancetype)manager{
    return [[self class]init];
}

-(instancetype)init{
    if (self = [super init]) {
        //初始化  默认参数
        self.manager = [AFHTTPSessionManager manager];
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [self.manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        self.manager.requestSerializer.timeoutInterval = 20;
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html",@"application/json", @"text/json",@"application/xml",@"application/x-www-form-urlencoded",@"application/xhtml+xml",@"image/png",nil];
    }
    return self;
}

#pragma mark - Get请求
- (void)GET:(void(^)(void))startBlock failBlock:(void(^)(NSError *))failBlock success:(void(^)(NSDictionary *))successBlock{
    [self GET:startBlock failBlock:failBlock success:successBlock progress:nil];
}

- (void)GET:(void(^)(void))startBlock failBlock:(void(^)(NSError *))failBlock success:(void(^)(NSDictionary *))successBlock progress:(void(^)(NSString *))progressBlock{
    [self requestData:@"GET" startBlock:startBlock failBlock:failBlock success:successBlock progress:progressBlock];
}

- (void)GetDataInBody:(void(^)(void))startBlock failBlock:(void(^)(NSError *))failBlock success:(void(^)(NSDictionary *))successBlock{
    [self paramsInBody:@"GET" startBlock:startBlock failBlock:failBlock success:successBlock];
}

#pragma mark - Post请求
- (void)POST:(void(^)(void))startBlock failBlock:(void(^)(NSError *))failBlock success:(void(^)(NSDictionary *))successBlock{
    [self POST:startBlock failBlock:failBlock success:successBlock progress:nil];
}

- (void)POST:(void(^)(void))startBlock failBlock:(void(^)(NSError *))failBlock success:(void(^)(NSDictionary *))successBlock progress:(void(^)(NSString *))progressBlock{
    [self requestData:@"POST" startBlock:startBlock failBlock:failBlock success:successBlock progress:progressBlock];
}

- (void)PostDataInBody:(void(^)(void))startBlock failBlock:(void(^)(NSError *))failBlock success:(void(^)(NSDictionary *))successBlock{
    [self paramsInBody:@"POST" startBlock:startBlock failBlock:failBlock success:successBlock];
}

#pragma mark - Put请求
- (void)PUT:(void(^)(void))startBlock failBlock:(void(^)(NSError *))failBlock success:(void(^)(NSDictionary *))successBlock{
    [self paramsInBody:@"PUT" startBlock:startBlock failBlock:failBlock success:successBlock];
}


#pragma mark - 上传文件
- (void)uploadDataWithAct:(NSString *)url data:(NSData *)data start:(void (^)(void))startBlock fail:(void (^)(NSError *))failBlock success:(void (^)(NSDictionary *))successBlock progress:(void(^)(NSString *))progress{
    [self.manager.requestSerializer setValue:@"multipart/form-data; boundary=wfWiEWrgEFA9A78512weF7106A; name=\"file\"" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionTask *uploadTastk = [self.manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //随机字符串
//        NSString *randomStr = [WBUtil returnRandomString:10];
//
//        [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"%@.png",randomStr] mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress.localizedDescription);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //回传数据
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
    }];
    
    [uploadTastk resume];
}

#pragma mark - 公共方法
- (void)requestData:(NSString *)type startBlock:(void(^)(void))startBlock failBlock:(void(^)(NSError *))failBlock success:(void(^)(NSDictionary *))successBlock progress:(void(^)(NSString *))progressBlock{
    //遍历设置HttpField
    for (NSString *key in [self.headFieldParams allKeys]) {
        NSString *value = self.headFieldParams[key];
        [self.manager.requestSerializer setValue:value forHTTPHeaderField:key];
    }
    
    //开始
    startBlock();
    
    if ([type isEqualToString:@"GET"]) {
        [self.manager GET:self.URL parameters:self.params progress:^(NSProgress * _Nonnull downloadProgress) {
            //进度
            progressBlock(downloadProgress.localizedDescription);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //成功
            NSData *data = responseObject;
            NSDictionary *info = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            //回传数据
            successBlock(info);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //失败
            failBlock(error);
        }];
        
    }else if([type isEqualToString:@"POST"]){
        [self.manager POST:self.URL parameters:self.params progress:^(NSProgress * _Nonnull downloadProgress) {
            //进度
            progressBlock(downloadProgress.localizedDescription);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //成功
            NSData *data = responseObject;
            NSDictionary *info = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            //回传数据
            successBlock(info);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //失败
            failBlock(error);
        }];
    }
}

//参数放到Body里面
- (void)paramsInBody:(NSString *)type startBlock:(void(^)(void))startBlock failBlock:(void(^)(NSError *))failBlock success:(void(^)(NSDictionary *))successBlock{
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:type URLString:self.URL parameters:nil error:nil];
    [request addValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
    //遍历设置HttpField
    for (NSString *key in [self.headFieldParams allKeys]) {
        NSString *value = self.headFieldParams[key];
        [request setValue:value forHTTPHeaderField:key];
    }
    //参数放到Body里面
    NSString *string = [self.params mj_JSONString];
    NSData *body  =[string dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:body];
    
    startBlock();
    [[self.manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if(!error){
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            successBlock(dic);
        }else{
            failBlock(error);
        }
    }] resume];
    
}

#pragma mark - Getter And Setter
-(void)setAct:(NSString *)act{
    _act = act;
    self.URL = [NSString stringWithFormat:@"%@%@",BaseUrl,act];
}

@end
