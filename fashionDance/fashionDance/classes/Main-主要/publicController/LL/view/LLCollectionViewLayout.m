//
//  LLCollectionViewLayout.m
//  collectionlayout练习
//
//  Created by 李璐 on 16/3/11.
//  Copyright © 2016年 李璐. All rights reserved.
//
#import "LLCollectionViewLayout.h"

//为了动态计算每个cell高度我们导入数据模型
#import "LLCarTypeVersionModel.h"

#import "NSString+Extension.h"

#define picture_height SCRH/2
#define cell_height SCRH/4
#define section_number 2

@interface LLCollectionViewLayout ()

/** 存放所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;
/** 当前高度 */
@property (nonatomic, assign) CGFloat contentSizeHeight;

@end

@implementation LLCollectionViewLayout

+(LLCollectionViewLayout *)layoutWithDataSoure:(NSArray<LLCarTypeVersionModel *> *)dataArray
{
    LLCollectionViewLayout * layout = [[LLCollectionViewLayout alloc]init];
    layout.section1DataArray = dataArray;
    
    return layout;
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
    
    // 清除之前所有的布局属性
    [self.attrsArray removeAllObjects];
    
    //准备好content size height
    self.contentSizeHeight = 0;
    // 开始创建每一个cell对应的布局属性
    for (int i = section_number - 1; i >= 0; i--) {
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
//    WJLog(@"layoutAttributesForElementsInRect");
    return self.attrsArray;
}

/**
 * 返回indexPath位置cell对应的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    WJLog(@"layoutAttributesForItemAtIndexPath section--%ld  item--%ld",indexPath.section,indexPath.item);
    // 此处构造一个indexpath位置的attri，所以我们在layoutAttributesForElementsInRect中不按顺序给attri返回也行喽？
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // 设置布局属性的frame
    CGFloat w = SCRW;
    CGFloat h;//此处固定，酌量增加
    CGFloat x;
    CGFloat y;
    

    if(indexPath.section == 0)
    {
        //图片块
        h = picture_height;
        y = 0;
        x = 0;
    }
    else
    {
        //在售块
        h = cell_height;
        //取出data，动态计算
        LLCarTypeVersionModel * model = self.section1DataArray[indexPath.item];
        NSString * string = [[model.year stringValue] stringByAppendingString:model.nameZh];//此处和text cell中耦合
        CGSize size = [string sizeWithFont:LLSubTitleFont maxSize:CGSizeMake(SCRW * 3/5, CGFLOAT_MAX)];//两处和text cell xib耦合--LLSubTitleFont和WScreenWidth * 3/5
        model.heigthYear = size.height;
        //19.5为LLSubTitleFont一行高度
        h += size.height - 18;//和上面LLSubTitleFont耦合
        y = self.contentSizeHeight;
        x = 0;
    }
    
    self.contentSizeHeight += h;
    
    attrs.frame = CGRectMake(x, y, w, h);
    
    return attrs;
}

- (CGSize)collectionViewContentSize
{
    CGFloat maxX;
    
    maxX = SCRW;
    //这里的cell_height我们要动态增加
    
    return CGSizeMake(maxX, self.contentSizeHeight);
}


@end
