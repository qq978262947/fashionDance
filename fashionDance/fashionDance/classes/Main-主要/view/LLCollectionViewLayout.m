//
//  LLCollectionViewLayout.m
//  collectionlayout练习
//
//  Created by 李璐 on 16/3/11.
//  Copyright © 2016年 李璐. All rights reserved.
//
#import "Config.h"
#import "LLCollectionViewLayout.h"
#define picture_height WScreenHeight/2
#define cell_height WScreenHeight/4
#define section_number 2

@interface LLCollectionViewLayout ()

/** 存放所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;
/** 存放所有列的当前高度 */
@property (nonatomic, strong) NSMutableArray *columnHeights;

@end

@implementation LLCollectionViewLayout


- (NSMutableArray *)columnHeights
{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}


/**
 * 初始化
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
//    // 清除之前所有的布局属性
//    [self.attrsArray removeAllObjects];
//    // 开始创建每一个cell对应的布局属性
    for (int i = 0; i < section_number; i++) {
        [self instanceAttrsWithSection:i];
    }
}

-(void)instanceAttrsWithSection:(NSUInteger)section
{
    NSInteger count = [self.collectionView numberOfItemsInSection:section];
    for (NSInteger i = 0; i < count; i++) {
        // 创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:section];
        // 获取indexPath位置cell对应的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }

}

/**
 * 决定cell的排布
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}

/**
 * 返回indexPath位置cell对应的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // 设置布局属性的frame
    CGFloat w = WScreenWidth;//(collectionViewW - XMGDefaultEdgeInsets.left - XMGDefaultEdgeInsets.right - (XMGDefaultColumnCount - 1) * XMGDefaultColumnMargin) / XMGDefaultColumnCount;
    CGFloat h;//此处固定
    CGFloat x;
    CGFloat y;
    

    if(indexPath.section == 0)
    {
        //图片块
        h = picture_height;
        y = 0;
        x = 0;
    }
    else if (indexPath.section == 1)
    {
        //在售块
        h = cell_height;
        y = picture_height + indexPath.item * cell_height;
        x = 0;
    }
    else
    {
        //停售块
        h = cell_height;
        y = picture_height + indexPath.item * cell_height;
        x = WScreenWidth;
    }
    
    attrs.frame = CGRectMake(x, y, w, h);
    
    return attrs;
}

- (CGSize)collectionViewContentSize
{
    CGFloat maxX;
    CGFloat maxY;
    
    maxX = WScreenWidth;
    NSInteger numItemInSection1 = [self.collectionView numberOfItemsInSection:1];
//    NSInteger numItemInSection2 = [self.collectionView numberOfItemsInSection:2];
//    NSInteger maxItem = numItemInSection2 ? numItemInSection1 : numItemInSection2 > numItemInSection1;
    
    maxY = picture_height + numItemInSection1 * cell_height;
    
    return CGSizeMake(maxX, maxY);
}


@end
