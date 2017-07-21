//
//  UIImage+XDHImage.h
//  XDHTool
//
//  Created by xudehuai on 2017/7/5.
//  Copyright © 2017年 com.xudehuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XDHImage)

+ (instancetype)xdh_imageWithColor:(UIColor *) color;

// 等比例缩放图片
+ (UIImage*)xdh_imageByScalingAndCroppingForSize:(CGSize)targetSize image:(UIImage *)image;

@end
