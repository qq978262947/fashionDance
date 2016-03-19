//
//  LLCanshuCollectionLayout.m
//  汽车－参数页面
//
//  Created by 李璐 on 16/3/18.
//  Copyright © 2016年 李璐. All rights reserved.
//

//我们现在要努力让它双向滑动

#import "LLCanshuCollectionLayout.h"

@interface LLCanshuCollectionLayout ()

@property (nonatomic) UICollectionViewScrollDirection scrollDirection;
@property (nonatomic) NSArray * attriArray;


//收集的每一排的width
@property(nonatomic,assign)CGFloat widthRow;

//收集的列高度
@property(nonatomic,assign)CGFloat heightColumn;
@end

@implementation LLCanshuCollectionLayout


-(CGFloat)minimumInteritemSpacing
{
    if (!_minimumInteritemSpacing) {
        _minimumInteritemSpacing = 1;
    }
    return _minimumInteritemSpacing;
}

-(CGFloat)minimumLineSpacing
{
    if (!_minimumLineSpacing) {
        _minimumLineSpacing = 1;
    }
    return _minimumLineSpacing;
}

-(void)prepareLayout
{
    [super prepareLayout];
    
    self.attriArray = nil;
    
    NSInteger sectionNumber = [self.collectionView numberOfSections];
    NSMutableArray * arrayTmp = [NSMutableArray array];
    for (int i = 0; i < sectionNumber; i++) {
        NSInteger itemNumber = [self.collectionView numberOfItemsInSection:i];
        for (int j = 0; j < itemNumber; j++) {
            NSIndexPath * path = [NSIndexPath indexPathForItem:j inSection:i];
            //获得attri
            UICollectionViewLayoutAttributes * attri = [self layoutAttributesForItemAtIndexPath:path];
            //收集attri
            [arrayTmp addObject:attri];
        }
    }//end for section
    self.attriArray = arrayTmp;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGRect frame;
    frame.size = self.sizeOfItem;
    //确定x、y
    if (indexPath.item%self.columnNumber == 0) {
        self.widthRow = -1;
        //转入下一行
        //从始至终返回的size height都一样
        self.heightColumn = indexPath.item/self.columnNumber * frame.size.height;
    }
    
    frame.origin = CGPointMake(self.widthRow + self.minimumInteritemSpacing, self.heightColumn + self.minimumLineSpacing);
    attri.frame = frame;
    
    //更新widthRow heightColumn
    self.widthRow = CGRectGetMaxX(frame);
    
    return attri;
}

-(CGSize)collectionViewContentSize
{
    CGFloat width = self.columnNumber * (self.sizeOfItem.width + self.minimumInteritemSpacing) + self.minimumInteritemSpacing;
    CGFloat height = self.heightColumn + (self.sizeOfItem.height + self.minimumLineSpacing);
    return CGSizeMake(width, height);
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attriArray;
}
@end
