//
//  YPUpwardsPicker.h
//  ChangQingQuan
//
//  Created by 喻平 on 15/1/29.
//  Copyright (c) 2015年 com.ucqq.ChangQingQuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YPUpwardsPicker;
@protocol YPUpwardsPickerDelegate <NSObject>
@optional
- (CGFloat)yp_pickerView:(YPUpwardsPicker *)pickerView widthForComponent:(NSInteger)component;
@end

@interface YPUpwardsPicker : UIView <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, weak) IBOutlet UIPickerView *pickerView;
@property (nonatomic, weak) IBOutlet UIToolbar *toolBar;
@property (nonatomic, weak) IBOutlet UIBarItem *cancelItem;
@property (nonatomic, weak) IBOutlet UIBarItem *okItem;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *unitLabel;

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIColor *barItemTintColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) NSArray *dataSources;
@property (nonatomic, strong) NSString *selectedText;
@property (nonatomic, strong) CompletionBlockWithData completionBlock;
@property (nonatomic, assign) id<YPUpwardsPickerDelegate> delegate;
+ (YPUpwardsPicker *)instance;
- (void)showInView:(UIView *)view
         withTitle:(NSString *)title
        dateSource:(NSArray *)dataSource
      selectedText:(NSString *)selected
   completionBlock:(void (^)(NSString *text))completionBlock;
- (void)showInView:(UIView *)view
         withTitle:(NSString *)title
       dataSources:(NSArray *)dataSources
     selectedTexts:(NSArray *)selectedTexts
   completionBlock:(void (^)(NSArray *results))completionBlock;
@end
