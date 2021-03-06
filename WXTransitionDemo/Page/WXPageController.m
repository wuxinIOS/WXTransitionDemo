//
//  WXPageController.m
//  WXTransitionDemo
//
//  Created by BlackEr Gray on 17/7/18.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

#import "WXPageController.h"
#import "WXPageNextController.h"
#import "WXPercentInteractiveTransition.h"


@interface WXPageController ()<WXPageNextControllerDelegate>
@property(nonatomic, strong)WXPercentInteractiveTransition *interactiveTransitionPush;

@end

@implementation WXPageController

- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPush{
    return self.interactiveTransitionPush;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    _interactiveTransitionPush = [[WXPercentInteractiveTransition alloc]initForViewController:self withGestureDirection:WXPercentInteractiveTransitionGestureDirectionLeft withTransitionType:WXPercentInteractiveTransitionTypePush];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    CGRect frame = CGRectMake( 50, 100, 100, 50);
    btn.frame = frame;
    [btn setTitle:@"点我push" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changedAnimation) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.numberOfLines = 0;
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:btn];
    typeof(self)weakSelf = self;

    self.interactiveTransitionPush.pushConifg = ^(){
        [weakSelf changedAnimation];
        
    };

}


- (void)changedAnimation {
    
    WXPageNextController *next = [[WXPageNextController alloc]init];
    self.navigationController.delegate = next;
    next.nextDelegate = self;
    [self.navigationController pushViewController:next animated:YES];
    
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
