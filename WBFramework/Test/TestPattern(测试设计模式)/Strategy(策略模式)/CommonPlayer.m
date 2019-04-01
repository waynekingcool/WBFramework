
//
//  CommonPlayer.m
//  WBFramework
//
//  Created by apple on 2018/9/25.
//  Copyright © 2018年 wayneking. All rights reserved.
//

#import "CommonPlayer.h"
#import "CommAVPlayer.h"
#import "CommAVPlayerII.h"

@interface CommonPlayer()

@property(nonatomic,strong) id<CommonPlayerProtocol> player;

@end

@implementation CommonPlayer

-(instancetype)initWithType:(PlayerType)type{
    if (self = [super init]) {
        [self initPlayerWithType:type];
    }
    return self;
}

- (void)initPlayerWithType:(PlayerType)type{
    switch (type) {
        case PlayerType_Player:
        {
            self.player = [[CommAVPlayer alloc]init];
        }
            break;
        case PlayerType_PlayerII:
        {
            self.player = [[CommAVPlayerII alloc]init];
        }
            break;
        default:
            break;
    }
}

-(NSString *)play{
    return [self.player c_play];
}

-(NSString *)pause{
    return [self.player c_pause];
}

-(NSString *)stop{
    return [self.player c_stopl];
}

@end
