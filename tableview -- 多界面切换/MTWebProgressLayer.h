//
//  MTWebProgressLayer.h
//  MicroTown
//
//  Created by microtown on 16/8/10.
//  Copyright © 2016年 Microtown  微镇商票宝. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface MTWebProgressLayer : CAShapeLayer

/**
 *  开始加载
 */
- (void)startLoad;
/**
 *  结束加载
 */
- (void)finishedLoad;


/**
 *  关闭定时器
 */
- (void)closeTimer;

@end
