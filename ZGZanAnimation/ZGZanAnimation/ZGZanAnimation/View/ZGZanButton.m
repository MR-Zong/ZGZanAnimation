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

@end

@implementation ZGZanButton


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       [self addTarget:self action:@selector(zanButtonClick:) forControlEvents:UIControlEventTouchUpInside];
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
    
    CGMutablePathRef path1=CGPathCreateMutable();
    //动画起始点
    CGPathMoveToPoint(path1, nil, startPointOfKeyAnimation.x, startPointOfKeyAnimation.y);
    
    //    CGPathAddLineToPoint(aPath, NULL, ZGSCREEN_WIDTH - 40 - 40, 0);
    
    CGPathAddQuadCurveToPoint(path1, NULL, self.startPointOfKeyAnimation.x - 35, self.startPointOfKeyAnimation.y - 50, self.startPointOfKeyAnimation.x , self.startPointOfKeyAnimation.y - 200);
    
    CGPathAddQuadCurveToPoint(path1, NULL, ZGSCREEN_WIDTH, self.startPointOfKeyAnimation.y - 200 - 80, self.startPointOfKeyAnimation.x, 0);
    
    CGMutablePathRef path2=CGPathCreateMutable();
    //动画起始点
    CGPathMoveToPoint(path2, nil, startPointOfKeyAnimation.x, startPointOfKeyAnimation.y);
    
    CGPathAddQuadCurveToPoint(path2, NULL, ZGSCREEN_WIDTH, self.startPointOfKeyAnimation.y - 50, self.startPointOfKeyAnimation.x , self.startPointOfKeyAnimation.y - 200);
    
    CGPathAddQuadCurveToPoint(path2, NULL, self.startPointOfKeyAnimation.x - 35, self.startPointOfKeyAnimation.y - 200 - 80, self.startPointOfKeyAnimation.x, 0);
    
    
    CGMutablePathRef path3=CGPathCreateMutable();
    //动画起始点
    CGPathMoveToPoint(path3, nil, startPointOfKeyAnimation.x, startPointOfKeyAnimation.y);
    
    CGPathAddLineToPoint(path3, NULL, self.startPointOfKeyAnimation.x, self.startPointOfKeyAnimation.y - 350);
    
    CGPathAddQuadCurveToPoint(path3, NULL, ZGSCREEN_WIDTH, self.startPointOfKeyAnimation.y - 350 - 80, self.startPointOfKeyAnimation.x, 0);
    
    
    CGMutablePathRef path4=CGPathCreateMutable();
    //动画起始点
    CGPathMoveToPoint(path4, nil, startPointOfKeyAnimation.x, startPointOfKeyAnimation.y);
    
    CGPathAddLineToPoint(path4, NULL, self.startPointOfKeyAnimation.x, self.startPointOfKeyAnimation.y - 350);
    
    CGPathAddQuadCurveToPoint(path4, NULL, self.startPointOfKeyAnimation.x - 35, self.startPointOfKeyAnimation.y - 250 - 80, self.startPointOfKeyAnimation.x, 0);
    
    
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

@end
