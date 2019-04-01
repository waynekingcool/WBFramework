//
//  BViewController.m
//  WBFramework
//
//  Created by wayneking on 2018/7/16.
//  Copyright © 2018年 wayneking. All rights reserved.
//

#import "BViewController.h"

@interface BViewController ()

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    WBLog(@"userId: %@",self.userId);
    WBLog(@"username: %@",self.userName);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
