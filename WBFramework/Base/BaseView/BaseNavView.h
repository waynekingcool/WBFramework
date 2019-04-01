//
//  BaseNavView.h
//  VXuePin
//
//  Created by apple on 2018/9/14.
//  Copyright © 2018年 vxp. All rights reserved.
//  基类导航条

#import <UIKit/UIKit.h>

@interface BaseNavView : UIView

@property(nonatomic,strong) UIImage *leftIcon;
@property(nonatomic,strong) UIImage *rightIcon;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) UIColor *titleColor;
@property(nonatomic,strong) UIColor *bgColor;
@property(nonatomic,strong) UIImage *bgImage;

- (void)addLeftTarget:(id)target selector:(SEL)selector;
- (void)addRightTarget:(id)target selector:(SEL)selector;

@end
