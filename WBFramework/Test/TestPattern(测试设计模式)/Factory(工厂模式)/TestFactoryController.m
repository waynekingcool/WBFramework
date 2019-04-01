//
//  TestFactoryController.m
//  WBFramework
//
//  Created by apple on 2018/9/25.
//  Copyright © 2018年 wayneking. All rights reserved.
//

#import "TestFactoryController.h"
#import "CarLicense.h"
#import "CarLicenseFactory.h"

@interface TestFactoryController ()

@end

@implementation TestFactoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)createLicense:(LicenseType)type
{
    CarLicense *_license = [CarLicenseFactory createCarLicenseWithType:type];
}



@end
