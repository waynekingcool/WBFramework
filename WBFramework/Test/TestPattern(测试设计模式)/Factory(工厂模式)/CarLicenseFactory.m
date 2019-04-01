//
//  CarLicenseFactory.m
//  WBFramework
//
//  Created by apple on 2018/9/25.
//  Copyright © 2018年 wayneking. All rights reserved.
//

#import "CarLicenseFactory.h"
#import "BlueLicense.h"
#import "YellowLicense.h"

@implementation CarLicenseFactory

+(CarLicense *)createCarLicenseWithType:(LicenseType)type{
    CarLicense *_license;
    switch (type) {
        case LicenseType_Blue:
            _license = [[BlueLicense alloc]init];
            break;
        case LicenseType_Yellow:
            _license = [[YellowLicense alloc]init];
        default:
            break;
    }
    
    return _license;
}

@end
