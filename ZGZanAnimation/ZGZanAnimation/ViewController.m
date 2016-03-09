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
    
    UIButton *zanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    zanButton.frame = CGRectMake(ZGSCREEN_WIDTH - 40 - 40, ZGSCREEN_HEIGHT - 40 - 40, 40, 33);
//    zanButton.backgroundColor = [UIColor redColor];
    [zanButton setImage:[UIImage imageNamed:@"redHeart"] forState:UIControlStateNormal];
    [zanButton addTarget:self action:@selector(zanButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zanButton];
    
    // 设置帧动画起始点
    self.startPoint = zanButton.center;
}

#pragma mark - zanButtonClick
- (void)zanButtonClick:(UIButton *)btn
{
    ZGImageView *imgView = [[ZGImageView alloc] init];
    imgView.frame = CGRectMake(-10, -64, 40, 40);
    imgView.image = [UIImage imageNamed:@"redHeart_rotation"];
    [self.view addSubview:imgView];
    [self setupAnimationWithImageView:imgView];
}

- (void)setupAnimationWithImageView:(ZGImageView *)imgView
{
    //缩放动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.duration = 0.25f;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    //透明度变化
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.2];
    
    // 动画组
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 5.0f;
    [animationGroup setAnimations:[NSArray arrayWithObjects:opacityAnimation, scaleAnimation, [self keyAnimation],nil]];
    
    // imgView添加动画组
    [imgView.layer addAnimation:animationGroup forKey:kAnimationGroup];
    imgView.animationGroup = (CAKeyframeAnimation *)[imgView.layer animationForKey:kAnimationGroup];
}

- (CAAnimation *)keyAnimation
{
    // core animation
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    keyAnimation.path=[self pathWithStartPoint:self.startPoint];
    keyAnimation.duration=5;
    //设置为渐出
    //    keyAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    //自动旋转方向
    keyAnimation.rotationMode=@"auto";
    keyAnimation.autoreverses = NO;
    keyAnimation.delegate = self;
    
    return keyAnimation;
}

- (CGMutablePathRef)pathWithStartPoint:(CGPoint)startPoint
{
    NSMutableArray *paths = [NSMutableArray array];
    
    CGMutablePathRef path1=CGPathCreateMutable();
    //动画起始点
    CGPathMoveToPoint(path1, nil, startPoint.x, startPoint.y);

    //    CGPathAddLineToPoint(aPath, NULL, ZGSCREEN_WIDTH - 40 - 40, 0);
    
    CGPathAddQuadCurveToPoint(path1, NULL, self.startPoint.x - 35, self.startPoint.y - 50, self.startPoint.x , self.startPoint.y - 200);
    
    CGPathAddQuadCurveToPoint(path1, NULL, ZGSCREEN_WIDTH, self.startPoint.y - 200 - 80, self.startPoint.x, 0);
    
    CGMutablePathRef path2=CGPathCreateMutable();
    //动画起始点
    CGPathMoveToPoint(path2, nil, startPoint.x, startPoint.y);
    
    CGPathAddQuadCurveToPoint(path2, NULL, ZGSCREEN_WIDTH, self.startPoint.y - 50, self.startPoint.x , self.startPoint.y - 200);
    
    CGPathAddQuadCurveToPoint(path2, NULL, self.startPoint.x - 35, self.startPoint.y - 200 - 80, self.startPoint.x, 0);
    
    
    CGMutablePathRef path3=CGPathCreateMutable();
    //动画起始点
    CGPathMoveToPoint(path3, nil, startPoint.x, startPoint.y);
    
    CGPathAddLineToPoint(path3, NULL, self.startPoint.x, self.startPoint.y - 350);
    
    CGPathAddQuadCurveToPoint(path3, NULL, ZGSCREEN_WIDTH, self.startPoint.y - 350 - 80, self.startPoint.x, 0);
    
    
    CGMutablePathRef path4=CGPathCreateMutable();
    //动画起始点
    CGPathMoveToPoint(path4, nil, startPoint.x, startPoint.y);
    
    CGPathAddLineToPoint(path4, NULL, self.startPoint.x, self.startPoint.y - 350);
    
    CGPathAddQuadCurveToPoint(path4, NULL, self.startPoint.x - 35, self.startPoint.y - 250 - 80, self.startPoint.x, 0);
    
    
    [paths addObject:(__bridge id _Nonnull)(path1)];
    [paths addObject:(__bridge id _Nonnull)(path2)];
    [paths addObject:(__bridge id _Nonnull)(path3)];
    [paths addObject:(__bridge id _Nonnull)(path4)];
    
    return (__bridge CGMutablePathRef)paths[arc4random_uniform(4)];
}


#pragma mark AnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kAnimationGroupOverNotification object:anim];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
