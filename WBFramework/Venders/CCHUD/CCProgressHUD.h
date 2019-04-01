//
//  CCProgressHUD.h
//  PangXieYG
//
//  Created by mac on 17/3/9.
//  Copyright © 2017年 mac. All rights reserved.
/****
 *
 * 显示提示信息
 **/

#import <Foundation/Foundation.h>
//#import "MBProgressHUD.h"


@interface CCProgressHUD : NSObject

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (void)showMwssage:(NSString *)message toView:(UIView *)view;

+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (void)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

//闪现显示提示信息
+ (void)showMessageInAFlashWithMessage:(NSString *)message;


@end
