//
//  JJSDragView.m
//  JJSDragView
//
//  Created by 贾菊盛 on 16/4/27.
//  Copyright © 2016年 贾菊盛. All rights reserved.
//

#import "JJSDragView.h"
@interface JJSDragView()
@property(nonatomic,assign)CGFloat transFloatX;
@property(nonatomic,assign)CGFloat transFloatY;
@property(nonatomic)CGPoint transFormBeforePoint;
@end
@implementation JJSDragView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [self creatColor];
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
        [self addGestureRecognizer:panGesture];
    }
    return self;
}
- (void)panGesture:(UIPanGestureRecognizer *)panGesture{
    
    self.transFloatX = [panGesture translationInView:self].x;
    self.transFloatY = [panGesture translationInView:self].y;
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            self.transFormBeforePoint = self.center;
            break;
        case UIGestureRecognizerStateChanged:
            self.center = CGPointMake(self.transFormBeforePoint.x + self.transFloatX, self.transFormBeforePoint.y + self.transFloatY);
            
            CGFloat rotationStrength = MIN(self.transFloatX / 320, 1);
            
            CGFloat rotationAngel = (CGFloat)(M_PI/8 * rotationStrength);

            CGAffineTransform transForm = CGAffineTransformMakeRotation(rotationAngel);
            CGFloat scale = MAX(1 - fabs(rotationStrength) / 4, .93);
            CGAffineTransform scaleTransform = CGAffineTransformScale(transForm, scale, scale);
            
            self.transform = scaleTransform;
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(draging)]) {
                [self.delegate draging];
            }
            break;
        case UIGestureRecognizerStateEnded:
            [self panned];
            break;
        case UIGestureRecognizerStateCancelled:
            self.center = self.transFormBeforePoint;
            break;
        case UIGestureRecognizerStateFailed:
            self.center = self.transFormBeforePoint;
            break;
        default:
            break;
    }
}
- (void)panned{
    __weak typeof(self) weakSelf = self;
    if(self.transFloatX > 100){
        [UIView animateWithDuration:0.25 animations:^{
            weakSelf.center = CGPointMake(475, self.transFormBeforePoint.y + self.transFloatY*(475- self.transFormBeforePoint.x)/self.transFloatX);
        } completion:^(BOOL finished) {
            [weakSelf removeFromSuperview];
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(dragendToRight)]) {
                [weakSelf.delegate dragendToRight];
            }
        }];
        
        
    }else if(self.transFloatX < -100){
        [UIView animateWithDuration:0.25 animations:^{
            weakSelf.center = CGPointMake(-100, self.transFormBeforePoint.y + self.transFloatY*(-100 - self.transFormBeforePoint.x)/self.transFloatX);
        } completion:^(BOOL finished) {
            [weakSelf removeFromSuperview];
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(dragendToLeft)]) {
                [weakSelf.delegate dragendToLeft];
            }
        }];
    }else if (self.transFloatY >100){
        [UIView animateWithDuration:0.25 animations:^{
            weakSelf.center = CGPointMake(self.transFormBeforePoint.x + self.transFloatX*(767- self.transFormBeforePoint.y)/self.transFloatY, 767);
        } completion:^(BOOL finished) {
            [weakSelf removeFromSuperview];
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(dragendToTop)]) {
                [weakSelf.delegate dragendToTop];
            }
        }];
    }else if (self.transFloatY < -100){
        [UIView animateWithDuration:0.25 animations:^{
            weakSelf.center = CGPointMake(self.transFormBeforePoint.x + self.transFloatX*(-100 - self.transFormBeforePoint.y)/self.transFloatY, -100);
        } completion:^(BOOL finished) {
            [weakSelf removeFromSuperview];
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(dragendToBottom)]) {
                [weakSelf.delegate dragendToBottom];
            }
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            weakSelf.center = self.transFormBeforePoint;
            self.transform = CGAffineTransformMakeRotation(0);

        } completion:^(BOOL finished) {
            if(weakSelf.delegate&&[weakSelf.delegate respondsToSelector:@selector(backToCenter)]){
                [weakSelf.delegate backToCenter];
            }
        }];
    }
}
- (UIColor *)creatColor{
    CGFloat hue = arc4random()%256/255.f;
    CGFloat saturation = arc4random()%256/255.f;
    CGFloat brightness = arc4random()%256/255.f;;
    CGFloat alpha = arc4random()%256/255.f;
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}
@end
