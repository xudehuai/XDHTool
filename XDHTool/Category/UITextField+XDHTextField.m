//
//  UITextField+XDHTextField.m
//  XDHTool
//
//  Created by xudehuai on 2017/6/16.
//  Copyright © 2017年 com.xudehuai. All rights reserved.
//

#import "UITextField+XDHTextField.h"

@implementation UITextField (XDHTextField)

+ (instancetype)xdh_textFieldWithPlacerHolder:(NSString *)placeholder fontSize:(NSUInteger)fontSize textColor:(UIColor *)textColor frame:(CGRect)frame {
    
    UITextField *textField = [UITextField new];
    textField.placeholder = placeholder;
    textField.font = [UIFont systemFontOfSize:fontSize];
    textField.textColor = textColor ? textColor : [UIColor blackColor];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.frame = frame;
    
    return textField;
}

@end
