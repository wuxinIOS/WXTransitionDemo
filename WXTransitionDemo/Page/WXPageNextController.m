//
//  WXPageNextController.m
//  WXTransitionDemo
//
//  Created by BlackEr Gray on 17/7/18.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

#import "WXPageNextController.h"
#import "WXPageAnimation.h"
#import "WXPercentInteractiveTransition.h"

@interface WXPageNextController ()
@property(nonatomic, strong)WXPercentInteractiveTransition *interactiveTransitionPop;
@property(nonatomic, assign)UINavigationControllerOperation type;

@end

@implementation WXPageNextController







- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
   _interactiveTransitionPop = [[WXPercentInteractiveTransition alloc]initForViewController:self withGestureDirection:WXPercentInteractiveTransitionGestureDirectionRight withTransitionType:WXPercentInteractiveTransitionTypePop];

}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    _type = operation;
    return [[WXPageAnimation alloc]initWithOperationType:operation];
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    
    if (_type == UINavigationControllerOperationPush) {
        
        WXPercentInteractiveTransition *transition = [self.nextDelegate interactiveTransitionForPush];
        
        return transition.transitioning?transition:nil;
        
    } else  {
        
        return self.interactiveTransitionPop.transitioning ? self.interactiveTransitionPop:nil;

    }
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
