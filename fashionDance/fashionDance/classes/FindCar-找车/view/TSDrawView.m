//
//  TSDrawView.m
//  TSDrawPriceView
//
//  Created by Dylan on 3/15/16.
//  Copyright © 2016 Dylan. All rights reserved.
//

#import "TSDrawView.h"
#define TSChartX 20.0
//小间距
#define TSSmallW (([UIScreen mainScreen].bounds.size.width-TSChartX*2)/55.0)
//大间距
#define TSBigW (([UIScreen mainScreen].bounds.size.width-TSChartX*2)/11.0)
//总宽度
#define TSChartW ([UIScreen mainScreen].bounds.size.width-TSChartX*2)
//位置y
#define TSChartY 100
//lable位置Y
#define TSLableY (TSChartY-45)
@interface TSDrawView()
@property (nonatomic,strong)UIImageView * smallView;
@property (nonatomic,strong)UIImageView * bigView;

@property (nonatomic,strong)UILabel * moneyLabel;

@end

@implementation TSDrawView
-(void)clears
{
    //归位
    self.smallView.center=CGPointMake(TSChartX, TSChartY+20);
    self.bigView.center=CGPointMake(TSChartX+TSChartW, TSChartY+20);
    self.moneyLabel.center=CGPointMake(SCRW/2, TSLableY);
    self.moneyLabel.text=@"1万-100+万";
    //归零
    self.bigNum=[NSNumber numberWithInteger:101];
    self.smallNum=[NSNumber numberWithInteger:0];
    self.bigNumber=101;
    self.smallNumber=0;
    //重新绘图
    [self setNeedsDisplay];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        UILabel * priceLabel=[[UILabel alloc]init];
        
        [self addSubview:priceLabel];
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.top.equalTo(10);
        }];
        priceLabel.text = @"价格";
        
        self.backgroundColor=[UIColor whiteColor];
        UIImageView * smallView=[[UIImageView alloc]initWithFrame:CGRectMake(TSChartX, TSChartY+10, 20, 20)];
        smallView.image=[UIImage imageNamed:@"left2"];
        self.smallView=smallView;
        smallView.center=CGPointMake(TSChartX, TSChartY+20);
        UIImageView * bigView=[[UIImageView alloc]initWithFrame:CGRectMake(TSChartX+TSChartW, TSChartY+10, 20, 20)];
        self.bigView=bigView;
        bigView.image=[UIImage imageNamed:@"right2"];
         bigView.center=CGPointMake(TSChartX+TSChartW, TSChartY+20);
        bigView.userInteractionEnabled=YES;
        smallView.userInteractionEnabled=YES;
        //smallView.backgroundColor=[UIColor orangeColor];
        //bigView.backgroundColor=[UIColor greenColor];
        [self addSubview:smallView];
        [self addSubview:bigView];
        
        UIPanGestureRecognizer * smallPangesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(smallPanAction:)];
        UIPanGestureRecognizer * bigPangesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(bigPanAction:)];
        [smallView addGestureRecognizer:smallPangesture];
        [bigView addGestureRecognizer:bigPangesture];
        
        self.moneyLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 65, 15)];
        [self addSubview:self.moneyLabel];
        self.moneyLabel.center=CGPointMake(SCRW/2, TSLableY);
        self.moneyLabel.backgroundColor=WJColor(217, 241, 251);
        self.moneyLabel.layer.cornerRadius=2;
        self.moneyLabel.font=[UIFont systemFontOfSize:10];
        self.moneyLabel.layer.cornerRadius=10;
        self.moneyLabel.textAlignment=NSTextAlignmentCenter;
        self.moneyLabel.text=@"1万-100+万";
        self.bigNum=[NSNumber numberWithInteger:101];
        self.smallNum=[NSNumber numberWithInteger:0];
    }
    return self;
}
-(void)smallPanAction:(UIPanGestureRecognizer *)pan
{
    //小滑块滑动
    CGPoint point = [pan translationInView:self];
    if (pan.view.center.x+point.x<TSChartX||pan.view.center.x+point.x>(TSChartX+TSChartW-3))
    {
        NSLog(@"到达边界");
    }
    else
    {
    //修改关联视图的位置
        pan.view.center = CGPointMake(pan.view.center.x+point.x, pan.view.center.y);
        //联动效果
        if (self.bigView.center.x<=pan.view.center.x+3)
        {
            self.bigView.center=CGPointMake(pan.view.center.x+3, pan.view.center.y);
            //pan.view.center.x+3;
        }
    }
    //清零
    [pan setTranslation:CGPointZero inView:self];
    NSInteger number1 =(self.bigView.center.x-TSChartX)/TSSmallW;//大
    NSInteger number2 = (pan.view.center.x-TSChartX)/TSSmallW;//小
    //大数值判断
    if (number1<=35)
    {
        self.bigNumber=number1;
        
    }//35
    else if(number1>35&&number1<=40)
    {
        self.bigNumber=35+3*(number1-35);
    }//50
    else if(number1>40&&number1<=45)
    {
        self.bigNumber=50+4*(number1-40);
    }//70
    else if(number1>45&&number1<=50)
    {
        self.bigNumber=70+6*(number1-45);
    }//100
    else if(number1>50)
    {
        self.bigNumber=101;
    }
    
    //小数值判断
    if (number2<=35)
    {
        self.smallNumber=number2;
    }//35
    else if(number2>35&&number2<=40)
    {
        self.smallNumber=35+3*(number2-35);
    }//50
    else if(number2>40&&number2<=45)
    {
        self.smallNumber=50+4*(number2-40);
    }//70
    else if(number2>45&&number2<=50)
    {
        self.smallNumber=70+6*(number2-45);
    }//100
    else if(number2>50)
    {
        self.smallNumber=101;
    }
    self.bigNum=[NSNumber numberWithInteger:self.bigNumber];
    self.smallNum=[NSNumber numberWithInteger:self.smallNumber];
    
    [self setNeedsDisplay];
    if (self.bigNumber==101)
    {
        self.moneyLabel.text=[NSString stringWithFormat:@"%ld万-100+万",self.smallNumber];
    }
    else
    {
        self.moneyLabel.text=[NSString stringWithFormat:@"%ld万-%ld万",self.smallNumber,self.bigNumber];
    }
    self.moneyLabel.center=CGPointMake((self.smallView.center.x+self.bigView.center.x)/2, TSLableY);
    
    self.TSDrawViewDragBlock(self,YES);
}
-(void)bigPanAction:(UIPanGestureRecognizer *)pan
{
    
    //小滑块滑动
    CGPoint point = [pan translationInView:self];
    //修改关联视图的位置,3
    if (pan.view.center.x+point.x<(TSChartX+3)||pan.view.center.x+point.x>(TSChartX+TSChartW))
    {
        NSLog(@"到达边界");
    }
    else
    {
        pan.view.center = CGPointMake(pan.view.center.x+point.x, pan.view.center.y);
        //联动效果
        if (self.smallView.center.x>=pan.view.center.x-3)
        {
            self.smallView.center=CGPointMake(pan.view.center.x-3, pan.view.center.y);
        }
    }
    //清零
    [pan setTranslation:CGPointZero inView:self];
    //给数字赋值
    NSInteger number1 = (pan.view.center.x-TSChartX)/TSSmallW;//大
    NSInteger number2 = (self.smallView.center.x-TSChartX)/TSSmallW;//小
    //大数值判断
    if (number1<=35)
    {
        self.bigNumber=number1;

    }//35
    else if(number1>35&&number1<=40)
    {
        self.bigNumber=35+3*(number1-35);
    }//50
    else if(number1>40&&number1<=45)
    {
        self.bigNumber=50+4*(number1-40);
    }//70
    else if(number1>45&&number1<=50)
    {
        self.bigNumber=70+6*(number1-45);
    }//100
    else if(number1>50)
    {
        self.bigNumber=101;
    }
    
    //小数值判断
    if (number2<=35)
    {
        self.smallNumber=number2;
    }//35
    else if(number2>35&&number2<=40)
    {
        self.smallNumber=35+3*(number2-35);
    }//50
    else if(number2>40&&number2<=45)
    {
        self.smallNumber=50+4*(number2-40);
    }//70
    else if(number2>45&&number2<=50)
    {
        self.smallNumber=70+6*(number2-45);
    }//100
    else if(number2>50)
    {
        self.smallNumber=101;
    }
    
    self.bigNum=[NSNumber numberWithInteger:self.bigNumber];
    self.smallNum=[NSNumber numberWithInteger:self.smallNumber];
    
    if (self.bigNumber==101) {
        self.moneyLabel.text=[NSString stringWithFormat:@"%ld万-100+万",self.smallNumber];
    }
    else
    {
        self.moneyLabel.text=[NSString stringWithFormat:@"%ld万-%ld万",self.smallNumber,self.bigNumber];
    }
    self.moneyLabel.center=CGPointMake((self.smallView.center.x+self.bigView.center.x)/2, TSLableY);
    [self setNeedsDisplay];
    
    self.TSDrawViewDragBlock(self,NO);
}
-(void)drawRect:(CGRect)rect
{
    [self drawBack];
    [self drawSelectLine];
}
-(void)drawSelectLine
{
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //一条线，获取一个path
    UIBezierPath * path=[UIBezierPath bezierPath];
    //把上下文渲染到视图
    [WJColor(123, 200, 230) set];
    CGContextSetLineWidth(ctx, 5);
    //位置
    [path moveToPoint:CGPointMake(self.smallView.center.x, TSChartY)];
    [path addLineToPoint:CGPointMake(self.bigView.center.x, TSChartY)];
    
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);//描边
}
-(void)drawBack
{
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //一条线，获取一个path
    UIBezierPath * path=[UIBezierPath bezierPath];
    //把上下文渲染到视图
    [[UIColor grayColor]set];
    CGContextSetLineWidth(ctx, 5);
    //位置
    [path moveToPoint:CGPointMake(TSChartX, TSChartY)];
    [path addLineToPoint:CGPointMake(TSChartW+TSChartX, TSChartY)];
    
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);//描边
    
    //5刻度线
    for (int i = 1;i<=10;i++)
    {
        UIBezierPath * path=[UIBezierPath bezierPath];
        //把上下文渲染到视图
        [[UIColor grayColor]set];
        CGContextSetLineWidth(ctx, 1);
        //位置
        [path moveToPoint:CGPointMake(TSChartX+TSBigW*i, TSChartY)];
        [path addLineToPoint:CGPointMake(TSChartX+TSBigW*i, TSChartY-13)];
        //数字刻度
        UILabel * numberLabel=[[UILabel alloc]initWithFrame:CGRectMake(TSChartX+TSBigW*i-5, TSChartY-30, 18, 9)];
        numberLabel.font=[UIFont systemFontOfSize:10];
        numberLabel.textColor=[UIColor grayColor];
        [self addSubview:numberLabel];
        NSInteger number;
        switch (i) {
            case 8:
                number=50;
                break;
            case 9:
                number=70;
                break;
            case 10:
            {
                number=100;
            }
                break;
                
            default:
                number=i*5;
                break;
        }
        numberLabel.text=[NSString stringWithFormat:@"%ld",number];
        
        
        CGContextAddPath(ctx, path.CGPath);
        CGContextStrokePath(ctx);//描边
    }
    //小刻度线
    for (int i = 5;i<=50;i++)
    {
        UIBezierPath * path=[UIBezierPath bezierPath];
        //把上下文渲染到视图
        [[UIColor grayColor]set];
        CGContextSetLineWidth(ctx, 1);
        //位置
        [path moveToPoint:CGPointMake(TSChartX+TSSmallW*i, TSChartY)];
        [path addLineToPoint:CGPointMake(TSChartX+TSSmallW*i, TSChartY-8)];
        
        CGContextAddPath(ctx, path.CGPath);
        CGContextStrokePath(ctx);//描边
    }
}

@end
