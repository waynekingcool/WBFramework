//
//  CommonPlayerProtocol.h
//  WBFramework
//
//  Created by apple on 2018/9/25.
//  Copyright © 2018年 wayneking. All rights reserved.
//  通用协议

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CommonPlayerProtocol <NSObject>

- (NSString *)c_play;
- (NSString *)c_pause;
- (NSString *)c_stopl;

@end

NS_ASSUME_NONNULL_END
