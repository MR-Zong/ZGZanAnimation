//
//  ViewController.m
//  ZGZanAnimation
//
//  Created by 徐宗根 on 16/2/27.
//  Copyright © 2016年 XuZonggen. All rights reserved.
//

#import "ViewController.h"
#import "ZGImageView.h"
#import "ZGZanButton.h"

#define ZGSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define ZGSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface ViewController () <ZGZanButtonDelegate>

@property (assign, nonatomic) CGPoint startPointOfKeyAnimation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.6];
    
    ZGZanButton *zanButton = [ZGZanButton buttonWithType:UIButtonTypeCustom];
    zanButton.frame = CGRectMake(ZGSCREEN_WIDTH - 53 - 40, ZGSCREEN_HEIGHT - 40 - 40, 53, 47);
    [zanButton setImage:[UIImage imageNamed:@"flower_icon"] forState:UIControlStateNormal];
    [zanButton setImage:[UIImage imageNamed:@"flower_icon"] forState:UIControlStateHighlighted];
    zanButton.delegate = self;
    [self.view addSubview:zanButton];
    
}


#pragma mark - <ZGZanButtonDelegate>
- (void)zanButton:(ZGZanButton *)zanButton overtimeWithSummaryCount:(NSInteger)summaryCount
{
    NSLog(@"summaryCount %zd",summaryCount);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
