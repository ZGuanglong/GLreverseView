//
//  ReverseView.m
//  reverseView
//
//  Created by Mike on 15-7-28.
//  Copyright (c) 2015年 galaxy. All rights reserved.
//

#import "ReverseView.h"
#define TITLEFONDSIZE 22
@interface ReverseView()
@property(nonatomic,weak)UILabel *reverseLable;
@property(nonatomic,strong)NSMutableArray*titleArray;
@property(nonatomic,strong)NSTimer *Timer;
@property(nonatomic,assign)NSInteger count;//计数器
@end
@implementation ReverseView
-(NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray=[NSMutableArray array];
    }
    return _titleArray;
}

-(instancetype)initWithFrame:(CGRect)frame andTitleArray:(NSArray *)titleArray andrecerseTime:(CGFloat)time
{
    if (self=[super initWithFrame:frame]) {
        self.titleArray=[NSMutableArray arrayWithArray:titleArray];
        UILabel *lable=[[UILabel alloc]initWithFrame:self.bounds];
        lable.textColor=[UIColor blackColor];
        lable.font=[UIFont systemFontOfSize:TITLEFONDSIZE];
        lable.userInteractionEnabled=YES;
        lable.text=self.titleArray.firstObject;
        [self addSubview:lable];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [lable addGestureRecognizer:tap];

        self.reverseLable=lable;
        self.Timer=[NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(reverseClick) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:self.Timer forMode:NSRunLoopCommonModes];

    }
    return self;
}
- (void)reverseClick
{
    id content=self.titleArray.firstObject;
    if ([content isKindOfClass:[ReverseInfo class]]) {
        self.reverseLable.text=((ReverseInfo *)content).title;
    }
    else
        self.reverseLable.text=content;
    UILabel *bottomLable=[[UILabel alloc]initWithFrame:self.reverseLable.frame];
    bottomLable.textColor=[UIColor blackColor];
    bottomLable.font=[UIFont systemFontOfSize:TITLEFONDSIZE];
    bottomLable.alpha=0;
    id nextcontent=self.titleArray.count>1?self.titleArray[1]:self.titleArray.firstObject;
    if ([nextcontent isKindOfClass:[ReverseInfo class]]) {
        bottomLable.text=((ReverseInfo *)nextcontent).title;
    }
    else
        bottomLable.text=nextcontent;
    bottomLable.tag=1001;
    bottomLable.transform=CGAffineTransformConcat(CGAffineTransformMakeScale(1.0, 0.1), CGAffineTransformMakeTranslation(1.0, bottomLable.bounds.size.height/2));
    [self addSubview:bottomLable];

    [UIView animateWithDuration:0.5 animations:^{
        self.reverseLable.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.0, 0.1), CGAffineTransformMakeTranslation(1.0, -self.reverseLable.frame.size.height / 2));
        self.reverseLable.alpha=0;
        bottomLable.alpha=1.0;
        bottomLable.transform=CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        self.reverseLable.alpha=1;
        self.reverseLable.text=bottomLable.text;
        self.reverseLable.transform=CGAffineTransformIdentity;
        [bottomLable removeFromSuperview];
        NSString *title=self.titleArray.firstObject;
        [self.titleArray removeObjectAtIndex:0];
        [self.titleArray addObject:title];
    }];
    self.count++;
}

- (void)tapClick:(UITapGestureRecognizer *)sender{
    if (self.titleClickBlock) {

        self.titleClickBlock(self.count%self.titleArray.count);

    }
}

-(void)stareTimer
{
    [self.Timer setFireDate:[NSDate distantPast]];
}

- (void)stopTimer
{
    [self.Timer setFireDate:[NSDate distantFuture]];
}
- (void)delectTimer
{
    [self.Timer invalidate];
    self.Timer=nil;
}
@end
