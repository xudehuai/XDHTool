//
//  UIView+XDHView.h
//  XDHTool
//
//  Created by xudehuai on 2017/6/16.
//  Copyright © 2017年 com.xudehuai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TapActionBlock)(UITapGestureRecognizer *tap);

@interface UIView (XDHView)

/**
 添加Tap

 @param block 点击事件
 */
- (void)xdh_addTapActionWithBlock:(TapActionBlock) block;

/**
 将View转换为Image

 @return 截图
 */
- (UIImage *) xdh_generateImage;

/**
 获取Viewcontroller

 @return viewcontroller
 */
- (UIViewController *)xdh_viewcontroller;

/**
 移除所有的subview
 */
- (void)xdh_removeSubViews;

@end
