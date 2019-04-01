//
//  MyBankController.m
//  WBFramework
//
//  Created by apple on 2018/9/29.
//  Copyright © 2018年 wayneking. All rights reserved.
//

#import "MyBankController.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "MyBankCellNode.h"
#import "TestCellNode.h"
#import "YYFPSLabel.h"

@interface MyBankController ()<ASTableDelegate,ASTableDataSource>
@property(nonatomic,strong) ASTableNode *tableNode;
@property (nonatomic, strong) YYFPSLabel *fpsLabel;
@end

@implementation MyBankController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testFPSLabel];
    
    [self createUI];
}

- (void)createUI{
    self.view.backgroundColor = [WBUtil createHexColor:@"#FFFFFF"];
    
    self.title = @"我的银行卡";
    
    [self.view addSubnode:self.tableNode];
    self.tableNode.frame =CGRectMake(0, 0, screenWidth, screenHeight);
}

#pragma mark - Delegate
-(NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode{
    return 1;
}

-(NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(ASCellNode *)tableNode:(ASTableNode *)tableNode nodeForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyBankCellNode *node = [[MyBankCellNode alloc]init];
//    TestCellNode *node = [[TestCellNode alloc]init];
    return node;
}

#pragma mark - Getter And Setter
-(ASTableNode *)tableNode{
    if (!_tableNode) {
        _tableNode = [[ASTableNode alloc]initWithStyle:UITableViewStylePlain];
        _tableNode.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        _tableNode.delegate = self;
        _tableNode.dataSource = self;
        _tableNode.view.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableNode;
}

//检测FPS
- (void)testFPSLabel {
    _fpsLabel = [YYFPSLabel new];
    _fpsLabel.frame = CGRectMake(200, 200, 50, 30);
    [_fpsLabel sizeToFit];
    [self.view addSubview:_fpsLabel];
}


@end
