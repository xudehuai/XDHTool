//
//  UITextField+XDHTextField.h
//  XDHTool
//
//  Created by xudehuai on 2017/6/16.
//  Copyright © 2017年 com.xudehuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (XDHTextField)

/**
 快速创建文本框

 @param placeholder 占位文本
 @param fontSize 字体大小
 @param textColor 字体颜色
 @param frame 尺寸
 @return 文本框
 */
+ (instancetype)xdh_textFieldWithPlacerHolder:(NSString *) placeholder fontSize:(NSUInteger) fontSize textColor:(UIColor *) textColor frame:(CGRect) frame;

@end
