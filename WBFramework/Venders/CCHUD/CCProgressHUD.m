//
//  CCProgressHUD.m
//  PangXieYG
//
//  Created by mac on 17/3/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "CCProgressHUD.h"
#import "UIColor+UIColorExt.h"

@implementation CCProgressHUD
#pragma mark 显示信息
+ (void)show:(NSString *)text
        icon:(NSString *)icon
        view:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    //快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //hud.labelText = text;
    hud.detailsLabel.font = hud.label.font;
    hud.detailsLabel.text = text;
    //设置图片
//    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    //再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    //隐藏时候从父类控件移除
    hud.removeFromSuperViewOnHide = YES;
    //1秒之后消失
    [hud hideAnimated:YES afterDelay:0.5];
}

#pragma mark <显示错误信息>
+ (void)showError:(NSString *)error
           toView:(UIView *)view {
    [self show:error icon:nil view:view];
}
#pragma mark <显示成功信息>
+ (void)showSuccess:(NSString *)success
             toView:(UIView *)view {
    [self show:success icon:nil view:view];
}
#pragma mark <显示信息>
+ (void)showMwssage:(NSString *)message
             toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    //快速显示一个信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.label.text = message;
    //hud.detailsLabelText = message;
    //隐藏时候从父类控件移除
    hud.removeFromSuperViewOnHide = YES;
}

+ (void)showSuccess:(NSString *)success {
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error {
    [self showError:error toView:nil];
}

+ (void)showMessage:(NSString *)message {
    [self showMwssage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view {
    [MBProgressHUD hideHUDForView:view animated:YES];
}

+ (void)hideHUD {
    [self hideHUDForView:nil];
}

+ (void)showMessageInAFlashWithMessage:(NSString *)message {
    [self show:message icon:nil view:nil];
}

@end
