//
//  UIButton+XDHButton.m
//  XDHTool
//
//  Created by xudehuai on 2017/6/16.
//  Copyright © 2017年 com.xudehuai. All rights reserved.
//

#import "UIButton+XDHButton.h"
#import <objc/objc-runtime.h>

// 关联key
static char kButtonActionKey;

@implementation UIButton (XDHButton)


+ (instancetype)xdh_buttonWithTitle:(NSString *)title fontSize:(NSUInteger)fontSize titleColor:(UIColor *)titleColor frame:(CGRect)frame image:(UIImage *)image selectedImage:(UIImage *)selectedImage {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [button setTitleColor:titleColor ? titleColor : [UIColor blackColor] forState:UIControlStateNormal];
    button.frame = frame;
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    
    return button;
}

- (void)xdh_addTouchUpInsideAction:(ButtonActionBlock)block {
    // 关联block
    objc_setAssociatedObject(self, &kButtonActionKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonAction:(UIButton *) sender {
    // 获取关联block
    ButtonActionBlock block = objc_getAssociatedObject(self, &kButtonActionKey);
    if (block) {
        block(sender);
    }
}


@end
