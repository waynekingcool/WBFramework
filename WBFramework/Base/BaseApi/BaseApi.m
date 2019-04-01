//
//  BaseApi.m
//  VXuePin
//
//  Created by apple on 2018/9/18.
//  Copyright © 2018年 vxp. All rights reserved.
//

#import "BaseApi.h"

@implementation BaseApi

-(void)apiWithParams:(NSMutableDictionary *)params{
    
}

#pragma mark  - Getter And Setter
-(WBRequestManager *)manager{
    if (!_manager) {
        _manager = [WBRequestManager manager];
    }
    return _manager;
}

@end
