//
//  UIImage+reSize.h
//  fashionDance
//
//  Created by 汪俊 on 16/3/8.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (reSize)

/**改变图片尺寸到CGSize*/
+ (UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size;
/** 等比例缩放*/
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;
/**得到匹配版本的图片*/
+ (UIImage *)newImageAboutVersionWithImageName:(NSString *)imageName;
/**得到拉伸后的图片*/
+ (UIImage *)resizedImage:(NSString *)name;
//根据传进来的view返回一张图片
+(UIImage *)captureWithView:(UIView *)view;



@end
