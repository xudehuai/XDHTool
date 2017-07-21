//
//  UIView+XDHView.m
//  XDHTool
//
//  Created by xudehuai on 2017/6/16.
//  Copyright © 2017年 com.xudehuai. All rights reserved.
//

#import "UIView+XDHView.h"
#import <objc/objc-runtime.h>

static char kActionHandlerTapGestureKey;
static char kActionHandlerTapBlockKey;

@implementation UIView (XDHView)

- (void)xdh_addTapActionWithBlock:(TapActionBlock)block {
    
    // 获取关联的tap手势
    UITapGestureRecognizer *tap = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
    
    if (!tap) {
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
        // 关联tap手势
        objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, tap, OBJC_ASSOCIATION_RETAIN);
    }
    // 关联block
    objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)tapAction:(UITapGestureRecognizer *) sender {
    
    if (sender.state == UIGestureRecognizerStateRecognized) {
        // 获取关联block
        TapActionBlock block = objc_getAssociatedObject(self, &kActionHandlerTapBlockKey);
        if (block) {
            block(sender);
        }
    }
}

- (UIImage *)xdh_generateImage {
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIViewController *)xdh_viewcontroller {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)xdh_removeSubViews {
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

@end
