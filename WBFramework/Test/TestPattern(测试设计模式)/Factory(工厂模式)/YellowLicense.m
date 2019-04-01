//
//  YellowLicense.m
//  WBFramework
//
//  Created by apple on 2018/9/25.
//  Copyright © 2018年 wayneking. All rights reserved.
//

#import "YellowLicense.h"

@implementation YellowLicense
-(NSString *)printLicenseNumber{
    [super printLicenseNumber];
    
    return [NSString stringWithFormat:@"黄色牌照: %@",self.licenseNumber];
}
@end
