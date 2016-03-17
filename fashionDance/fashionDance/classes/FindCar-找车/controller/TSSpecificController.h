//
//  TSSpecificController.h
//  fashionDance
//
//  Created by Dylan on 3/15/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSSpecificController : UIViewController
@property (nonatomic,strong)NSArray * specificArray;
@property (nonatomic,strong)NSString * titleStr;

@property (nonatomic,copy)void (^TSSpecificControllerRetBlock)(TSSpecificController *spec,NSNumber * number,NSArray * selectArray);
/**
 *  @param specificArray 所有的数组
 *  @param title  标题
 *  @param  选中数组
 *  @param  选中数字（根据选中数字判断选中状态）
 */
+(instancetype)specificControllerWithArray:(NSArray *)specificArray andTitle:(NSString *)title;
@end
