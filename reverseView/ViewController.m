//
//  ViewController.m
//  reverseView
//
//  Created by Mike on 15-7-28.
//  Copyright (c) 2015年 galaxy. All rights reserved.
//

#import "ViewController.h"
#import "ReverseView.h"

@interface ViewController ()
@property(nonatomic,weak)ReverseView *myreverseView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array=@[@"11111111111111",@"2222222222222",@"3333333333333"];
    ReverseView *reverseview=[[ReverseView alloc]initWithFrame:CGRectMake(100, 100, 200, 44) andTitleArray:array andrecerseTime:1.5];
    reverseview.titleClickBlock = ^(NSInteger index) {
        NSLog(@"%lu",index);
    };
    [self.view addSubview:reverseview];
    // Do any additional setup after loading the view, typically from a nib.
}

@end
