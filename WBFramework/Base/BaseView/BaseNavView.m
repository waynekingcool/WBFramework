//
//  BaseNavView.m
//  VXuePin
//
//  Created by apple on 2018/9/14.
//  Copyright © 2018年 vxp. All rights reserved.
//

#import "BaseNavView.h"

@interface BaseNavView()

@property(nonatomic,strong) UIImageView *bgImageView;
@property(nonatomic,strong) UIButton *leftButton;
@property(nonatomic,strong) UIButton *rightButton;
@property(nonatomic,strong) UILabel *titleLabel;

@end

@implementation BaseNavView

-(instancetype)init{
    if (self = [super initWithFrame:CGRectMake(0, 0, screenWidth, NavgationBarHeight)]) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    [self addSubview:self.bgImageView];
    [self addSubview:self.leftButton];
    [self addSubview:self.rightButton];
    [self addSubview:self.titleLabel];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).offset(0);
    }];
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.left.offset(10);
        make.bottom.offset(-10);
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.right.offset(-10);
        make.bottom.offset(-10);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(24);
        make.bottom.offset(-10);
        make.centerX.mas_equalTo(self.mas_centerX).offset(0);
    }];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.frame = CGRectMake(0, 0, screenWidth, NavgationBarHeight);
}

#pragma mark - Public Methods
-(void)addLeftTarget:(id)target selector:(SEL)selector{
    [self.leftButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}

-(void)addRightTarget:(id)target selector:(SEL)selector{
    [self.rightButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Getter And Setter
-(UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]init];
    }
    return _bgImageView;
}

-(UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _leftButton;
}

-(UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _rightButton;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = FONT_BOLD(17);
    }
    return _titleLabel;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

-(void)setLeftIcon:(UIImage *)leftIcon{
    _leftIcon = leftIcon;
    [_leftButton setImage:leftIcon forState:UIControlStateNormal];
    [_leftButton setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
}

-(void)setRightIcon:(UIImage *)rightIcon{
    _rightIcon = rightIcon;
    [_rightButton setBackgroundImage:rightIcon forState:UIControlStateNormal];
}

-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    _titleLabel.textColor = titleColor;
}

-(void)setBgColor:(UIColor *)bgColor{
    _bgColor = bgColor;
    self.backgroundColor = bgColor;
}

-(void)setBgImage:(UIImage *)bgImage{
    _bgImage = bgImage;
    _bgImageView.image = bgImage;
}

@end
