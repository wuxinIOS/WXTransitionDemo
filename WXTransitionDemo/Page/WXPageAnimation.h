//
//  WXPageAnimation.h
//  WXTransitionDemo
//
//  Created by BlackEr Gray on 17/7/18.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WXPageAnimation : NSObject<UIViewControllerAnimatedTransitioning>
+(instancetype)pageAnimationWithType:(UINavigationControllerOperation)type;
-(instancetype)initWithOperationType:(UINavigationControllerOperation)type;
@end
