//
//  ZGImageView.m
//  ZGZanAnimation
//
//  Created by 徐宗根 on 16/2/27.
//  Copyright © 2016年 XuZonggen. All rights reserved.
//

#import "ZGImageView.h"
NSString *const kAnimationGroupOverNotification = @"KAnimationGroupOverNotification";
NSString *const kAnimationGroup = @"kAnimationGroup";

@implementation ZGImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self registerNotify];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)registerNotify
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didAnimationOver:) name:kAnimationGroupOverNotification object:nil];
}

- (void)didAnimationOver:(NSNotification *)note
{
    if (note.object == self.animationGroup) {
        [self removeFromSuperview];
    }
}

@end
