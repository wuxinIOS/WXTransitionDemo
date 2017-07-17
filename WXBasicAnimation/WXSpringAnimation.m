//
//  WXSpringAnimation.m
//  WXTransitionDemo
//
//  Created by BlackEr Gray on 17/7/17.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

#import "WXSpringAnimation.h"

@interface WXSpringAnimation ()
@property(nonatomic, strong)UIView *springView;
@end

@implementation WXSpringAnimation

- (UIView *)springView {
    if (!_springView) {
        _springView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        _springView.layer.cornerRadius = _springView.bounds.size.width * 0.5;
        _springView.backgroundColor = [UIColor redColor];
        _springView.layer.masksToBounds = YES;
    }
    return _springView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.springView];
    self.springView.frame = CGRectMake(self.view.center.x, self.view.bounds.size.height, 50, 50);
}

- (void)viewDidAppear:(BOOL)animated {
    /**
     dampingRatio：速度衰减比例。取值范围0 ~ 1，值越低震动越强
     velocity：初始化速度，值越高则物品的速度越快
     */
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.springView.frame = CGRectMake(self.view.center.x, 70, 50, 50);
    } completion:nil];
    
    
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
