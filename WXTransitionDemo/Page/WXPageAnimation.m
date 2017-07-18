//
//  WXPageAnimation.m
//  WXTransitionDemo
//
//  Created by BlackEr Gray on 17/7/18.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

#import "WXPageAnimation.h"

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
        //toVC
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        
        CATransition *transition = [[CATransition alloc]init];
        transition.duration = [self transitionDuration:transitionContext];
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        transition.repeatCount = 1;
        transition.type = @"pageCurl";
        transition.subtype = kCATransitionFromLeft;
        
        [toVC.view.layer addAnimation:transition forKey:@"transition"];
        
        UIView *cont = [transitionContext containerView];
        [cont addSubview:toVC.view];
        cont.backgroundColor = [UIColor blackColor];
        
    } else {
        
        //toVC
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        
        CATransition *transition = [[CATransition alloc]init];
        transition.duration = [self transitionDuration:transitionContext];
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        transition.repeatCount = 1;
        transition.type = @"pageCurl";
        transition.subtype = kCATransitionFromLeft;
        
        [toVC.view.layer addAnimation:transition forKey:@"transition"];
        
        UIView *cont = [transitionContext containerView];
        [cont addSubview:toVC.view];
    }
    
    
}


@end
