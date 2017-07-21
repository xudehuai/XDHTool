//
//  UIImageView+XDHImageView.m
//  XDHTool
//
//  Created by xudehuai on 2017/7/9.
//  Copyright © 2017年 com.xudehuai. All rights reserved.
//

#import "UIImageView+XDHImageView.h"

@implementation UIImageView (XDHImageView)

+ (instancetype)xdh_imageViewWithImage:(UIImage *)image frame:(CGRect)frame {
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = frame;
    
    return imageView;
}

@end
