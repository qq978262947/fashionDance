//
//  UIImage+reSize.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/8.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "UIImage+reSize.h"
// 是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

@implementation UIImage (reSize)

+ (UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

// 等比例缩放
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

//根据版本判断传进来的imageName加载的版本
+ (UIImage *)newImageAboutVersionWithImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:iOS7?[imageName stringByAppendingString:@"_os7"]:imageName];
    return image == nil ? [UIImage imageNamed:imageName] : image;
}
//拉伸图片
+ (UIImage *)resizedImage:(NSString *)name
{
    UIImage *image = [UIImage newImageAboutVersionWithImageName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

+(UIImage *)captureWithView:(UIView *)view{
    //开启图片上下文
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    //将view图层渲染到上下文
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //返回上下文中的图片
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    //结束上下文
    UIGraphicsEndImageContext();
    return newImage;
}

@end
