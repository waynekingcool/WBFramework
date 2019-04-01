//
//  BaseController.h
//  VXuePin
//
//  Created by apple on 2018/9/14.
//  Copyright © 2018年 vxp. All rights reserved.
//  基类

#import <UIKit/UIKit.h>
#import "BaseNavView.h"

@interface BaseController : UIViewController

///是否隐藏系统导航条
@property(nonatomic,assign) BOOL isHideNav;

///自定义导航栏，可以为空，系统会添加默认导航栏
@property(nonatomic,strong) BaseNavView *baseNavView;
@property(nonatomic,assign) BOOL isSetCustomNav;

///导航左边标题
@property(nonatomic,copy) NSString *leftTitle;
///导航右边标题
@property(nonatomic,strong) NSString *rightTitle;

///导航左边图标
@property(nonatomic,strong) UIImage *leftImage;
///导航右边图标
@property(nonatomic,strong) UIImage *rightImage;

#pragma mark - 初始化UI
///子类重载
- (void)createUI;

#pragma mark - 按钮事件
///左边按钮事件，如果存在
- (void)leftButtonAction;
///右边按钮事件，如果存在
- (void)rightButtonAction;

#pragma mark - 小菊花
///正在加载
- (void)showLoadingHUD;
- (void)showLoadingHUD:(NSString *)string;

///加载失败
- (void)showFailHUD;
- (void)showFailHUD:(NSString *)string;

///闪现
- (void)showFlashHUD:(NSString *)string;

///隐藏
- (void)hideHUD;



@end
