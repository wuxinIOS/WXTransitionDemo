//
//  WX_CATransiton.m
//  WXTransitionDemo
//
//  Created by BlackEr Gray on 17/7/17.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

#import "WX_CATransiton.h"

@interface WX_CATransiton ()
@property(nonatomic, strong) UILabel *transitionView;
@property(nonatomic, strong) CATransition *transition;
@property(nonatomic, strong) NSArray *animationTypeArray;
@property(nonatomic, assign) int index;
@end

@implementation WX_CATransiton

- (NSArray *)animationTypeArray {
    if (!_animationTypeArray) {
        _animationTypeArray = @[@"cube", @"suckEffect", @"rippleEffect", @"pageCurl", @"pageUnCurl", @"oglFlip", @"cameraIrisHollowOpen", @"cameraIrisHollowClose", @"spewEffect",@"genieEffect",@"unGenieEffect",@"twist",@"tubey",@"swirl",@"charminUltra", @"zoomyIn", @"zoomyOut", @"oglApplicationSuspend"];
    }
    return _animationTypeArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.index = 0;

    UILabel *transitionView = [[UILabel alloc]initWithFrame:CGRectMake(60, 70, 150, 200)];
    transitionView.backgroundColor = [UIColor redColor];
    transitionView.text = self.animationTypeArray[self.index];
    transitionView.numberOfLines = 0;
    [self.view addSubview:transitionView];
    self.transitionView = transitionView;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(self.view.center.x - 50, self.view.center.y, 100, 30);
    
    [btn setTitle:@"切换动画" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    CATransition *transition = [CATransition new];
    transition.duration = 1;
    transition.type = self.animationTypeArray[_index];
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.repeatCount = 1;
    transition.subtype = kCATransitionFromLeft;
    transition.autoreverses = YES;
    
    self.transition = transition;
    
   

}

- (void)btnAction:(UIButton *)sender {
    if (self.index == self.animationTypeArray.count - 1) {
        self.index = 0;
    } else {
        self.index++;
    }
    self.transition.type = self.animationTypeArray[_index];
    self.transitionView.text = self.animationTypeArray[_index];
    [self.transitionView.layer addAnimation:self.transition forKey:@"transition"];
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
