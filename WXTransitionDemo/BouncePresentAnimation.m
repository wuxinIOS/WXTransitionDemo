//
//  BouncePresentAnimation.m
//  VCTransitionDemo
//
//  Created by 王 巍 on 13-10-13.
//  Copyright (c) 2013年 王 巍. All rights reserved.
//

#import "BouncePresentAnimation.h"

@implementation BouncePresentAnimation
//必须实现的两个方法
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.8f;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    //根据上下文获取将要呈现出的视图控制器
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //从底部出现，故初始位置设置为底部
    CGRect scrrenBounds = [UIScreen mainScreen].bounds;
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalFrame, 0, scrrenBounds.size.height);
//    CGRect initialFrame = CGRectZero;
//    initialFrame.origin = CGPointMake(scrrenBounds.size.width * 0.5, scrrenBounds.size.height * 0.5);
//    toVC.view.frame = initialFrame;

    //把toVC的view加入到容器中
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    //设置动画
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration
                          delay:0.0
         usingSpringWithDamping:0.6//弹簧效果程度
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         toVC.view.frame = finalFrame;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                         
                     }];
    
}
@end
