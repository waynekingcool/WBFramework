//
//  TestCellNode.m
//  WBFramework
//
//  Created by wayneking on 2018/8/30.
//  Copyright © 2018年 wayneking. All rights reserved.
//

#import "TestCellNode.h"

@interface TestCellNode()

@property(nonatomic,strong) ASTextNode *titleNode;
@property(nonatomic,strong) ASImageNode *imageNode;
@property(nonatomic,strong) ASTextNode *dataNode;
@property(nonatomic,strong) ASDisplayNode *lineNode;
@property(nonatomic, assign) int count;
@end

@implementation TestCellNode

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.titleNode = [[ASTextNode alloc]init];
        NSDictionary *titleStyle = @{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor blackColor]};
        self.titleNode.maximumNumberOfLines = 4;
        self.titleNode.style.flexShrink = 1.0;
        self.titleNode.style.flexGrow = 1.0;
//        self.titleNode.truncationMode = NSLineBreakByTruncatingTail;
        self.titleNode.attributedText = [[NSAttributedString alloc]initWithString:@"这是一段标题啊这是一段标题啊这是一段标题啊这是一段标题啊这是一段标题啊这是一段标题啊这是一段标题啊这是一段标题啊这是一段标题啊这是一段标题啊1" attributes:titleStyle];
        self.titleNode.truncationAttributedText = [[NSAttributedString alloc]initWithString:@"...more" attributes:titleStyle];
        self.titleNode.enabled = YES;
        self.titleNode.shadowColor = [UIColor blackColor].CGColor;
        self.titleNode.shadowRadius = 3.f;
        self.titleNode.shadowOffset = CGSizeMake(-2,-2);
        self.titleNode.shadowOpacity = 0.3;
        [self addSubnode:self.titleNode];
        
        [self.titleNode addTarget:self action:@selector(tap:) forControlEvents:ASControlNodeEventTouchUpInside];
        
        CGFloat width = (screenWidth-2*7-2*2)/3;
        CGFloat height =  width*93/108;
        self.imageNode = [[ASImageNode alloc]init];
        self.imageNode.image = [UIImage imageNamed:@"love.jpg"];
        self.imageNode.style.preferredSize = CGSizeMake(width, height);
        self.imageNode.cornerRadius = 5.f;
        //貌似只有textNode才有阴影,imageview还是得靠layer来实现
//        self.imageNode.layer.masksToBounds = NO;
//        self.imageNode.layer.shadowRadius = 10.f;
//        self.imageNode.layer.shadowOffset = CGSizeMake(5, 5);
//        self.imageNode.layer.shadowColor = [UIColor blackColor].CGColor;
//        self.imageNode.layer.shadowOpacity = 0.5;
        [self addSubnode:self.imageNode];
        
        self.dataNode = [[ASTextNode alloc]init];
        NSDictionary *dataStyle = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor lightGrayColor]};
        self.dataNode.attributedText = [[NSAttributedString alloc]initWithString:@"2018-08-30" attributes:dataStyle];
        [self addSubnode:self.dataNode];
        
        self.lineNode = [[ASDisplayNode alloc]init];
        self.lineNode.backgroundColor = [UIColor blackColor];
        self.lineNode.style.preferredSize = CGSizeMake(screenWidth, 1);
        [self addSubnode:self.lineNode];
        
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    if (self.count == 1) {
        self.titleNode.maximumNumberOfLines = 0;
    }
    
    ASStackLayoutSpec *stack = [ASStackLayoutSpec
                                stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                spacing:10
                                justifyContent:ASStackLayoutJustifyContentSpaceAround
                                alignItems:ASStackLayoutAlignItemsStart
                                children:@[self.titleNode,self.imageNode]];

    ASStackLayoutSpec *bottom = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:10.0 justifyContent:ASStackLayoutJustifyContentSpaceAround alignItems:ASStackLayoutAlignItemsStart children:@[self.dataNode,self.lineNode]];
    
    ASStackLayoutSpec *all = [[ASStackLayoutSpec alloc]init];
    all.direction = ASStackLayoutDirectionVertical;
    all.spacing = 10;
    all.children = @[stack,bottom];
    
    ASInsetLayoutSpec *insect = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 14, 10, 14) child:all];
    
    
    return insect;
}

- (void)tap:(ASTextNode *)node{
    WBLog(@"????");
    node.maximumNumberOfLines = 0;
    self.count += 1;
    [self setNeedsLayout];
}

@end
