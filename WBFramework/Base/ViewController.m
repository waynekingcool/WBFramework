//
//  ViewController.m
//  WBFramework
//
//  Created by wayneking on 2018/7/11.
//  Copyright © 2018年 wayneking. All rights reserved.
//

#import "ViewController.h"
#import <JLRoutes.h>
#import "BViewController.h"
#import "TestASDKController.h"
#import "TestGCDController.h"
#import "TestDownloadController.h"

@interface ViewController ()<NSURLSessionDownloadDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"Home";
    WBLog(@"%@",NSHomeDirectory());
    
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:@"点我" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(40);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
//        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
//        [dic setValue:@"123" forKey:@"userId"];
//        [dic setValue:@"king" forKey:@"userName"];
//        [WBRoute routeVC:@"BViewController" WithParam:dic];
        
//        NSString *string = @"http://m.mamayy.com/#/goodsDetail/?aId=1009592392&url=http://m.mamayy.com/#/goodsDetail/1009592392";
//        NSString *newUrl = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
//        [WBRoute routeUrl:newUrl];
//        [WBRoute routeUrl:@"http://m.mamayy.com/#/goodsDetail/?aId=1009592392&url=http://m.mamayy.com/#/goodsDetail/123"];
        
        
        
//        TestASDKController *vc = [[TestASDKController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
        
        
//        TestGCDController *vc = [[TestGCDController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
        
        //测试下载
        TestDownloadController *vc = [[TestDownloadController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
