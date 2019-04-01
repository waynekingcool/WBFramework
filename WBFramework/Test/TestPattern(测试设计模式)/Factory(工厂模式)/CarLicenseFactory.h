//
//  CarLicenseFactory.h
//  WBFramework
//
//  Created by apple on 2018/9/25.
//  Copyright © 2018年 wayneking. All rights reserved.
//  工厂类
// 也可以将此类派生出子类,将业务逻辑放到子类中,简单工厂模式->工厂模式

#import <Foundation/Foundation.h>
#import "CarLicense.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    LicenseType_Blue,
    LicenseType_Yellow,
} LicenseType;

@interface CarLicenseFactory : NSObject

/**
 获取拍照工厂

 @param type 牌照类型
 @return 返回牌照对象
 */
+ (CarLicense *)createCarLicenseWithType:(LicenseType)type;

@end

NS_ASSUME_NONNULL_END
