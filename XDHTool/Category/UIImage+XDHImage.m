//
//  UIImage+XDHImage.m
//  XDHTool
//
//  Created by xudehuai on 2017/7/5.
//  Copyright © 2017年 com.xudehuai. All rights reserved.
//

#import "UIImage+XDHImage.h"

@implementation UIImage (XDHImage)

+ (instancetype)xdh_imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

// 等比例缩放图片
+ (UIImage*)xdh_imageByScalingAndCroppingForSize:(CGSize)targetSize image:(UIImage *)image {
    
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaleFactor = 0.0;
    
    // 根据横向和纵向的缩放比例进行缩放
    if (targetWidth / width < targetHeight / height) {
        scaleFactor = targetWidth / width;
    }
    else {
        scaleFactor = targetHeight / height;
    }
    
    CGFloat scaledWidth = width * scaleFactor;
    CGFloat scaledHeight = height * scaleFactor;
    
    CGSize scaledSize = CGSizeMake(scaledWidth, scaledHeight);
    UIGraphicsBeginImageContext(scaledSize); // this will crop
    [image drawInRect:CGRectMake(0, 0, scaledWidth,scaledHeight)];
    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
