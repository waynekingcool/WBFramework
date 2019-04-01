//
//  TestASDKController.m
//  WBFramework
//
//  Created by wayneking on 2018/8/30.
//  Copyright © 2018年 wayneking. All rights reserved.
//

#import "TestASDKController.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "TestCellNode.h"
#import "YYFPSLabel.h"
#import <WRNavigationBar/WRNavigationBar.h>
#import "MyBankController.h"
#import "TPTBController.h"

#define NAV_HEIGHT 64
#define IMAGE_HEIGHT 260
#define SCROLL_DOWN_LIMIT 70
//bar开始变色的位置
#define NAVBAR_COLORCHANGE_POINT (-IMAGE_HEIGHT + NAV_HEIGHT*2)
#define LIMIT_OFFSET_Y -(IMAGE_HEIGHT + SCROLL_DOWN_LIMIT)

@interface TestASDKController ()<ASTableDelegate,ASTableDataSource>

@property(nonatomic,strong) ASTableNode *tableNode;

@property (nonatomic, strong) YYFPSLabel *fpsLabel;
@property(nonatomic,strong) UIImageView *headImageView;

@end

@implementation TestASDKController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
//    [self testFPSLabel];
    
    //让导航条变得透明
    [self wr_setNavBarBackgroundAlpha:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)createUI{
    self.title = @"ASDK";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableNode = [[ASTableNode alloc]initWithStyle:UITableViewStylePlain];
    self.tableNode.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    self.tableNode.delegate = self;
    self.tableNode.dataSource = self;
    self.tableNode.view.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubnode:self.tableNode];
    
    //将tableNode的scrollView往下挤了IMAGE_HEIGHT的高度,并且这个高度包含了NAVBar的高度所以在减去Bar高度,这样就能顶到顶点
    self.tableNode.contentInset = UIEdgeInsetsMake(IMAGE_HEIGHT-NAV_HEIGHT, 0, 0, 0);
    
    self.headImageView.frame = CGRectMake(0, -IMAGE_HEIGHT, screenWidth, IMAGE_HEIGHT);
    [self.tableNode.view addSubview:self.headImageView];
    
}

//根据滚动的偏移量改变Nav
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    WBLog(@"Offset----------------------------> %f",offsetY);
    
    if (offsetY > NAVBAR_COLORCHANGE_POINT) {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
        [self wr_setNavBarBackgroundAlpha:alpha];
    }else{
        [self wr_setNavBarBackgroundAlpha:0];
    }
    
    //限制下拉的距离
    if (offsetY < LIMIT_OFFSET_Y) {
        [scrollView setContentOffset:CGPointMake(0, LIMIT_OFFSET_Y)];
    }
    
    //改变图片框的大小(上滑的时候不变)
    CGFloat newOffset = scrollView.contentOffset.y;
    if (newOffset < -IMAGE_HEIGHT) {
        self.headImageView.frame = CGRectMake(0, newOffset, screenWidth, -newOffset);
    }
    
}

-(NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode{
    return 1;
}

-(NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(ASCellNode *)tableNode:(ASTableNode *)tableNode nodeForRowAtIndexPath:(NSIndexPath *)indexPath{
    TestCellNode *node = [[TestCellNode alloc]init];
    return node;
}

-(void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    MyBankController *vc = [[MyBankController alloc]init];
    TPTBController *vc = [[TPTBController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//检测FPS
- (void)testFPSLabel {
    _fpsLabel = [YYFPSLabel new];
    _fpsLabel.frame = CGRectMake(200, 200, 50, 30);
    [_fpsLabel sizeToFit];
    [self.view addSubview:_fpsLabel];
}

-(UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView = [WBUtil createImageVIew:@"zelda" CornRadius:0];
    }
    return _headImageView;
}
@end
