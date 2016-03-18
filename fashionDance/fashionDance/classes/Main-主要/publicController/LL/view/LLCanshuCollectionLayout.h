//
//  LLCanshuCollectionLayout.h
//  汽车－参数页面
//
//  Created by 李璐 on 16/3/18.
//  Copyright © 2016年 李璐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLCanshuCollectionLayout : UICollectionViewLayout

/**
 * 固定column数，必选
 */
@property(nonatomic,assign)NSInteger columnNumber;
/**
 *  务必
 */
@property(nonatomic,assign)CGSize sizeOfItem;

@property (nonatomic) CGFloat minimumLineSpacing;
@property (nonatomic) CGFloat minimumInteritemSpacing;
@end
