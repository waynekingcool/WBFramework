//
//  BaseController.m
//  VXuePin
//
//  Created by apple on 2018/9/14.
//  Copyright © 2018年 vxp. All rights reserved.
//

#import "BaseController.h"
#import "CCProgressHUD.h"

@interface BaseController ()

@property(nonatomic,strong) UIButton *rightButton;
@property(nonatomic,strong) UIButton *leftButton;

@property(nonatomic,strong) BaseNavView *navView;

@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.leftTitle = @"";
    self.rightTitle = @"";
    
    [self setUpBarItem];
    
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //隐藏系统nav bar
    if (self.isHideNav) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
}


- (void)setUpBarItem{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftButton];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)createUI{
    
}

#pragma mark - 小菊花
-(void)showLoadingHUD{
    [self showLoadingHUD:@"正在加载,请稍等"];
}

-(void)showLoadingHUD:(NSString *)string{
    [CCProgressHUD showMwssage:string toView:self.view];
}

- (void)showFailHUD{
    [self showFailHUD:@"网络出错了,请重试"];
}

- (void)showFailHUD:(NSString *)string{
    [self showLoadingHUD:string];
}

-(void)showFlashHUD:(NSString *)string{
    [CCProgressHUD showMessageInAFlashWithMessage:string];
}

-(void)hideHUD{
    [CCProgressHUD hideHUDForView:self.view];
}

#pragma mark - 按钮点击事件
-(void)leftButtonAction{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonAction{
    [self.view endEditing:YES];
}

#pragma mark  - Getter And Setter
-(BaseNavView *)navView{
    if (!_navView) {
        _navView = [[BaseNavView alloc]init];
        _navView.leftIcon = self.leftImage;
        _navView.title = self.title;
        _navView.rightIcon = self.rightImage;
        _navView.backgroundColor = [UIColor whiteColor];
    }
    return _navView;
}

-(void)setIsSetCustomNav:(BOOL)isSetCustomNav{
    _isSetCustomNav = isSetCustomNav;
    
    //隐藏nav并且是自定义nav
    if (self.isHideNav && isSetCustomNav) {
        if (self.baseNavView) {
            //自定义导航栏存在
            self.navView = self.baseNavView;
            [self.view addSubview:self.baseNavView];
        }else{
            [self.view addSubview:self.navView];
        }
    }
}

-(UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectMake(0, 0, 30, 30);
        [_leftButton setTitle:self.leftTitle forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_leftButton.titleLabel setFont:FONT(15)];
    }
    return _leftButton;
}

-(UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(0, 0, 30, 30);
        [_rightButton setTitle:self.leftTitle forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_rightButton.titleLabel setFont:FONT(15)];
    }
    return _rightButton;
}

-(void)setLeftTitle:(NSString *)leftTitle{
    _leftTitle = leftTitle;
    [self.leftButton setTitle:leftTitle forState:UIControlStateNormal];
}

-(void)setRightTitle:(NSString *)rightTitle{
    _rightTitle = rightTitle;
    [self.rightButton setTitle:rightTitle forState:UIControlStateNormal];
}

-(void)setLeftImage:(UIImage *)leftImage{
    _leftImage = leftImage;
    [self.leftButton setImage:leftImage forState:UIControlStateNormal];
}

-(void)setRightImage:(UIImage *)rightImage{
    _rightImage = rightImage;
    [self.rightButton setImage:rightImage forState:UIControlStateNormal];
}

@end
