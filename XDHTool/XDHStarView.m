//
//  XDHStarView.m
//  FanBei_User
//
//  Created by xudehuai on 2017/4/1.
//  Copyright © 2017年 com.xudehuai All rights reserved.
//

#import "XDHStarView.h"

//static NSString *emptyImage = @"star_normal";
//static NSString *fullImage = @"star_selected";

@interface XDHStarView ()
// 最大星星数目，默认为5
@property (nonatomic, assign) NSInteger starCount;
// 星星尺寸
@property (nonatomic, assign) CGFloat starSize;
// 间距
@property (nonatomic, assign) CGFloat starSpace;
// 空白的图片
@property (nonatomic, strong) UIImage *emptyImage;
// 选择的图片
@property (nonatomic, strong) UIImage *fullImage;
// 底层空白星星视图
@property (nonatomic, strong) UIView *emtyView;
// 上层带色星星视图
@property (nonatomic, strong) UIView *fullView;

@end

@implementation XDHStarView

- (instancetype)initWithStarCount:(NSInteger)starCount starSize:(CGFloat)starSize starSpace:(CGFloat)starSpace emptyImage:(UIImage *)emptyImage fullImage:(UIImage *)fullImage {
    
    _starType = XDHStarTypeInteger;
    // 默认为5星
    if (!starCount || starCount == 0) {
        _starCount = 5;
    }
    else {
        _starCount = starCount;
    }
    // 星星大小默认为20 * 20
    if (!starSize || starSize == 0) {
        starSize = 20.f;
    }
    else {
        _starSize = starSize;
    }
    
    _starSpace = starSpace ? starSize : 0.f;
    
    _emptyImage = emptyImage;
    _fullImage = fullImage;
    
    _width = _starSize * _starCount + _starSpace * (_starCount - 1);
    _height = _starSize;
    
    if (self = [super initWithFrame:CGRectMake(0, 0, _width, _height)]) {
        
        [self initView];
    }
    
    return self;
}

// 进行布局
- (void)initView {
    
    self.emtyView = [[UIView alloc] initWithFrame:self.bounds];
    self.emtyView.clipsToBounds = YES;
    self.emtyView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.emtyView];
    
    self.fullView = [[UIView alloc] initWithFrame:self.bounds];
    self.fullView.clipsToBounds = YES;
    self.fullView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.fullView];
    
    for (int i = 0; i < self.starCount * 2; i++) {
        
        UIImageView *image = [[UIImageView alloc] init];
        image.frame = CGRectMake((_starSize + _starSpace) * (i / 2), 0, _starSize, _starSize);
        // 空白的
        if (i % 2 == 0) {
            image.image = _emptyImage;
            [self.emtyView addSubview:image];
        }
        // 选中的
        else {
            image.image = _fullImage;
            [self.fullView addSubview:image];
        }
    }
}

- (void)setCurrentStar:(CGFloat)currentStar {
    
    // 特殊处理(整形星星类型下，1.0、2.0...处理)
    if (self.starType == XDHStarTypeInteger) {
        if (_currentStar - (NSInteger)_currentStar == 0.0) {
            _currentStar = currentStar;
        }
        else {
            _currentStar = (NSInteger)currentStar + 1;
        }
    }
    else {
        _currentStar = currentStar;
    }
    // 范围检验
    _currentStar = _currentStar < 0 ? 0 : _currentStar;
    _currentStar = _currentStar > self.starCount ? self.starCount : _currentStar;

    [self updateUI];
}

- (void) updateUI {
    // (星星宽度 + 间距) * 整数部分 + 星星宽度 * 小数部分
    CGFloat width = (NSInteger)self.currentStar * (self.starSize + self.starSpace) + (CGFloat)(self.currentStar - (NSInteger)self.currentStar) * self.starSize;
    self.fullView.frame = CGRectMake(0, 0, width, self.starSize);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (self.touchEnabled) {
        
        [super touchesBegan:touches withEvent:event];
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        
        // 整数部分
        NSInteger integer = point.x / (self.starSize + self.starSpace);
        
        // 小数部分
        CGFloat decimals = (CGFloat)(point.x - integer * (self.starSize + self.starSpace));
        
        if ((decimals > self.starSize && decimals <self.starSize + self.starSpace) || self.starType == XDHStarTypeInteger) {
            self.currentStar = integer + 1.0;
        }
        else {
            self.currentStar = integer + (CGFloat)(decimals / self.starSize);
        }
    }

}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (self.touchEnabled) {
        
        [super touchesBegan:touches withEvent:event];
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        
        // 整数部分
        NSInteger integer = point.x / (self.starSize + self.starSpace);
        
        // 小数部分
        CGFloat decimals = (CGFloat)(point.x - integer * (self.starSize + self.starSpace));
        
        // 点击区域在
        if ((decimals > self.starSize && decimals <self.starSize + self.starSpace) || self.starType == XDHStarTypeInteger) {
            self.currentStar = integer + 1.0;
        }
        else {
            self.currentStar = integer + (CGFloat)(decimals / self.starSize);
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (self.touchEnabled) {

        [super touchesBegan:touches withEvent:event];
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        
        // 整数部分
        NSInteger integer = point.x / (self.starSize + self.starSpace);
        
        // 小数部分
        CGFloat decimals = (CGFloat)(point.x - integer * (self.starSize + self.starSpace));
        
        if ((decimals > self.starSize && decimals <self.starSize + self.starSpace) || self.starType == XDHStarTypeInteger) {
            self.currentStar = integer + 1.0;
        }
        else {
            self.currentStar = integer + (CGFloat)(decimals / self.starSize);
        }
    }
}

@end
