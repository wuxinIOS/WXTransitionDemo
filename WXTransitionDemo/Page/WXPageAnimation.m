//
//  WXPageAnimation.m
//  WXTransitionDemo
//
//  Created by BlackEr Gray on 17/7/18.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

#import "WXPageAnimation.h"
#import "UIView+anchorPoint.h"

@interface WXPageAnimation ()
@property(nonatomic, assign)UINavigationControllerOperation type;

@end

@implementation WXPageAnimation
+ (instancetype)pageAnimationWithType:(UINavigationControllerOperation)type {
    
    return [[self alloc]initWithOperationType:type];
}



- (instancetype)initWithOperationType:(UINavigationControllerOperation)type {
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    if (_type == UINavigationControllerOperationPush) {
       
        
        
        
        
        
        UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        
        //对tempView做动画，避免bug;
        UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];//获取fromVC的截图,对这个截图进行动画
        tempView.frame = fromVC.view.frame;
        UIView *containerView = [transitionContext containerView];
        [containerView addSubview:toVC.view];
        [containerView addSubview:tempView];
        
        
        fromVC.view.hidden = YES;
        [containerView insertSubview:toVC.view atIndex:0];
        [tempView setAnchorPointTo:CGPointMake(0, 0.5)];
        CATransform3D transfrom3d = CATransform3DIdentity;
        transfrom3d.m34 = -0.002;
        containerView.layer.sublayerTransform = transfrom3d;
        
        //增加阴影
        CAGradientLayer *fromGradient = [CAGradientLayer layer];
        fromGradient.frame = fromVC.view.bounds;
        fromGradient.colors = @[(id)[UIColor blackColor].CGColor,
                                (id)[UIColor blackColor].CGColor];
        fromGradient.startPoint = CGPointMake(0.5, 0.5);
        fromGradient.endPoint = CGPointMake(0.8, 0.5);
        
        UIView *fromShadow = [[UIView alloc]initWithFrame:fromVC.view.bounds];
        fromShadow.backgroundColor = [UIColor clearColor];
        [fromShadow.layer insertSublayer:fromGradient atIndex:1];
        fromShadow.alpha = 0.0;
        [tempView addSubview:fromShadow];
        
        CAGradientLayer *toGradient = [CAGradientLayer layer];
        toGradient.frame = fromVC.view.bounds;
        toGradient.colors = @[(id)[UIColor yellowColor].CGColor,
                              (id)[UIColor yellowColor].CGColor];
        toGradient.startPoint = CGPointMake(0.0, 0.5);
        toGradient.endPoint = CGPointMake(0.8, 0.5);
        UIView *toShadow = [[UIView alloc]initWithFrame:fromVC.view.bounds];
        toShadow.backgroundColor = [UIColor clearColor];
        [toShadow.layer insertSublayer:toGradient atIndex:1];
        toShadow.alpha = 1.0;
        
        [toVC.view addSubview:toShadow];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            tempView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
            fromShadow.alpha = 1.0;
            toShadow.alpha = 0.0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                [tempView removeFromSuperview];
                fromVC.view.hidden = NO;
            }
        }];
        
        
        
    } else if (_type == UINavigationControllerOperationPop){
        
        UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIView *containerView = [transitionContext containerView];
        //拿到push时候的
        UIView *tempView = containerView.subviews.lastObject;
        [containerView addSubview:toVC.view];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            tempView.layer.transform = CATransform3DIdentity;
            fromVC.view.subviews.lastObject.alpha = 1.0;
            tempView.subviews.lastObject.alpha = 0.0;
        } completion:^(BOOL finished) {
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext completeTransition:NO];
            }else{
                [transitionContext completeTransition:YES];
                [tempView removeFromSuperview];
                toVC.view.hidden = NO;
            }
        }];

    }
    
    
}


@end
