//
//  CarLicense.h
//  WBFramework
//
//  Created by apple on 2018/9/25.
//  Copyright © 2018年 wayneking. All rights reserved.
//  车牌基类

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CarLicenseProtocol <NSObject>

///打印车牌号
- (NSString *)printLicenseNumber;

@end

@interface CarLicense : NSObject<CarLicenseProtocol>

@property(nonatomic,copy) NSString *city;   //城市
@property(nonatomic,copy,readonly) NSString *licenseNumber; //车牌号



@end

NS_ASSUME_NONNULL_END
