//
//  ModalViewController.m
//  WXTransitionDemo
//
//  Created by BlackEr Gray on 17/7/13.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

#import "ModalViewController.h"
#import "BouncePresentAnimation.h"
#import "SwipeUpInteractiveTransition.h"
#import "NormalDismissAnimation.h"
#import "WXPercentInteractiveTransition.h"

@interface ModalViewController ()
@property(nonatomic,strong) BouncePresentAnimation *presentAnimation;
@property(nonatomic, strong) SwipeUpInteractiveTransition *transitionController;
@property (nonatomic, strong) NormalDismissAnimation *dismissAnimation;
@property(nonatomic, strong)WXPercentInteractiveTransition *interactiveTransition;

@end


@implementation ModalViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _presentAnimation = [BouncePresentAnimation new];
        _dismissAnimation = [NormalDismissAnimation new];
        _transitionController = [SwipeUpInteractiveTransition new];
        _interactiveTransition = [WXPercentInteractiveTransition percentInteractiveTransitionForViewController:self withGestureDirection:WXPercentInteractiveTransitionGestureDirectionDown withTransitionType:WXPercentInteractiveTransitionTypeDismiss];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(80.0, 210.0, 250.0, 40.0);
    button.center = self.view.center;
//    [button.titleLabel sizeToFit];
    [button setTitle:@"点我或向下滑动 dismiss ME" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    

     

}

- (void)dealloc{
    NSLog(@"释放了");
}


- (void)buttonClicked:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(modalViewControllerDidClickDismissButton:)]) {
        [self.delegate modalViewControllerDidClickDismissButton:self];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK:--UIViewControllerTransitioningDelegate协议

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    //presented:将要被modal出的控制器
    //presenting:正在modal的控制器
    //source:来源控制器
    return self.presentAnimation;//返回的是遵守了UIViewControllerAnimatedTransitioning的对象，在这个对象中设置需要的动画效果
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    //dismissed:将要被dismiss的控制器
    return self.dismissAnimation;
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.interactiveTransition.transitioning ? self.interactiveTransition : nil;
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
