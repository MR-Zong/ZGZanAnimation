//
//  ZGImageView.h
//  ZGZanAnimation
//
//  Created by 徐宗根 on 16/2/27.
//  Copyright © 2016年 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kKeyAnimationOverNotification;
extern NSString *const kKeyAnimation;

@interface ZGImageView : UIImageView

@property (strong, nonatomic) CAKeyframeAnimation *keyAnimation;

@end
