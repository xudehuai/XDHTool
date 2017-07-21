//
//  UIColor+XDHColor.m
//  XDHTool
//
//  Created by xudehuai on 2017/6/16.
//  Copyright © 2017年 com.xudehuai. All rights reserved.
//

#import "UIColor+XDHColor.h"

@implementation UIColor (XDHColor)

+ (instancetype)xdh_randomColor {
    
    NSInteger redValue = arc4random() % 256;
    NSInteger greenValue = arc4random() % 256;
    NSInteger blueValue = arc4random() % 256;
    
    return [UIColor colorWithRed:redValue / 255.0 green:greenValue / 255.0 blue:blueValue / 255.0 alpha:1.0];
}

+ (instancetype)xdh_colorWithHexString:(uint32_t)hexStr {
    
    return [UIColor colorWithRed:((float)((hexStr & 0xFF0000) >> 16)) / 255.0 green:((float)((hexStr & 0xFF00) >> 8)) / 255.0 blue:((float)(hexStr & 0xFF)) / 255.0 alpha:1.0];
}

@end 
