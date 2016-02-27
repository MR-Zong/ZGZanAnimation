//
//  ZGImageView.m
//  ZGZanAnimation
//
//  Created by 徐宗根 on 16/2/27.
//  Copyright © 2016年 XuZonggen. All rights reserved.
//

#import "ZGImageView.h"
NSString *const kKeyAnimationOverNotification = @"KkeyAnimationOverNotification";
NSString *const kKeyAnimation = @"kKeyAnimation";

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didAnimationOver:) name:kKeyAnimationOverNotification object:nil];
}

- (void)didAnimationOver:(NSNotification *)note
{
    if (note.object == self.keyAnimation) {
        [self removeFromSuperview];
    }
}

@end
