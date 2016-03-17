//
//  UIImageView+downloadImage.h
//  百思不得姐
//
//  Created by 汪俊 on 16/2/29.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>

@interface UIImageView (downloadImage)
/**
 *  设置头像(圆角)
 *
 *  @param url NSString *
 */
- (void)setHeader:(NSString *)url;
/**
 *  图片下载圆角处理的工具类
 *
 *  @param url 下载图片的url
 *  @param placeholderImage 占位图片
 *  @param completed        完成下载调用的block
 */
- (void)setImagewithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage completed:(void(^)(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL))completed;


/**
 *  图片下载的工具类
 *
 *  @param url 下载图片的url
 *  @param placeholderImage 占位图片
 *  @param completed        完成下载调用的block
 */
- (void)setNormalImagewithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage completed:(void(^)(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL))completed;

@end
