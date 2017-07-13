//
//  ViewController.m
//  WXTransitionDemo
//
//  Created by BlackEr Gray on 17/7/13.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

#import "ViewController.h"
#import "ModalViewController.h"
#import "BouncePresentAnimation.h"
#import "SwipeUpInteractiveTransition.h"
#import "NormalDismissAnimation.h"


@interface ViewController ()<ModalViewControllerDelegate,UIViewControllerTransitioningDelegate>
@property(nonatomic,strong) BouncePresentAnimation *presentAnimation;
@property(nonatomic, strong) SwipeUpInteractiveTransition *transitionController;
@property (nonatomic, strong) NormalDismissAnimation *dismissAnimation;

@property(nonatomic, strong) UIButton *followMeBtn;


@property(nonatomic, assign) CGPoint lastPoint;

@end

@implementation ViewController

- (UIButton *)followMeBtn {
    if (!_followMeBtn) {
        _followMeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _followMeBtn.backgroundColor = [UIColor redColor];
        _followMeBtn.frame = CGRectMake(0, 0, 200, 200);
        _followMeBtn.center = self.view.center;
        _followMeBtn.layer.cornerRadius = _followMeBtn.frame.size.width * 0.5;
        _lastPoint = _followMeBtn.center;
        _followMeBtn.layer.masksToBounds = YES;
        [_followMeBtn setTitle:@"移动" forState:UIControlStateNormal];
        
    }
    return _followMeBtn;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _presentAnimation = [BouncePresentAnimation new];
        _dismissAnimation = [NormalDismissAnimation new];
        _transitionController = [SwipeUpInteractiveTransition new];

    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    //UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
    //[self.view addSubview:self.followMeBtn];
    //[self.view bringSubviewToFront:self.followMeBtn];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [self.followMeBtn addGestureRecognizer:pan];
    

    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [button setTitle:@"Click me" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    [self.view insertSubview:self.followMeBtn atIndex:[self.view subviews].count];

}

- (void)handlePan:(UIPanGestureRecognizer *)pan {
    
    CGFloat startX;
    CGFloat startY;
    CGPoint point = [pan locationInView:self.view];
    startX = point.x;
    startY = point.y;
    CGFloat changedX;
    CGFloat changedY;
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            //CGPoint point = [pan locationInView:self.view];
            //startX = point.x;
            //startY = point.y;
            break;
        }
            
        case UIGestureRecognizerStateChanged:
        {
            CGPoint point = [pan translationInView:self.view];
            self.lastPoint = point;
            changedX = point.x - self.lastPoint.x;
            changedY = point.y - self.lastPoint.y;
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            CGPoint point = [pan translationInView:self.view];
            self.lastPoint = point;
            changedX = point.x - self.lastPoint.x;
            changedY = point.y - self.lastPoint.y;
            break;
        }
        default:
            break;
    }
    
    CGFloat x = startX + changedX;
    CGFloat y = startY + changedY;
    
   
    
    

    if (x + self.followMeBtn.bounds.size.width * 0.5  >= self.view.bounds.size.width  ) {
        
        x = self.view.bounds.size.width - self.followMeBtn.bounds.size.width * 0.5;
        
    } else if (x + self.followMeBtn.bounds.size.width * 0.5 <= self.followMeBtn.bounds.size.width){
        
        x = self.followMeBtn.bounds.size.width * 0.5;
    }
    
    
    if (y + self.followMeBtn.bounds.size.height*0.5 >= self.view.bounds.size.height - 0) {
        
        y = self.view.bounds.size.height - self.followMeBtn.bounds.size.height * 0.5;

    } else if (y + self.followMeBtn.bounds.size.height*0.5 <= self.followMeBtn.bounds.size.height) {
        
        y = self.followMeBtn.bounds.size.height * 0.5;
    }
    
    self.followMeBtn.center = CGPointMake(x, y);
    //[self.view layoutIfNeeded];
    
}

-(void) buttonClicked:(id)sender
{
    ModalViewController *mvc =  [[ModalViewController alloc] init];
    mvc.transitioningDelegate = self;//设置将要呈现的控制器的动画的代理
    mvc.delegate = self;
    [self.transitionController wireToViewController:mvc];
    [self presentViewController:mvc animated:YES completion:nil];
}

//MARK:--ModalViewController协议
- (void)modalViewControllerDidClickDismissButton:(ModalViewController *)modalViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//MARK:--UIViewControllerTransitioningDelegate协议
/*作用
 */
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
    return self.transitionController.interacting ? self.transitionController : nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
