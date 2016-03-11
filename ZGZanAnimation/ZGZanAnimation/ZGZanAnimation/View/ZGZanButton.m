//
//  ZGZanButton.m
//  ZGZanAnimation
//
//  Created by Zong on 16/3/9.
//  Copyright © 2016年 XuZonggen. All rights reserved.
//

#import "ZGZanButton.h"
#import "ZGImageView.h"

#define ZGSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define ZGSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ZGZanButton ()

@property (assign, nonatomic) CGPoint startPointOfKeyAnimation;

@property (strong, nonatomic) NSTimer *timer;

@property (assign, nonatomic) NSInteger summaryCount;

@property (assign, nonatomic) BOOL isOverTime;

@end

@implementation ZGZanButton


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       [self addTarget:self action:@selector(zanButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.summaryCount = 0;
        self.isOverTime = NO;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置帧动画起始点
    self.startPointOfKeyAnimation = self.center;
}

#pragma mark - zanButtonClick
- (void)zanButtonClick:(UIButton *)btn
{
    // 判断是否超时（是否1秒内）
    if ( self.isOverTime == NO ) {
        self.summaryCount ++;
    }else {
        self.isOverTime = NO;
    }
    
    // 重置计时器(让计时器累积时间清零)
    [self resetTimer];
    
    // setup imgView
    [self setupImageViewWithButton:btn];
}


- (void)setupImageViewWithButton:(UIButton *)btn
{
    ZGImageView *imgView = [[ZGImageView alloc] init];
    imgView.frame = CGRectMake(-10, -64, 53, 33);
    imgView.image = [UIImage imageNamed:@"flower_icon_rotation"];
    [btn.superview addSubview:imgView];
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
    animationGroup.delegate = self;
    
    // imgView添加动画组
    [imgView.layer addAnimation:animationGroup forKey:kAnimationGroup];
    imgView.animationGroup = (CAKeyframeAnimation *)[imgView.layer animationForKey:kAnimationGroup];

}

- (CAAnimation *)keyAnimation
{
    // core animation
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    keyAnimation.path=[self pathWithstartPointOfKeyAnimation:self.startPointOfKeyAnimation];
    keyAnimation.duration=5;
    //设置为渐出
    //    keyAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    //自动旋转方向
    keyAnimation.rotationMode=@"auto";
    keyAnimation.autoreverses = NO;
//    keyAnimation.delegate = self;
    
    return keyAnimation;
}

- (CGMutablePathRef)pathWithstartPointOfKeyAnimation:(CGPoint)startPointOfKeyAnimation
{
    NSMutableArray *paths = [NSMutableArray array];
    
    CGPoint turnPoint12 = CGPointMake(self.startPointOfKeyAnimation.x, ZGSCREEN_HEIGHT * 0.4);
    CGPoint turnPoint34 = CGPointMake(self.startPointOfKeyAnimation.x, ZGSCREEN_HEIGHT * 0.3);
    
    // path1
    CGMutablePathRef path1=CGPathCreateMutable();
    CGPathMoveToPoint(path1, nil, startPointOfKeyAnimation.x, startPointOfKeyAnimation.y);
    //    CGPathAddLineToPoint(aPath, NULL, ZGSCREEN_WIDTH - 40 - 40, 0);
    CGPathAddQuadCurveToPoint(path1, NULL, turnPoint12.x - (arc4random_uniform(15) + 35), turnPoint12.y * 1.5, turnPoint12.x ,turnPoint12.y);
    CGPathAddQuadCurveToPoint(path1, NULL, turnPoint12.x + (arc4random_uniform(20) + 30), turnPoint12.y * 0.5, self.startPointOfKeyAnimation.x, 0);
    
    // path2
    CGMutablePathRef path2=CGPathCreateMutable();
    CGPathMoveToPoint(path2, nil, startPointOfKeyAnimation.x, startPointOfKeyAnimation.y);
    CGPathAddQuadCurveToPoint(path2, NULL, turnPoint12.x + (arc4random_uniform(15) + 35), turnPoint12.y * 1.5, turnPoint12.x , turnPoint12.y);
    CGPathAddQuadCurveToPoint(path2, NULL, turnPoint12.x - (arc4random_uniform(20) + 30), turnPoint12.y * 0.5, self.startPointOfKeyAnimation.x, 0);
    
    // path3
    CGMutablePathRef path3=CGPathCreateMutable();
    CGPathMoveToPoint(path3, nil, startPointOfKeyAnimation.x, startPointOfKeyAnimation.y);
    CGPathAddLineToPoint(path3, NULL, turnPoint34.x, turnPoint34.y);
    CGPathAddQuadCurveToPoint(path3, NULL, turnPoint34.x + arc4random_uniform(30), turnPoint34.y * 0.5, self.startPointOfKeyAnimation.x, 0);
    
    // path4
    CGMutablePathRef path4=CGPathCreateMutable();
    CGPathMoveToPoint(path4, nil, startPointOfKeyAnimation.x, startPointOfKeyAnimation.y);
    CGPathAddLineToPoint(path4, NULL, turnPoint34.x, turnPoint34.y);
    CGPathAddQuadCurveToPoint(path4, NULL, self.startPointOfKeyAnimation.x - arc4random_uniform(30), turnPoint34.y * 0.5, self.startPointOfKeyAnimation.x, 0);
    
    
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


#pragma mark - Tiemr
- (void)resetTimer
{
    [self stopTimer];
    [self startTimer];
}

- (void)startTimer
{
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(doTimer) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)doTimer
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(zanButton:overtimeWithSummaryCount:)]) {
        
        // 标志为超时
        self.isOverTime = YES;
        
        // 停止计时器
        [self stopTimer];
        
        [self.delegate zanButton:self overtimeWithSummaryCount:self.summaryCount];
    }
}

@end
