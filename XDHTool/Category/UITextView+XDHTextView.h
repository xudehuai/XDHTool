//
//  UITextView+XDHTextView.h
//  XDHTool
//
//  Created by xudehuai on 2017/6/16.
//  Copyright © 2017年 com.xudehuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (XDHTextView)

@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, strong) UIColor *placeholderColor;

/**
 快速创建文本域

 @param fontSize 字体大小
 @param textColor 字体颜色
 @param textInset 文本边距
 @param frame 尺寸
 @return 文本域
 */
+ (instancetype)xdh_textViewWithFontSize:(NSUInteger) fontSize textColor:(UIColor *) textColor textInset:(UIEdgeInsets) textInset frame:(CGRect) frame;

@end
