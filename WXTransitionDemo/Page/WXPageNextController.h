//
//  WXPageNextController.h
//  WXTransitionDemo
//
//  Created by BlackEr Gray on 17/7/18.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WXPageNextControllerDelegate <NSObject>

- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPush;

@end

@interface WXPageNextController : UIViewController<UINavigationControllerDelegate>
@property (nonatomic, weak) id<WXPageNextControllerDelegate> nextDelegate;

@end
