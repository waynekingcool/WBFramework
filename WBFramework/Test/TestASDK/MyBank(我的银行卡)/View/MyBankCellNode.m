//
//  MyBankCellNode.m
//  WBFramework
//
//  Created by apple on 2018/9/29.
//  Copyright © 2018年 wayneking. All rights reserved.
//

#import "MyBankCellNode.h"

@interface MyBankCellNode()

@property(nonatomic,strong) ASImageNode *bgImageNode;   //背景图片
@property(nonatomic,strong) ASImageNode *iconImageNode; //银行图标
@property(nonatomic,strong) ASTextNode *bankNameNode;   //银行名称
@property(nonatomic,strong) ASTextNode *infoNode;   //个人信息
@property(nonatomic,strong) ASTextNode *cardNoNode; //银行卡账号
@property(nonatomic,strong) ASTextNode *defaultNode;    //默认
@property(nonatomic,strong) ASButtonNode *manageBtnNode;    //管理g按钮

@end

@implementation MyBankCellNode
-(instancetype)init{
    if (self = [super init]) {
//        self.backgroundColor = [WBUtil createHexColor:@"#190A4F"];
        self.backgroundColor = [UIColor whiteColor];
        [self addSubnode:self.bgImageNode];
        [self addSubnode:self.iconImageNode];
        [self addSubnode:self.bankNameNode];
        [self addSubnode:self.infoNode];
        [self addSubnode:self.cardNoNode];
        [self addSubnode:self.defaultNode];
        [self addSubnode:self.manageBtnNode];
    }
    return self;
}

/*
 ASStackLayoutJustifyContentSpaceBetween  没有边距
 ASStackLayoutJustifyContentSpaceAround 有边距
 ASStackLayoutAlignItemsBaselineLast  水平对齐的话,第一个元素的bottom对齐
 ASStackLayoutAlignItemsBaselineFirst 水平对齐的话,和第一个元素的top对齐
 */
- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    //顶部
    ASStackLayoutSpec *topLeft = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:10 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:@[self.iconImageNode,self.bankNameNode]];

    ASStackLayoutSpec *top = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                     spacing:10
                                                              justifyContent:ASStackLayoutJustifyContentSpaceBetween alignItems:ASStackLayoutAlignItemsBaselineLast
                                                                    children:@[topLeft,self.infoNode]];
    
    ASStackLayoutSpec *middle = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                        spacing:10
                                                                 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter
                                                                       children:@[self.cardNoNode]];
    
    ASStackLayoutSpec *bottom = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                        spacing:10
                                                                 justifyContent:ASStackLayoutJustifyContentSpaceBetween alignItems:ASStackLayoutAlignItemsStart children:@[self.defaultNode,self.manageBtnNode]];
    
    
    ASStackLayoutSpec *all = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                     spacing:15
                                                              justifyContent:ASStackLayoutJustifyContentSpaceBetween alignItems:ASStackLayoutAlignItemsStretch
                                                                    children:@[top,middle,bottom]];
    
    //all漂浮在bgImageView上面
    ASInsetLayoutSpec *allInset = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(21, 16, 11, 16) child:all];
    
    self.bgImageNode.style.preferredSize = CGSizeMake(screenWidth, 117);
    ASOverlayLayoutSpec *over = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:self.bgImageNode overlay:allInset];
    
    //加边框
    ASInsetLayoutSpec *inset = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 16, 20, 16) child:over];

    return inset;
}

#pragma mark - Getter And Setter
-(ASImageNode *)bgImageNode{
    if (!_bgImageNode) {
        _bgImageNode = [[ASImageNode alloc]init];
        _bgImageNode.cornerRadius = 5.f;
        _bgImageNode.image = [WBUtil createImageWithColor:[WBUtil createHexColor:@"#190A4F"]];
    }
    return _bgImageNode;
}

-(ASImageNode *)iconImageNode{
    if (!_iconImageNode) {
        _iconImageNode = [[ASImageNode alloc]init];
        _iconImageNode.image = [UIImage imageNamed:@"bank-name"];
        _iconImageNode.style.preferredSize = CGSizeMake(20, 20);
    }
    return _iconImageNode;
}

-(ASTextNode *)bankNameNode{
    if (!_bankNameNode) {
        _bankNameNode = [[ASTextNode alloc]init];
        
        NSMutableParagraphStyle *parag = [[NSMutableParagraphStyle alloc]init];
        parag.alignment = NSTextAlignmentLeft;
        NSDictionary *style = @{NSForegroundColorAttributeName:[WBUtil createHexColor:@"#97B1FB"],NSFontAttributeName:[UIFont systemFontOfSize:17],NSParagraphStyleAttributeName:parag};
        _bankNameNode.attributedText = [[NSAttributedString alloc]initWithString:@"银行名称" attributes:style];
        
    }
    return _bankNameNode;
}

-(ASTextNode *)infoNode{
    if (!_infoNode) {
        _infoNode = [[ASTextNode alloc]init];
        NSMutableParagraphStyle *parag = [[NSMutableParagraphStyle alloc]init];
        parag.alignment = NSTextAlignmentRight;
        
        NSDictionary *style = @{NSParagraphStyleAttributeName:parag, NSFontAttributeName:[UIFont systemFontOfSize:11],NSForegroundColorAttributeName:[WBUtil createHexColor:@"#C8C8C8"]};
        
        _infoNode.attributedText = [[NSAttributedString alloc]initWithString:@"江西 南昌 *斌" attributes:style];
    }
    return _infoNode;
}

-(ASTextNode *)cardNoNode{
    if (!_cardNoNode) {
        _cardNoNode = [[ASTextNode alloc]init];
        NSMutableParagraphStyle *parag = [[NSMutableParagraphStyle alloc]init];
        parag.alignment = NSTextAlignmentCenter;
        
        NSDictionary *style = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17],NSParagraphStyleAttributeName:parag};
        _cardNoNode.attributedText = [[NSAttributedString alloc]initWithString:@"**** **** **** 1234" attributes:style];
    }
    return _cardNoNode;
}

-(ASTextNode *)defaultNode{
    if (!_defaultNode) {
        _defaultNode = [[ASTextNode alloc]init];
        
        NSMutableParagraphStyle *parag = [[NSMutableParagraphStyle alloc]init];
        parag.alignment = NSTextAlignmentLeft;
        
        NSDictionary *style = @{NSForegroundColorAttributeName:[WBUtil createHexColor:@"#C8C8C8"],NSFontAttributeName:[UIFont systemFontOfSize:10],NSParagraphStyleAttributeName:parag};
        _defaultNode.backgroundColor = [UIColor clearColor];
        _defaultNode.attributedText = [[NSAttributedString alloc]initWithString:@"默认" attributes:style];
    }
    return _defaultNode;
}

-(ASButtonNode *)manageBtnNode{
    if (!_manageBtnNode) {
        _manageBtnNode = [[ASButtonNode alloc]init];
        
        NSMutableParagraphStyle *parag = [[NSMutableParagraphStyle alloc]init];
        parag.alignment = NSTextAlignmentRight;
        
        NSDictionary *style = @{NSForegroundColorAttributeName:[WBUtil createHexColor:@"#4B7CFF"],NSFontAttributeName:[UIFont systemFontOfSize:12],NSParagraphStyleAttributeName:parag};
        _manageBtnNode.titleNode.attributedText = [[NSAttributedString alloc]initWithString:@"点击管理" attributes:style];
        _manageBtnNode.backgroundColor = [UIColor clearColor];
        
    }
    return _manageBtnNode;
}




@end
