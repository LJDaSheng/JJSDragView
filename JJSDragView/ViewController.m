//
//  ViewController.m
//  JJSDragView
//
//  Created by 贾菊盛 on 16/4/27.
//  Copyright © 2016年 贾菊盛. All rights reserved.
//

#import "ViewController.h"
#import "JJSDragView.h"
@interface ViewController ()<JJSDragViewDelegate>
@property(nonatomic,strong)JJSDragView *firstView;
@property(nonatomic,strong)JJSDragView *secondView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self creatDragView];
    [self creatDragView];
}
- (void)creatDragView{
    JJSDragView *dragView = [[JJSDragView alloc]initWithFrame:CGRectMake(50, 100, 275, 275)];
    dragView.delegate = self;
    if (!self.firstView) {
        self.firstView = dragView;
        [self.view addSubview:self.firstView];
    }else{
        if (self.secondView){
            self.firstView = self.secondView;
        }
        self.secondView = dragView;
        self.secondView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.97, 0.97);
        [self.view insertSubview:self.secondView belowSubview:self.firstView];
    }
}
- (void)dragendToLeft{
    [self creatDragView];
}
- (void)dragendToRight{
    [self creatDragView];
}
- (void)dragendToTop{
    [self creatDragView];
}
- (void)dragendToBottom{
    [self creatDragView];
}
- (void)dragging:(CGFloat)factor{
    CGFloat scale = 0.95 + (1 - 0.95) *factor;
    self.secondView.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
