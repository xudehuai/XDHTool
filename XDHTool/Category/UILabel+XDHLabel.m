//
//  UILabel+XDHLabel.m
//  XDHTool
//
//  Created by xudehuai on 2017/6/16.
//  Copyright © 2017年 com.xudehuai. All rights reserved.
//

#import "UILabel+XDHLabel.h"

@implementation UILabel (XDHLabel)

+ (instancetype)xdh_labelWithText:(NSString *) text fontSize:(NSUInteger)fontSize textColor:(UIColor *)textColor frame:(CGRect)frame {
    
    UILabel *label = [UILabel new];
    label.text = text;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = textColor ? textColor : [UIColor blackColor];
    label.frame = frame;
    
    return label;
}

@end
