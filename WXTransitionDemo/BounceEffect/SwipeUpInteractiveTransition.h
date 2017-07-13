//
//  SwipeUpInteractiveTransition.h
//  WXTransitionDemo
//
//  Created by BlackEr Gray on 17/7/13.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipeUpInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interacting;

- (void)wireToViewController:(UIViewController *)viewController;
@end
