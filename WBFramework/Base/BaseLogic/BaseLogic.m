//
//  BaseLogic.m
//  VXuePin
//
//  Created by apple on 2018/9/14.
//  Copyright © 2018年 vxp. All rights reserved.
//

#import "BaseLogic.h"

@implementation BaseLogic

-(void)loadData{
    if (self.delegate && [self.delegate respondsToSelector:@selector(requestBegin)]) {
        [self.delegate requestBegin];
    }
}

- (void)loadMoreData{
    if (self.delegate && [self.delegate respondsToSelector:@selector(requestBegin)]) {
        [self.delegate requestBegin];
    }
}

-(void)refreshData{
    if (self.delegate && [self.delegate respondsToSelector:@selector(requestBegin)]) {
        [self.delegate requestBegin];
    }
}

@end
