//
//  ZGZanButton.h
//  ZGZanAnimation
//
//  Created by Zong on 16/3/9.
//  Copyright © 2016年 XuZonggen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZGZanButton;

@protocol ZGZanButtonDelegate <NSObject>

@optional
- (void)zanButton:(ZGZanButton *)zanButton overtimeWithSummaryCount:(NSInteger)summaryCount;

@end

@interface ZGZanButton : UIButton

@property (weak, nonatomic) id <ZGZanButtonDelegate> delegate;

@end
