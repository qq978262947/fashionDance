//
//  LLUpView.h
//  汽车－参数页面
//
//  Created by 李璐 on 16/3/18.
//  Copyright © 2016年 李璐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLUpView : UIView

@property(nonatomic,assign)CGFloat leftWidth;

@property(nonatomic,assign)CGFloat widthCell;

/*
 *数据源，内存LLParameterModel
 */
@property(nonatomic,strong)NSArray * data;

@end
