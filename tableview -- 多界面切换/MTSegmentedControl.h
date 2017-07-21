//
//  MTSegmentedControl.h
//  tableview -- 多界面切换
//
//  Created by 镇微 on 2017/7/20.
//  Copyright © 2017年 镇微. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MTSegmentedControlDelegate <NSObject>

- (void)segumentSelectionChange:(NSInteger)selection;

@end

@interface MTSegmentedControl : UIView

@property (nonatomic, strong) id <MTSegmentedControlDelegate> delegate;

/**
 标题集合
 */
@property (nonatomic, strong) NSArray *titleSource;
/**
 标题颜色
 */
@property (nonatomic, strong) UIColor *titleColor;
/**
 选中颜色
 */
@property (nonatomic, strong) UIColor *selectColor;
/**
 标题大小
 */
@property (nonatomic, strong) UIFont *titleFont;
/**
 下划线颜色
 */
@property (nonatomic, strong) UIColor *bottomColor;
/**
 选中下标
 */
@property (nonatomic, assign) NSInteger selectSeugment;
/**
 是否动画切换
 */
@property (nonatomic, assign) NSInteger isAnimated;

+ (MTSegmentedControl *)segmentedControlFrame:(CGRect)frame titleDataSource:(NSArray *)titleDataSource Delegate:(id)delegate;

+ (MTSegmentedControl *)segmentedControlFrame:(CGRect)frame titleDataSource:(NSArray *)titleDataSource backgroundColor:(UIColor *)backgroundColor titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont selectColor:(UIColor *)selectColor bottomColor:(UIColor *)bottomColor Delegate:(id)delegate;

- (void)segmentedControl:(NSArray *)titleDataSource Delegate:(id)delegate;

- (void)segmentedControl:(NSArray *)titleDataSource backgroundColor:(UIColor *)backgroundColor titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont selectColor:(UIColor *)selectColor bottomColor:(UIColor *)bottomColor Delegate:(id)delegate;
@end
