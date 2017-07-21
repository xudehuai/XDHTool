//
//  EdgeInsetsLabel.m
//  FanBei_User
//
//  Created by xudehuai on 2017/3/18.
//  Copyright © 2017年 com.xudehuai All rights reserved.
//

#import "EdgeInsetsLabel.h"

// 可以设置文本边框的UILabel
@implementation EdgeInsetsLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
}

@end
