//
//  WXMagicMovePushController.m
//  WXTransitionDemo
//
//  Created by BlackEr Gray on 17/7/14.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

#import "WXMagicMovePushController.h"
#import "WXMagicTransiton.h"
#import "WXPercentInteractiveTransition.h"

@interface WXMagicMovePushController ()
@property(nonatomic, strong)WXPercentInteractiveTransition *interactiveTransition;
@end

@implementation WXMagicMovePushController

- (WXPercentInteractiveTransition *)interactiveTransition{
    if (!_interactiveTransition) {
        _interactiveTransition = [[WXPercentInteractiveTransition alloc]initForViewController:self withGestureDirection:WXPercentInteractiveTransitionGestureDirectionRight withTransitionType:WXPercentInteractiveTransitionTypePop];
    }
    return _interactiveTransition;
}

- (void)dealloc {
    NSLog(@"释放了");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"5355d3ccc22dd.jpg"]];
    self.imageView = imageView;
    [self.view addSubview:imageView];
    imageView.center = CGPointMake(self.view.center.x, self.view.center.y - self.view.bounds.size.height / 2 + 210);
    imageView.bounds = CGRectMake(0, 0, 280, 280);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//动画效果
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    
        return [WXMagicTransiton magicTransitionWithType:operation == UINavigationControllerOperationPush?WXNaviOneTransitionTypePush:WXNaviOneTransitionTypePop];
    
    
}

//手势动画效果
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    return self.interactiveTransition.transitioning ? self.interactiveTransition:nil;
}




@end
