//
//  CommAVPlayerII.m
//  WBFramework
//
//  Created by apple on 2018/9/25.
//  Copyright © 2018年 wayneking. All rights reserved.
//

#import "CommAVPlayerII.h"
#import "WBAVPlayerII.h"

@interface CommAVPlayerII()

@property(nonatomic,strong) id<WBAVPlayerProtocolII> player;

@end

@implementation CommAVPlayerII

-(instancetype)init{
    if (self = [super init]) {
        self.player = [[WBAVPlayerII alloc]init];
    }
    return self;
}

-(NSString *)c_play{
    return [self.player i_play];
}

-(NSString *)c_pause{
    return [self.player i_pause];
}

-(NSString *)c_stopl{
    return [self.player i_stop];
}

-(void)dealloc{
    self.player = nil;
}


@end
