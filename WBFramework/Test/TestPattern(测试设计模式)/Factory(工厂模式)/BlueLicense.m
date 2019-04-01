//
//  BlueLicense.m
//  WBFramework
//
//  Created by apple on 2018/9/25.
//  Copyright © 2018年 wayneking. All rights reserved.
//

#import "BlueLicense.h"

@implementation BlueLicense
-(NSString *)printLicenseNumber{
    [super printLicenseNumber];
    
    return [NSString stringWithFormat:@"蓝色牌照: %@",self.licenseNumber];
}
@end
