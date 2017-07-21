//
//  XDHTagView.h
//  FanBei_User
//
//  Created by xudehuai on 2017/4/8.
//  Copyright © 2017年 com.xudehuai All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDHTagView : UIView
// 顶部边距
@property (nonatomic, assign) CGFloat topSpace;
// 左侧边距
@property (nonatomic, assign) CGFloat leadingSpace;
// 底部边距
@property (nonatomic, assign) CGFloat bottomSpace;
// 右侧边距
@property (nonatomic, assign) CGFloat trailingSpace;
// 横向间隙
@property (nonatomic, assign) CGFloat horizontalSpace;
// 纵向间隙
@property (nonatomic, assign) CGFloat verticalSpace;


// 标签高度
@property (nonatomic, assign) CGFloat labelHeight;
// 标签圆角
@property (nonatomic, assign) CGFloat labelCornerRadius;


// 字体大小
@property (nonatomic, assign) NSUInteger labelFontSize;
// 标签未选择颜色
@property (nonatomic, strong) UIColor *normalBgColor;
// 标签选中颜色
@property (nonatomic, strong) UIColor *selectedBgColor;
// 标签未选中边框色
@property (nonatomic, strong) UIColor *normalBorderColor;
// 标签选中边框色
@property (nonatomic, strong) UIColor *selectedBorderColor;
// 是否可以点击
@property (nonatomic, assign) BOOL touchEnabled;
// 数据源
@property (nonatomic, strong) NSMutableArray <NSString *>*dataArray;
// 总宽度
@property (nonatomic, assign) CGFloat width;
// 总高度
@property (nonatomic, assign, readonly) CGFloat height;

@end
