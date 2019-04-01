//
//  WBRequest.h
//  WBFramework
//
//  Created by wayneking on 2018/7/16.
//  Copyright © 2018年 wayneking. All rights reserved.
//

#import <Foundation/Foundation.h>
///请求方式
typedef enum : NSUInteger {
    GET,
    POST,
    PUT,
    DELETE,
} WBRequestType;

@interface WBRequest : NSObject

@end
