//
//  XDHTagView.m
//  FanBei_User
//
//  Created by xudehuai on 2017/4/8.
//  Copyright © 2017年 com.xudehuai All rights reserved.
//

#import "XDHTagView.h"

@interface XDHTagView ()

// 所有的标签
@property (nonatomic, strong) NSMutableArray <UILabel *>*labelArray;
// 选中的标签
@property (nonatomic, strong) NSMutableArray <UILabel *>*selectdArray;

@end

@implementation XDHTagView

- (instancetype)init {

    _dataArray = [NSMutableArray array];
    _labelArray = [NSMutableArray array];
    _selectdArray = [NSMutableArray array];
    
    _width = 0.0;
    _height = 0.0;
    
    _topSpace = 10.0;
    _leadingSpace = 10.0;
    _bottomSpace = 10.0;
    _trailingSpace = 10.0;
    _horizontalSpace = 10.0;
    _verticalSpace = 10.0;
    
    _labelHeight = 28.0;
    _labelCornerRadius = _labelHeight / 2;
    
    _labelFontSize = 14;
    
    _normalBgColor = [UIColor whiteColor];
    _selectedBgColor = [UIColor orangeColor];
    _normalBorderColor = [UIColor blackColor];
    _selectedBorderColor = [UIColor orangeColor];
    
    _touchEnabled = NO;

    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self updateViews];
        self.frame = CGRectMake(0, 0, _width, _height);
    }

    return self;
}

- (void)updateViews {
    
    if (_labelHeight < _labelFontSize) {
        _labelHeight = _labelFontSize;
    }
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_labelArray removeAllObjects];
    [_selectdArray removeAllObjects];
    
    [_dataArray enumerateObjectsUsingBlock:^(NSString * _Nonnull str, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UILabel *templLabel = [[UILabel alloc] init];
        templLabel.text = str;
        templLabel.textAlignment = NSTextAlignmentCenter;
        templLabel.font = [UIFont systemFontOfSize:_labelFontSize];
        templLabel.textColor = [UIColor blackColor];
        templLabel.layer.borderWidth = 0.5;
        templLabel.layer.cornerRadius = _labelCornerRadius;
        templLabel.layer.masksToBounds = YES;
        templLabel.layer.borderColor = [UIColor blackColor].CGColor;
        [self addSubview:templLabel];
        
        // 获取文本大小
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:_labelFontSize]};
        CGSize size = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, _labelHeight)
                                        options:
                       NSStringDrawingTruncatesLastVisibleLine |
                       NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
        
        CGFloat labelWidth = size.width + 20;
        
        if (idx == 0) {
            
            templLabel.frame = CGRectMake(_leadingSpace, _topSpace, labelWidth, _labelHeight);
        }
        else {
            
            // 获取上一个元素
            UILabel *lastLabel = _labelArray.lastObject;
            
            // 换行
            if (CGRectGetMaxX(lastLabel.frame) + _horizontalSpace + labelWidth > _width - _trailingSpace) {
                
                templLabel.frame = CGRectMake(_leadingSpace, CGRectGetMaxY(lastLabel.frame) + _verticalSpace, labelWidth, _labelHeight);
            }
            // 不换行
            else {
                templLabel.frame = CGRectMake(CGRectGetMaxX(lastLabel.frame) + _horizontalSpace, CGRectGetMinY(lastLabel.frame), labelWidth, _labelHeight);
            }
            
        }
        
        [_labelArray addObject:templLabel];
        
        if (_touchEnabled) {
            templLabel.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
            [templLabel addGestureRecognizer:tap];
        }
    }];

    if (_dataArray.count != 0) {
        UILabel *lastLabel = _labelArray.lastObject;
        _height = CGRectGetMaxY(lastLabel.frame) + _bottomSpace;
    }
    else {
        _height = 0;
    }
}

- (void)setWidth:(CGFloat)width {
    
    _width = width;
    
    [self updateViews];
}

- (void)setDataArray:(NSMutableArray<NSString *> *)dataArray {
    
    _dataArray = dataArray;

    [self updateViews];
}

- (void)setTopSpace:(CGFloat)topSpace {
    
    _topSpace = topSpace;

    [self updateViews];
}

- (void)setLeadingSpace:(CGFloat)leadingSpace {
    
    _leadingSpace = leadingSpace;

    [self updateViews];
}

- (void)setBottomSpace:(CGFloat)bottomSpace {
    
    _bottomSpace = bottomSpace;

    [self updateViews];
}

- (void)setTrailingSpace:(CGFloat)trailingSpace {
    
    _trailingSpace = trailingSpace;

    [self updateViews];
}

- (void)setHorizontalSpace:(CGFloat)horizontalSpace {
    
    _horizontalSpace = horizontalSpace;

    [self updateViews];
}

- (void)setVerticalSpace:(CGFloat)verticalSpace {
    
    _verticalSpace = verticalSpace;

    [self updateViews];
}

- (void)setLabelHeight:(CGFloat)labelHeight {
    
    _labelHeight = labelHeight;

    [self updateViews];
}

- (void)setLabelCornerRadius:(CGFloat)labelCornerRadius {
    
    _labelCornerRadius = labelCornerRadius;

    [self updateViews];
}

- (void)setNormalColor:(UIColor *)normalColor {
    
    _normalBgColor = normalColor;
    
    [_labelArray enumerateObjectsUsingBlock:^(UILabel * _Nonnull label, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (![_selectdArray containsObject:label]) {
            label.backgroundColor = normalColor;
        }
    }];
}

- (void)setSelectedColor:(UIColor *)selectedColor {
    
    _selectedBgColor = selectedColor;
    
    [_selectdArray enumerateObjectsUsingBlock:^(UILabel * _Nonnull label, NSUInteger idx, BOOL * _Nonnull stop) {
        
        label.backgroundColor = selectedColor;
    }];
}

- (void)setBorderColor:(UIColor *)borderColor {
    
    _normalBorderColor = borderColor;
    
    [_labelArray enumerateObjectsUsingBlock:^(UILabel * _Nonnull label, NSUInteger idx, BOOL * _Nonnull stop) {
        
        label.layer.borderColor = borderColor.CGColor;
    }];
}

- (void)setTouchEnabled:(BOOL)touchEnabled {
    
    _touchEnabled = touchEnabled;
    
    for (UILabel *label in _labelArray) {
        if (_touchEnabled) {
            label.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
            [label addGestureRecognizer:tap];
        }
        else {
            label.userInteractionEnabled = NO;
            [_selectdArray removeAllObjects];
            label.backgroundColor = _normalBgColor;
        }
    }
}

- (void)tap:(UITapGestureRecognizer *) sender {
    
    UILabel *tempLabel = (UILabel *)sender.view;
    
    // 取消选中
    if ([self.selectdArray containsObject:(UILabel *)sender.view]) {
        
        tempLabel.textColor = [UIColor blackColor];
        sender.view.backgroundColor = _normalBgColor;
        [self.selectdArray removeObject:(UILabel *)sender.view];
    }
    // 选中
    else {
        
        tempLabel.textColor = [UIColor whiteColor];
        sender.view.backgroundColor = _selectedBgColor;
        [self.selectdArray addObject:(UILabel *)sender.view];
    }
}

@end
