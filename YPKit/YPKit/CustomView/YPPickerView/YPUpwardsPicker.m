//
//  YPUpwardsPicker.m
//  ChangQingQuan
//
//  Created by 喻平 on 15/1/29.
//  Copyright (c) 2015年 com.ucqq.ChangQingQuan. All rights reserved.
//

#import "YPUpwardsPicker.h"

@implementation YPUpwardsPicker

+ (YPUpwardsPicker *)instance {
    return [[[NSBundle mainBundle] loadNibNamed:@"YPUpwardsPicker" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([YPUpwardsPicker appearance].barItemTintColor) {
        [self.cancelItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [YPUpwardsPicker appearance].barItemTintColor} forState:UIControlStateNormal];
        [self.okItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [YPUpwardsPicker appearance].barItemTintColor} forState:UIControlStateNormal];
    }
    
    self.pickerView.delegate = self;
}

- (void)showInView:(UIView *)view
         withTitle:(NSString *)title
        dataSource:(NSArray *)dataSource
      selectedText:(NSString *)selectedText
   completionBlock:(void (^)(NSString *text))completionBlock {
    self.completionBlock = completionBlock;
    self.dataSources = @[dataSource];
    self.selectedText = selectedText;
    [self showInView:view withTitle:title];
    if ([dataSource containsObject:self.selectedText]) {
        [self.pickerView selectRow:[dataSource indexOfObject:self.selectedText]
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
                    [self.pickerView selectRow:[dataSource indexOfObject:selectedText]
                               inComponent:i
                                  animated:NO];
                }
            }
        }
    }
}

- (void)showInView:(UIView *)view
         withTitle:(NSString *)title {
    self.titleLabel.text = title;
    [self show];
}

- (IBAction)okButtonClicked:(id)sender {
    if (self.completionBlock) {
        if (self.dataSources.count == 1) {
            self.completionBlock(self.dataSources[0][[self.pickerView selectedRowInComponent:0]]);
        } else {
            NSMutableArray *array = [NSMutableArray array];
            for (int i = 0; i < self.dataSources.count; i++) {
                [array addObject:self.dataSources[i][[self.pickerView selectedRowInComponent:i]]];
            }
            self.completionBlock(array);
        }
    }
    [self cancelButtonClicked:sender];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.dataSources.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.dataSources[component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataSources[component][row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (self.delegate && [self.delegate respondsToSelector:@selector(yp_pickerView:widthForComponent:)]) {
        return [self.delegate yp_pickerView:self widthForComponent:component];
    }
    return self.yp_width / self.dataSources.count;
}

@end
