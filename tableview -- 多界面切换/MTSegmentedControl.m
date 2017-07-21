//
//  MTSegmentedControl.m
//  tableview -- 多界面切换
//
//  Created by 镇微 on 2017/7/20.
//  Copyright © 2017年 镇微. All rights reserved.
//

#import "MTSegmentedControl.h"

#define MTColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface MTSegmentedControl () {
    CGFloat witdthFloat;
    CALayer *bottomLayer;
}

/**
 *  按钮集合
 */
@property (nonatomic, strong) NSMutableArray *btnTitleSource;

@end

@implementation MTSegmentedControl

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self defaultSetting];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self defaultSetting];
    }
    return self;
}

- (void)defaultSetting {
    self.btnTitleSource = [NSMutableArray array];
    self.titleSource = [NSMutableArray array];
    _selectSeugment = 0;
    
    self.backgroundColor = [UIColor whiteColor];
    self.bottomColor = MTColor(255, 185, 35);
    
    self.titleColor = MTColor(102, 102, 102);
    self.titleFont = [UIFont systemFontOfSize:16.0f];
    self.selectColor = MTColor(255, 185, 35);
    self.isAnimated = YES;
    
}

+ (MTSegmentedControl *)segmentedControlFrame:(CGRect)frame titleDataSource:(NSArray *)titleDataSource Delegate:(id)delegate {
    
    MTSegmentedControl * smc = [[self alloc] initWithFrame:frame];
    smc.delegate = delegate;
    smc.titleSource = titleDataSource;
    
    [smc AddSegumentArray:titleDataSource];
    return smc;
}

+ (MTSegmentedControl *)segmentedControlFrame:(CGRect)frame titleDataSource:(NSArray *)titleDataSource backgroundColor:(UIColor *)backgroundColor titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont selectColor:(UIColor *)selectColor bottomColor:(UIColor *)bottomColor Delegate:(id)delegate {
    
    MTSegmentedControl * smc = [[self alloc] initWithFrame:frame];
    smc.backgroundColor = backgroundColor;
    smc.bottomColor = bottomColor;
    
    smc.titleColor = titleColor;
    smc.titleFont = titleFont;
    //    smc.titleFont=[UIFont fontWithName:@".Helvetica Neue Interface" size:14.0f];
    smc.selectColor = selectColor;
    smc.delegate = delegate;
    smc.titleSource = titleDataSource;
    
    [smc AddSegumentArray:titleDataSource];
    return smc;
}

- (void)segmentedControl:(NSArray *)titleDataSource Delegate:(id)delegate {
    
    self.delegate = delegate;
    
    self.titleSource = titleDataSource;
    
    [self AddSegumentArray:titleDataSource];
}

- (void)segmentedControl:(NSArray *)titleDataSource backgroundColor:(UIColor *)backgroundColor titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont selectColor:(UIColor *)selectColor bottomColor:(UIColor *)bottomColor Delegate:(id)delegate {
    
    self.backgroundColor = backgroundColor;
    self.bottomColor = bottomColor;
    
    self.titleColor = titleColor;
    self.titleFont = titleFont;
    //    self.titleFont=[UIFont fontWithName:@".Helvetica Neue Interface" size:14.0f];
    self.selectColor = selectColor;
    self.delegate = delegate;
    
    self.titleSource = titleDataSource;
    
    
    [self AddSegumentArray:titleDataSource];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    
    //设置按钮的frame
    [self setSegumentFrame];
    
}

- (void)AddSegumentArray:(NSArray *)SegumentArray {
    
    // 1.创建按钮
    for (int i = 0; i < SegumentArray.count; i++) {
        
        UIButton * btn = [[UIButton alloc] init];
        btn.tag = i + 1;
        [btn addTarget:self action:@selector(changeSegumentAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            bottomLayer =[[CALayer alloc] init];
            bottomLayer.cornerRadius = 2;
            [self.layer addSublayer:bottomLayer];
        }
        [self addSubview:btn];
        
        [self.btnTitleSource addObject:btn];
    }
    [[self.btnTitleSource firstObject] setSelected:YES];
}

- (void)setSegumentFrame {
    
    // 1.按钮的个数
    NSInteger seugemtNumber = self.titleSource.count;
    
    // 2.按钮的宽度
    witdthFloat = (self.bounds.size.width) / seugemtNumber;
    
    // 3.创建按钮
    for (int i = 0; i < seugemtNumber; i++) {
        
        UIButton * btn = self.btnTitleSource[i];
        
        btn.frame = CGRectMake(i * witdthFloat, 0, witdthFloat, self.bounds.size.height - 4);
        [btn setTitle:self.titleSource[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:self.titleFont];
        [btn setTitleColor:self.titleColor forState:UIControlStateNormal];
        [btn setTitleColor:self.selectColor forState:UIControlStateSelected];
        if (i == _selectSeugment) {
            //            bottomLayer.frame = CGRectMake(i * witdthFloat+witdthFloat/4, self.bounds.size.height - 4, witdthFloat/2, 2);
            bottomLayer.frame = CGRectMake(i * witdthFloat+witdthFloat/8*3, self.bounds.size.height - 8, witdthFloat/4, 4);
            [bottomLayer setBackgroundColor:self.bottomColor.CGColor];
        }
    }
}

- (void)changeSegumentAction:(UIButton *)btn{
    [self selectTheSegument:btn.tag - 1];
}

-(void)selectTheSegument:(NSInteger)segument{
    
    if (_selectSeugment != segument) {
        
        [self.btnTitleSource[_selectSeugment] setSelected:NO];
        [self.btnTitleSource[segument] setSelected:YES];
        
        if (self.isAnimated) {
            //CALaye隐式动画：bounds、backgroundColor、position
            [bottomLayer setFrame:CGRectMake(segument * witdthFloat+witdthFloat/8*3,self.bounds.size.height - 8, witdthFloat/4, 4)];
        } else {
            //通过动画事务(CATransaction)关闭默认的隐式动画效果
            [CATransaction begin];
            [CATransaction setDisableActions:YES];
            [bottomLayer setFrame:CGRectMake(segument * witdthFloat+witdthFloat/8*3,self.bounds.size.height - 8, witdthFloat/4, 4)];
            [CATransaction commit];
        }
        _selectSeugment = segument;
        [self.delegate segumentSelectionChange:_selectSeugment];
    }
}


#pragma mark - setters
- (void)setSelectSeugment:(NSInteger)selectSeugment {
    
    [self.btnTitleSource[_selectSeugment] setSelected:NO];
    [self.btnTitleSource[selectSeugment] setSelected:YES];
    
    _selectSeugment = selectSeugment;
    [self setNeedsLayout];
}

- (void)setBottomColor:(UIColor *)bottomColor {
    
    _bottomColor = bottomColor;
    [self setNeedsLayout];
}

- (void)setTitleColor:(UIColor *)titleColor {
    
    _titleColor = titleColor;
    [self setNeedsLayout];
}

- (void)setTitleFont:(UIFont *)titleFont {
    
    _titleFont = titleFont;
    [self setNeedsLayout];
}

- (void)setSelectColor:(UIColor *)selectColor {
    
    _selectColor = selectColor;
    [self setNeedsLayout];
}

@end
