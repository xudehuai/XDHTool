//
//  XDHCustomPickerView.m
//  FanBei_User
//
//  Created by xudehuai on 2017/5/23.
//  Copyright © 2017年 xudehuai. All rights reserved.
//

#import "XDHCustomPickerView.h"

@interface XDHCustomPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIView *contentView;

@end

@implementation XDHCustomPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 250)];
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.contentView];
        
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.cancelButton.frame = CGRectMake(0, 0, 60, 35);
        [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.cancelButton];
        
        self.finishButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.finishButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - CGRectGetWidth(self.cancelButton.frame), 0, CGRectGetWidth(self.cancelButton.frame), CGRectGetHeight(self.cancelButton.frame));
        [self.finishButton setTitle:@"完成" forState:UIControlStateNormal];
        self.finishButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.finishButton];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.cancelButton.frame) + 10, 0, [UIScreen mainScreen].bounds.size.width - 2 * (CGRectGetMaxX(self.cancelButton.frame) + 10), CGRectGetHeight(self.cancelButton.frame));
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
        
        self.picker = [[UIPickerView alloc] init];
        self.picker.dataSource = self;
        self.picker.delegate = self;
        self.picker.frame = CGRectMake(0, CGRectGetMaxY(self.cancelButton.frame), [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.contentView.frame) - CGRectGetMaxY(self.cancelButton.frame));
        self.picker.backgroundColor = [UIColor colorWithRed:235.f / 250.f green:237.f / 250.f blue:243.f / 250.f alpha:1.f];
        [self.contentView addSubview:self.picker];
        
    }
    
    return self;
}

- (void)cancelButtonAction {
    
    [self hide];
}

- (void)show {
    
    for (int component = 0 ; component < self.dataArray.count; component++) {
        [self.picker selectRow:0 inComponent:component animated:YES];
    }
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.transform = CGAffineTransformMakeTranslation(0, 0);
    
    __weak __typeof__(self) weakSelf = self;
    
    [UIView animateWithDuration:0.33 animations:^{
        weakSelf.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        weakSelf.contentView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(self.contentView.frame));
    }];
}

- (void)hide {
 
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    self.contentView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(self.contentView.frame));
    
    __weak __typeof__(self) weakSelf = self;
    
    [UIView animateWithDuration:0.33 animations:^{
        weakSelf.backgroundColor = [UIColor clearColor];
        weakSelf.contentView.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@synthesize dataArray = _dataArray;

- (NSMutableArray<NSMutableArray<NSString *> *> *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    
    if (!dataArray || dataArray.count == 0) {
        
        return;
    }
    
    for (NSMutableArray *array in dataArray) {
        if (!array || array.count == 0) {
            return;
        }
    }
    
    _dataArray = dataArray;
    [self.selectedArray removeAllObjects];
    for (NSArray *array in _dataArray) {
        [self.selectedArray addObject:@(0)];
    }
    [self.picker reloadAllComponents];
}

- (NSMutableArray<NSNumber *> *)selectedArray {
    
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray array];
    }
    return _selectedArray;
}


#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return self.dataArray.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    NSArray *array = self.dataArray[component];
    
    return array.count;
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSArray *array = self.dataArray[component];
    
    return array[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    [self.selectedArray replaceObjectAtIndex:component withObject:@(row)];

}

@end
