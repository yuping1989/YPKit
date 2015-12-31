//
//  YPUpwardsPicker.m
//  ChangQingQuan
//
//  Created by 喻平 on 15/1/29.
//  Copyright (c) 2015年 com.ucqq.ChangQingQuan. All rights reserved.
//

#import "YPUpwardsPicker.h"

@implementation YPUpwardsPicker

- (void)awakeFromNib {
    self.backgroundView = [[UIView alloc] init];
    _backgroundView.backgroundColor = [UIColor blackColor];
    if ([YPUpwardsPicker appearance].barItemTintColor) {
        [_cancelItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [YPUpwardsPicker appearance].barItemTintColor}
                                   forState:UIControlStateNormal];
        [_okItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [YPUpwardsPicker appearance].barItemTintColor}
                               forState:UIControlStateNormal];
    }
    
    _pickerView.delegate = self;
}

+ (YPUpwardsPicker *)instance {
    return [[[NSBundle mainBundle] loadNibNamed:@"YPUpwardsPicker" owner:nil options:nil] firstObject];
}

- (void)showInView:(UIView *)view
         withTitle:(NSString *)title
        dateSource:(NSArray *)dataSource
      selectedText:(NSString *)selectedText
   completionBlock:(void (^)(NSString *text))completionBlock {
    self.completionBlock = completionBlock;
    self.dataSources =@[dataSource];
    self.selectedText = selectedText;
    [self showInView:view withTitle:title];
    if ([dataSource containsObject:_selectedText]) {
        [_pickerView selectRow:[dataSource indexOfObject:_selectedText]
                   inComponent:0
                      animated:NO];
    }
}

- (void)showInView:(UIView *)view
         withTitle:(NSString *)title
       dataSources:(NSArray *)dataSources
     selectedTexts:(NSArray *)selectedTexts
   completionBlock:(void (^)(NSArray *))completionBlock {
    self.completionBlock = completionBlock;
    self.dataSources = dataSources;
    [self showInView:view withTitle:title];
    if (selectedTexts.count == dataSources.count) {
        for (int i = 0; i < dataSources.count; i++) {
            if (selectedTexts.count >= i) {
                NSArray *dataSource = dataSources[i];
                NSString *selectedText = selectedTexts[i];
                if ([dataSource containsObject:selectedText]) {
                    [_pickerView selectRow:[dataSource indexOfObject:selectedText]
                               inComponent:i
                                  animated:NO];
                }
            }
        }
    }
}

- (void)showInView:(UIView *)view
         withTitle:(NSString *)title {
    [YPNativeUtil  hideKeyboard];
    _titleLabel.text = title;
    _backgroundView.frame = view.bounds;
    self.width = view.width;
    [view addSubview:_backgroundView];
    [view addSubview:self];
    
    _backgroundView.alpha = 0.0f;
    self.y = view.height;
    [UIView animateWithDuration:0.25f animations:^{
        _backgroundView.alpha = 0.7f;
        self.y = view.height - self.height;
    }];
}
- (IBAction)cancelButtonClicked:(id)sender {
    [UIView animateWithDuration:0.25f animations:^{
        self.backgroundView.alpha = 0.0f;
        self.y = self.superview.height;
    } completion:^(BOOL finished) {
        [self.backgroundView removeFromSuperview];
        [self removeFromSuperview];
    }];
}
- (IBAction)okButtonClicked:(id)sender {
    if (_completionBlock) {
        if (_dataSources.count == 1) {
            _completionBlock(_dataSources[0][[_pickerView selectedRowInComponent:0]]);
        } else {
            NSMutableArray *array = [NSMutableArray array];
            for (int i = 0; i < _dataSources.count; i++) {
                [array addObject:_dataSources[i][[_pickerView selectedRowInComponent:i]]];
            }
            _completionBlock(array);
        }
    }
    [self cancelButtonClicked:sender];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return _dataSources.count;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_dataSources[component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _dataSources[component][row];
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (_delegate && [_delegate respondsToSelector:@selector(yp_pickerView:widthForComponent:)]) {
        return [_delegate yp_pickerView:self widthForComponent:component];
    }
    return self.width / _dataSources.count;
}


@end
