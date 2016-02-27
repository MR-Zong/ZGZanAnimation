//
//  ViewController.m
//  ZGZanAnimation
//
//  Created by 徐宗根 on 16/2/27.
//  Copyright © 2016年 XuZonggen. All rights reserved.
//

#import "ViewController.h"
#import "ZGImageView.h"

#define ZGSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define ZGSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface ViewController ()

@property (assign, nonatomic) CGPoint startPoint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.startPoint = CGPointMake(ZGSCREEN_WIDTH - 40 - 40,  ZGSCREEN_HEIGHT - 40 - 40);
    
    UIButton *zanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    zanButton.frame = CGRectMake(self.startPoint.x, self.startPoint.y, 40, 40);
    zanButton.backgroundColor = [UIColor redColor];
    [zanButton addTarget:self action:@selector(zanButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zanButton];
}

#pragma mark - zanButtonClick
- (void)zanButtonClick:(UIButton *)btn
{
    ZGImageView *img = [[ZGImageView alloc] init];
    img.frame = CGRectMake(-10, -64, 40, 40);
    img.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:img];
    
    // core animation
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGMutablePathRef aPath=CGPathCreateMutable();
    //动画起始点
    CGPathMoveToPoint(aPath, nil, self.startPoint.x, self.startPoint.y);

//    CGPathAddLineToPoint(aPath, NULL, ZGSCREEN_WIDTH - 40 - 40, 0);
    
    CGPathAddQuadCurveToPoint(aPath, NULL, self.startPoint.x - 35, self.startPoint.y - 50, self.startPoint.x , self.startPoint.y - 200);
    
    CGPathAddQuadCurveToPoint(aPath, NULL, ZGSCREEN_WIDTH, self.startPoint.y - 200 - 80, self.startPoint.x, 0);
    
    keyAnimation.path=aPath;
    keyAnimation.duration=5;
    //设置为渐出
//    keyAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    //自动旋转方向
    keyAnimation.rotationMode=@"auto";
    keyAnimation.autoreverses = NO;
    keyAnimation.delegate = self;
    [img.layer addAnimation:keyAnimation forKey:kKeyAnimation];
    img.keyAnimation = (CAKeyframeAnimation *)[img.layer animationForKey:kKeyAnimation];
}


#pragma mark AnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kKeyAnimationOverNotification object:anim];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
