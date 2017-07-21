//
//  UITextView+XDHTextView.m
//  XDHTool
//
//  Created by xudehuai on 2017/6/16.
//  Copyright © 2017年 com.xudehuai. All rights reserved.
//

#import "UITextView+XDHTextView.h"
#import <objc/runtime.h>
@implementation UITextView (XDHTextView)

+ (instancetype)xdh_textViewWithFontSize:(NSUInteger)fontSize textColor:(UIColor *)textColor textInset:(UIEdgeInsets)textInset frame:(CGRect)frame {
    
    UITextView *textView = [UITextView new];
    textView.font = [UIFont systemFontOfSize:fontSize];
    textView.textColor = textColor ? textColor : [UIColor blackColor];
    textView.textContainerInset = textInset;
    textView.frame = frame;
    
    return textView;
}


-(NSString *)placeholder {
    
    return self.label.text;
}

- (void)setPlaceholder:(NSString *)placeholder {
    
    self.label.text = placeholder;
    //文字可显示区域
    CGSize size = CGSizeMake(100, CGFLOAT_MAX);
    //计算文字所占区域
    CGSize labelSize = [self.placeholder boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.label.font} context:nil].size;
    self.label.frame = CGRectMake(self.textContainerInset.left + 5, self.textContainerInset.top, 100, labelSize.height);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:nil];
}

- (UIColor *)placeholderColor {
    
    return self.label.textColor;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    
    self.label.textColor = placeholderColor;
}

- (UILabel *)label {
    
    UILabel *label = objc_getAssociatedObject(self, @"label");
    
    if (!label) {
        label = [[UILabel alloc] init];
        label.font = self.font;
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        
        [self addSubview:label];
        
        objc_setAssociatedObject(self, @"label", label, OBJC_ASSOCIATION_RETAIN);
    }
    
    return label;
}

- (void)textDidChange:(NSNotification *) sender {
    
    self.label.hidden = self.hasText;
}

@end
