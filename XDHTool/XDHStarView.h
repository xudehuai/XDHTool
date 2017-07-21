//
//  XDHStarView.h
//  FanBei_User
//
//  Created by xudehuai on 2017/4/1.
//  Copyright © 2017年 com.xudehuai All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XDHStarType) {
    // 整数
    XDHStarTypeInteger = 0,
    // 浮点数
    XDHStarTypeFloat,
};

@interface XDHStarView : UIView
// 类型 默认为XDHStarTypeInteger
@property (nonatomic, assign) XDHStarType starType;
// 触摸性 默认为NO
@property (nonatomic, assign) BOOL touchEnabled;
// 根据传入值计算出来的视图宽度
@property (nonatomic, assign, readonly) CGFloat width;
// 根据传入值计算出来的视图高度
@property (nonatomic, assign, readonly) CGFloat height;
// 当前星级
@property (nonatomic, assign) CGFloat currentStar;

// 使用该方法初始化后，会计算得出正确的宽和高，再进行frame的设置
- (instancetype)initWithStarCount:(NSInteger) starCount starSize:(CGFloat) starSize starSpace:(CGFloat) starSpace emptyImage:(UIImage *) emptyImage fullImage:(UIImage *) fullImage;

@end
