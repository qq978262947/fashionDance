//
//  llParameterController.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "llParameterController.h"
#import "LLDownView.h"
#import "LLUpView.h"


#define left_width 100
#define down_cell_height 200
#define down_up_cell_width 100
#define up_cell_height 150

@interface llParameterController ()

@end

@implementation llParameterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

-(void)setupUI
{
    //加载上 view
    UINib * nib = [UINib nibWithNibName:NSStringFromClass([LLUpView class]) bundle:nil];
    
    LLUpView * upView = [nib instantiateWithOwner:nil options:nil].lastObject;
    [upView setFrame:CGRectMake(0, 0, WJScreenW, up_cell_height)];
    upView.leftWidth = left_width;
    //    upView.scrollViewDidScrollBlock = ^(UIScrollView * scrollView){
    //
    //    };
    [self.view addSubview:upView];
    
    //加载下 view
    LLDownView * downView = [[LLDownView alloc]init];
    [downView setFrame:CGRectMake(0, up_cell_height, WJScreenW, WJScreenH - up_cell_height)];
    downView.leftWidth = left_width;
    downView.cellHeight = down_cell_height;
    downView.cellWidth = down_up_cell_width;
    [self.view addSubview:downView];
}
/**
 * 一个view（内含tableview左，collection view右），一个view（内含scroll view）组成
 * 上下结构，联动效果
 */

@end
