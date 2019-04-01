//
//  CommonPlayer.h
//  WBFramework
//
//  Created by apple on 2018/9/25.
//  Copyright © 2018年 wayneking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonPlayerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    PlayerType_Player,
    PlayerType_PlayerII,
} PlayerType;

@interface CommonPlayer : NSObject

- (instancetype)initWithType:(PlayerType)type;

- (NSString *)play;
- (NSString *)pause;
- (NSString *)stop;

@end

NS_ASSUME_NONNULL_END
