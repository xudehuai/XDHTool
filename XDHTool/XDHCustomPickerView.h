//
//  XDHCustomPickerView.h
//  FanBei_User
//
//  Created by xudehuai on 2017/5/23.
//  Copyright © 2017年 xudehuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDHCustomPickerView : UIView
// 取消按钮
@property (nonatomic, strong) UIButton *cancelButton;
// 标题
@property (nonatomic, strong) UILabel *titleLabel;
// 完成按钮
@property (nonatomic, strong) UIButton *finishButton;
// picker
@property (nonatomic, strong) UIPickerView *picker;
// 数据源
@property (nonatomic, strong) NSMutableArray <NSMutableArray <NSString *>*> *dataArray;
// 当前选中值
@property (nonatomic, strong) NSMutableArray <NSNumber *> *selectedArray;
// 显示
- (void)show;
// 隐藏
- (void)hide;

@end
