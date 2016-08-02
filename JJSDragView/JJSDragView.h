//
//  JJSDragView.h
//  JJSDragView
//
//  Created by 贾菊盛 on 16/4/27.
//  Copyright © 2016年 贾菊盛. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JJSDragViewDelegate<NSObject>
@required
- (void)dragendToLeft;
- (void)dragendToRight;
- (void)dragendToTop;
- (void)dragendToBottom;
@optional
- (void)draging;
- (void)backToCenter;
@end

@interface JJSDragView : UIView
@property(nonatomic,weak)id<JJSDragViewDelegate> delegate;
@end
