//
//  CommAVPlayer.m
//  WBFramework
//
//  Created by apple on 2018/9/25.
//  Copyright © 2018年 wayneking. All rights reserved.
//

#import "CommAVPlayer.h"
#import "WBAVPlayer.h"

@interface CommAVPlayer()

@property(nonatomic,strong) id<WBAVPlayerProtocol> player;

@end

@implementation CommAVPlayer

-(instancetype)init{
    if (self = [super init]) {
        self.player = [[WBAVPlayer alloc]init];
    }
    return self;
}

-(NSString *)c_play{
    return [self.player a_play];
}

-(NSString *)c_pause{
    return [self.player a_pause];
}

-(NSString *)c_stopl{
    return [self.player a_stop];
}

-(void)dealloc{
    self.player = nil;
}

@end
