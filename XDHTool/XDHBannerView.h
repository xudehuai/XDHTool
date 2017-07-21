//
//  XDHBannerView.h
//  XDHUtil
//
//  Created by xudehuai on 2017/3/1.
//  Copyright © 2017年 com.xudehuai All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDHBannerView : UIView

// index改变回调
typedef void (^IndexChangeBlock) (NSInteger xdh_index);

// index改变回调
@property (nonatomic, copy) IndexChangeBlock block;
// 页码指示器
@property (nonatomic, strong) UIPageControl *xdh_pageControl;
// 图片名字或者URL
@property (nonatomic, strong) NSMutableArray <NSString *>*xdh_dataImages;
// 当前index
@property (nonatomic, assign) NSInteger xdh_currentIndex;
// 占位图
@property (nonatomic, strong) UIImage *xdh_placeHolderImage;
// 本地或者网路图片标识
@property (nonatomic, assign) BOOL xdh_isLocalImages;
// 开启自动更改图片
- (void)xdh_startAutoScroll;
// 停止更改图片
- (void)xdh_stopAutoScroll;

@end
