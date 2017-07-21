//
//  UILabel+XDHLabel.h
//  XDHTool
//
//  Created by xudehuai on 2017/6/16.
//  Copyright © 2017年 com.xudehuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (XDHLabel)

/**
 快速创建标签

 @param text 文本内容
 @param fontSize 字体大小
 @param textColor 字体颜色
 @param frame 尺寸
 @return 标签
 */
+ (instancetype)xdh_labelWithText:(NSString *) text fontSize:(NSUInteger) fontSize textColor:(UIColor *) textColor frame:(CGRect) frame;



@end
