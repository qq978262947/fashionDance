//
//  UIImageView+downloadImage.m
//  百思不得姐
//
//  Created by 汪俊 on 16/2/29.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "UIImageView+downloadImage.h"
#import "UIImage+cirlcle.h"

@implementation UIImageView (downloadImage)
- (void)setHeader:(NSString *)url
{
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : placeholder;
    }];
}

- (void)setImagewithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage completed:(void(^)(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL))completed {
    [self sd_setImageWithURL:url placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : placeholderImage;
    }];
}

- (void)setNormalImagewithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage completed:(void(^)(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL))completed {
    [self sd_setImageWithURL:url placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? image : placeholderImage;
    }];
}

@end
