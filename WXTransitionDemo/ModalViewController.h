//
//  ModalViewController.h
//  WXTransitionDemo
//
//  Created by BlackEr Gray on 17/7/13.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

#import "ViewController.h"
@class ModalViewController;
@protocol ModalViewControllerDelegate <NSObject>

-(void)modalViewControllerDidClickDismissButton:(ModalViewController *)modalViewController;

@end


@interface ModalViewController : UIViewController

@property (weak,nonatomic) id<ModalViewControllerDelegate> delegate;

@end
