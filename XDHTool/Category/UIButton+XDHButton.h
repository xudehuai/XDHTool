//
//  UIButton+XDHButton.h
//  XDHTool
//
//  Created by xudehuai on 2017/6/16.
//  Copyright © 2017年 com.xudehuai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ButtonActionBlock)(UIButton *button);

@interface UIButton (XDHButton)

/**
 快速创建按钮
 
 @param title 文本内容
 @param fontSize 字体大小
 @param titleColor 字体颜色
 @param frame 尺寸
 @param image 图片
 @param selectedImage 图片
 @return 按钮
 */
+ (instancetype)xdh_buttonWithTitle:(NSString *) title fontSize:(NSUInteger) fontSize titleColor:(UIColor *) titleColor frame:(CGRect) frame image:(UIImage *) image selectedImage:(UIImage *) selectedImage;

/**
 添加点击事件

 @param block 点击事件
 */
- (void)xdh_addTouchUpInsideAction:(ButtonActionBlock) block;

@end
