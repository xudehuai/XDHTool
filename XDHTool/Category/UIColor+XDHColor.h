//
//  UIColor+XDHColor.h
//  XDHTool
//
//  Created by xudehuai on 2017/6/16.
//  Copyright © 2017年 com.xudehuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XDHColor)

// 随机颜色
+ (instancetype)xdh_randomColor;
// 16进制颜色
+ (instancetype)xdh_colorWithHexString:(uint32_t)hexStr;

@end
