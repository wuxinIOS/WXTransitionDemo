//
//  WXPercentInteractiveTransition.m
//  WXTransitionDemo
//
//  Created by BlackEr Gray on 17/7/14.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

#import "WXPercentInteractiveTransition.h"

@interface WXPercentInteractiveTransition ()
@property(nonatomic, weak)UIViewController *viewController;
@property(nonatomic,assign)WXPercentInteractiveTransitionGestureDirection direction;
@property(nonatomic,assign)WXPercentInteractiveTransitionType type;
@end


@implementation WXPercentInteractiveTransition



#pragma mark --初始化
-(instancetype)initForViewController:(UIViewController *)viewController withGestureDirection:(WXPercentInteractiveTransitionGestureDirection)direction withTransitionType:(WXPercentInteractiveTransitionType)type{
    if (self = [super init]) {
        self.viewController = viewController;
        self.direction = direction;
        self.type = type;
        [self addPanGestureForViewControllerForController:viewController];
    }
    return self;
}


+ (instancetype)percentInteractiveTransitionForViewController:(UIViewController *)viewController withGestureDirection:(WXPercentInteractiveTransitionGestureDirection)direction withTransitionType:(WXPercentInteractiveTransitionType)type {
    return [[self alloc]initForViewController:viewController withGestureDirection:direction withTransitionType:type];
}

#pragma mark --手势
- (void)addPanGestureForViewControllerForController:(UIViewController *)viewController{
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
    [self.viewController.view addGestureRecognizer:panGesture];
    
}




- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture {
    
    //手势百分比
    CGFloat percent = 0;
    
    CGPoint point = [panGesture translationInView:panGesture.view];
    
    switch (self.direction) {
        case WXPercentInteractiveTransitionGestureDirectionLeft:
            percent = - point.x / panGesture.view.bounds.size.width;

            break;
        case WXPercentInteractiveTransitionGestureDirectionRight:
            percent =  point.x / panGesture.view.bounds.size.width;
            break;
        case WXPercentInteractiveTransitionGestureDirectionUp:
            percent = - point.y / panGesture.view.superview.bounds.size.height;

            break;
        case WXPercentInteractiveTransitionGestureDirectionDown:
            percent =  point.y / panGesture.view.superview.bounds.size.height;
            break;
        default:
            break;
    }
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            self.transitioning = YES;
            [self startTransition];
            break;
        case UIGestureRecognizerStateChanged:
            [self updateInteractiveTransition:percent];
            break;
        case UIGestureRecognizerStateEnded:
            self.transitioning = NO;
            
            switch (self.direction) {
                case WXPercentInteractiveTransitionGestureDirectionRight:
                case WXPercentInteractiveTransitionGestureDirectionLeft:
                    if (percent > 0.3) {
                        [self finishInteractiveTransition];
                    } else {
                        [self cancelInteractiveTransition];
                        
                    }

                    break;
                    
                default:
                    if (percent > 0.45) {
                        [self finishInteractiveTransition];
                    } else {
                        [self cancelInteractiveTransition];

                    }
                    break;
            }
            
            break;
        default:
            break;
    }
}

- (void)startTransition{
    
    switch (self.type) {
        case WXPercentInteractiveTransitionTypePop:
            [self.viewController.navigationController popViewControllerAnimated:YES];
            break;
        case WXPercentInteractiveTransitionTypeDismiss:
            [self.viewController dismissViewControllerAnimated:YES completion:nil];
        default:
            break;
    }
    
}




@end
