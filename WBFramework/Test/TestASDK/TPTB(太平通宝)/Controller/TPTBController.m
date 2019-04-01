//
//  TPTBController.m
//  WBFramework
//
//  Created by apple on 2018/9/29.
//  Copyright © 2018年 wayneking. All rights reserved.
//  暂时未想出和UIView混合开发的方法

#import "TPTBController.h"
#import <WRNavigationBar/WRNavigationBar.h>

@interface TPTBController ()
@property(nonatomic,strong) ASDisplayNode *containerNode;

@property(nonatomic,strong) ASImageNode *bgImageNode;
@property(nonatomic,strong) ASImageNode *avatorImageNode;
@property(nonatomic,strong) ASTextNode *nameNode;


@end

@implementation TPTBController

//由于继承自ASViewController,所以初始化需要放到init方法中  initWitNode
-(instancetype)init{
    if (self = [super initWithNode:[ASDisplayNode new]]) {
        self.node.backgroundColor = [UIColor redColor];
        
        [self.node addSubnode:self.bgImageNode];
        self.bgImageNode.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        
        [self.node addSubnode:self.nameNode];
        self.nameNode.frame = CGRectMake(100, 200, 100, 40);
        
        [self.node addSubnode:self.avatorImageNode];
        self.avatorImageNode.frame = CGRectMake(100, 250, 60, 60);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

- (void)createUI{
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //隐藏Nav背景
    [self wr_setNavBarBackgroundAlpha:0];
    
    self.title = @"无界太平通宝";
    
    
}

#pragma mark - Getter And Setter
-(ASImageNode *)bgImageNode{
    if (!_bgImageNode) {
        _bgImageNode = [[ASImageNode alloc]init];
        _bgImageNode.image = [WBUtil createImageWithColor:[WBUtil createHexColor:@"#190A4F"]];
        _bgImageNode.style.preferredSize = CGSizeMake(screenWidth, 178);
    }
    return _bgImageNode;
}

-(ASImageNode *)avatorImageNode{
    if (!_avatorImageNode) {
        _avatorImageNode = [[ASImageNode alloc]init];
        _avatorImageNode.image = [WBUtil createImageWithColor:[UIColor whiteColor]];
    }
    return _avatorImageNode;
}

-(ASTextNode *)nameNode{
    if (!_nameNode) {
        _nameNode = [[ASTextNode alloc]init];
        
        NSMutableParagraphStyle *prage = [[NSMutableParagraphStyle alloc]init];
        prage.alignment = NSTextAlignmentCenter;
        
        NSDictionary *style = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor whiteColor],NSParagraphStyleAttributeName:prage};
        _nameNode.attributedText = [[NSMutableAttributedString alloc]initWithString:@"V血拼的蜗牛" attributes:style];
        
    }
    return _nameNode;
}


@end
