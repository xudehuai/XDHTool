//
//  XDHBannerView.m
//  XDHUtil
//
//  Created by xudehuai on 2017/3/1.
//  Copyright © 2017年 com.xudehuai All rights reserved.
//

#import "XDHBannerView.h"

#import <UIView+WebCache.h>
#import <UIImageView+WebCache.h>
@interface XDHBannerView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *xdh_scrollView;

@property (nonatomic, strong) UIImageView *xdh_leftImage;

@property (nonatomic, strong) UIImageView *xdh_centerImage;

@property (nonatomic, strong) UIImageView *xdh_rightImage;

@property (nonatomic, strong) NSTimer *xdh_timer;

@property (nonatomic, assign) double xdh_timeInterval;

@end

@implementation XDHBannerView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.xdh_timeInterval = 5.0;
        self.xdh_currentIndex = 0;
        
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        
        self.xdh_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        self.xdh_scrollView.backgroundColor = [UIColor clearColor];
        self.xdh_scrollView.showsHorizontalScrollIndicator = NO;
        self.xdh_scrollView.contentSize = CGSizeMake(3 * width, height);
        self.xdh_scrollView.contentOffset = CGPointMake(width, 0);
        self.xdh_scrollView.pagingEnabled = YES;
        self.xdh_scrollView.delegate = self;
        [self addSubview:self.xdh_scrollView];
        
        self.xdh_leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(-width, 0, width, height)];
        self.xdh_leftImage.contentMode = UIViewContentModeScaleAspectFill;
        self.xdh_leftImage.backgroundColor = [UIColor clearColor];
        [self.xdh_scrollView addSubview:self.xdh_leftImage];
        
        self.xdh_centerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        self.xdh_centerImage.contentMode = UIViewContentModeScaleAspectFill;
        self.xdh_centerImage.backgroundColor = [UIColor clearColor];
        [self.xdh_centerImage sd_setShowActivityIndicatorView:YES];
        [self.xdh_scrollView addSubview:self.xdh_centerImage];
        
        self.xdh_rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(width, 0, width, height)];
        self.xdh_rightImage.contentMode = UIViewContentModeScaleAspectFill;
        self.xdh_rightImage.backgroundColor = [UIColor clearColor];
        [self.xdh_scrollView addSubview:self.xdh_rightImage];
        
        self.xdh_pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, height - 21, width, 21)];;
        self.xdh_pageControl.currentPage = 0;
        self.xdh_pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:1.0 alpha:0.5];
        self.xdh_pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:self.xdh_pageControl];
        
    }
    return self;
}

- (void)setXdh_dataImages:(NSMutableArray *)xdh_dataImages {
    
    [self xdh_stopAutoScroll];
    
    _xdh_dataImages = xdh_dataImages;
    self.xdh_pageControl.currentPage = 0;
    self.xdh_pageControl.numberOfPages = _xdh_dataImages.count;
    
    if (self.xdh_dataImages.count > 1) {
        
        self.xdh_scrollView.scrollEnabled = YES;
        if (self.xdh_isLocalImages) {
            
            self.xdh_leftImage.image = [UIImage imageNamed: [self.xdh_dataImages lastObject]];
            self.xdh_centerImage.image = [UIImage imageNamed:[self.xdh_dataImages firstObject]];
            self.xdh_rightImage.image = [UIImage imageNamed:self.xdh_dataImages[1]];
        }
        else {
            
            [self.xdh_leftImage sd_setImageWithURL:[NSURL URLWithString:[self.xdh_dataImages lastObject]] placeholderImage:self.xdh_placeHolderImage];
            [self.xdh_centerImage sd_setImageWithURL:[NSURL URLWithString:[self.xdh_dataImages firstObject]] placeholderImage:self.xdh_placeHolderImage];
            [self.xdh_rightImage sd_setImageWithURL:[NSURL URLWithString:self.xdh_dataImages[1]] placeholderImage:self.xdh_placeHolderImage];
        }
    }
    else if (self.xdh_dataImages.count == 1){
        
        self.xdh_scrollView.scrollEnabled = NO;
        if (self.xdh_isLocalImages) {
            
            self.xdh_leftImage.image = [UIImage imageNamed:[self.xdh_dataImages firstObject]];
            self.xdh_centerImage.image = [UIImage imageNamed:[self.xdh_dataImages firstObject]];
            self.xdh_rightImage.image = [UIImage imageNamed:[self.xdh_dataImages firstObject]];
        }
        else {
            
            [self.xdh_leftImage sd_setImageWithURL:[NSURL URLWithString:[self.xdh_dataImages firstObject]] placeholderImage:self.xdh_placeHolderImage];
            [self.xdh_leftImage sd_setImageWithURL:[NSURL URLWithString:[self.xdh_dataImages firstObject]] placeholderImage:self.xdh_placeHolderImage];
            [self.xdh_leftImage sd_setImageWithURL:[NSURL URLWithString:[self.xdh_dataImages firstObject]] placeholderImage:self.xdh_placeHolderImage];
        }
    }
    else {
        
        self.xdh_scrollView.scrollEnabled = NO;
        self.xdh_leftImage.image = self.xdh_placeHolderImage;
        self.xdh_centerImage.image = self.xdh_placeHolderImage;
        self.xdh_rightImage.image = self.xdh_placeHolderImage;
    }
}

- (void)setXdh_isLocalImages:(BOOL)xdh_isLocalImages {
    
    _xdh_isLocalImages = xdh_isLocalImages;
}

- (void)xdh_startAutoScroll {

    if (self.xdh_timer) {
        [self xdh_stopAutoScroll];
    }
    
    self.xdh_timer = [NSTimer scheduledTimerWithTimeInterval:_xdh_timeInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
        [UIView animateWithDuration:0.45 animations:^{
            self.xdh_scrollView.contentOffset = CGPointMake(self.xdh_scrollView.frame.size.width * 2, 0);
        } completion:^(BOOL finished) {
            [self scrollViewDidEndDecelerating:self.xdh_scrollView];
        }];
        
    }];
}

- (void) xdh_stopAutoScroll {
    
    [self.xdh_timer invalidate];
    self.xdh_timer = nil;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self reloadImages];
}

- (void) reloadImages {

    CGFloat offSetX = self.xdh_scrollView.contentOffset.x;
    CGFloat width = self.xdh_scrollView.bounds.size.width;
    NSInteger leftIndex;
    NSInteger rightIndex;

    // 左滑向右移动
    if (offSetX > width) {
        
        self.xdh_currentIndex = self.xdh_currentIndex + 1 > self.xdh_dataImages.count - 1 ? 0 : self.xdh_currentIndex + 1;
    }
    // 右滑向左移动
    else {
        
        self.xdh_currentIndex = self.xdh_currentIndex - 1 < 0 ? self.xdh_dataImages.count - 1 : self.xdh_currentIndex - 1;
    }
    leftIndex = self.xdh_currentIndex - 1 < 0 ? self.xdh_dataImages.count - 1 : self.xdh_currentIndex - 1;
    rightIndex = self.xdh_currentIndex + 1 > self.xdh_dataImages.count - 1 ? 0 : self.xdh_currentIndex + 1;
    // 总是显示中间的图片
    self.xdh_scrollView.contentOffset = CGPointMake(width, 0);
    
    if (self.xdh_isLocalImages) {
        self.xdh_leftImage.image = [UIImage imageNamed:self.xdh_dataImages[leftIndex]];
        self.xdh_centerImage.image = [UIImage imageNamed:self.xdh_dataImages[self.xdh_currentIndex]];
        self.xdh_rightImage.image = [UIImage imageNamed:self.xdh_dataImages[rightIndex]];
    }
    else {
        [self.xdh_leftImage sd_setImageWithURL:[NSURL URLWithString:self.xdh_dataImages[leftIndex]] placeholderImage:self.xdh_placeHolderImage];
        [self.xdh_centerImage sd_setImageWithURL:[NSURL URLWithString:self.xdh_dataImages[self.xdh_currentIndex]] placeholderImage:self.xdh_placeHolderImage];
        [self.xdh_rightImage sd_setImageWithURL:[NSURL URLWithString:self.xdh_dataImages[rightIndex]] placeholderImage:self.xdh_placeHolderImage];
    }
    self.xdh_pageControl.currentPage = self.xdh_currentIndex;
    
    if (self.block) {
        self.block(self.xdh_currentIndex);
    }
}

@end
