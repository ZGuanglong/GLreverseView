//
//  ReverseView.h
//  reverseView
//
//  Created by Mike on 15-7-28.
//  Copyright (c) 2015年 galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReverseInfo.h"
@interface ReverseView : UIView

@property(nonatomic,copy)void (^titleClickBlock)(NSInteger index);

/**
 创建翻转视图

 @param frame 位置
 @param titleArray 内容可接受文字数组和模型数组
 @param time 翻转时间>=1
 */
- (instancetype)initWithFrame:(CGRect)frame andTitleArray:(NSArray*)titleArray andrecerseTime:(CGFloat)time;
/**
 返回视图重启定时器
 */
- (void)stareTimer;
/**
 离开视图暂停
 */
- (void)stopTimer;
/**
 销毁视图同时销毁定时器
 */
- (void)delectTimer;
@end
