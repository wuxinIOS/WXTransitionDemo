//
//  WXPercentInteractiveTransition.h
//  WXTransitionDemo
//
//  Created by BlackEr Gray on 17/7/14.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 手势方向*/
typedef NS_ENUM(NSUInteger,WXPercentInteractiveTransitionGestureDirection){
    WXPercentInteractiveTransitionGestureDirectionLeft = 0,
    WXPercentInteractiveTransitionGestureDirectionRight,
    WXPercentInteractiveTransitionGestureDirectionUp,
    WXPercentInteractiveTransitionGestureDirectionDown
};

/** 推出类型 */
typedef NS_ENUM(NSUInteger,WXPercentInteractiveTransitionType){
    WXPercentInteractiveTransitionTypePush = 0,
    WXPercentInteractiveTransitionTypePop,
    WXPercentInteractiveTransitionTypePresent,
    WXPercentInteractiveTransitionTypeDismiss
};



@interface WXPercentInteractiveTransition : UIPercentDrivenInteractiveTransition

@property(nonatomic, assign) BOOL transitioning;


/** 初始化方法 */
+(instancetype)percentInteractiveTransitionForViewController:(UIViewController *)viewController withGestureDirection:(WXPercentInteractiveTransitionGestureDirection)direction withTransitionType:(WXPercentInteractiveTransitionType)type;
-(instancetype)initForViewController:(UIViewController *)viewController withGestureDirection:(WXPercentInteractiveTransitionGestureDirection)direction withTransitionType:(WXPercentInteractiveTransitionType)type;
@end
