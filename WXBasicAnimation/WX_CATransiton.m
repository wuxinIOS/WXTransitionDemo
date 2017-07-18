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
    transitionView.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:transitionView];
    self.transitionView = transitionView;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(self.view.center.x - 50, self.view.center.y, 100, 30);
    
    [btn setTitle:@"切换动画" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
    CATransition *transition = [CATransition new];
    transition.duration = 1;
    
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.repeatCount = 1;
    transition.subtype = kCATransitionFromLeft;
//    transition.autoreverses = YES;
    
    self.transition = transition;
    
    [self setupBtn];
   
}

- (void)setupBtn{
    
    CGFloat x = 10;
    CGFloat y = 300;
    int count = self.animationTypeArray.count;
    int col = 3;
    int row = 0;
    int cow = 0;
    CGFloat widht = (self.view.bounds.size.width - 4 * x) / col;
    CGFloat height = 30;
    for (int i = 0; i < count; i++) {
        row = i / col;
        cow = i % col;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        CGRect frame = CGRectMake( cow * (x + widht) + x, row * (x + height) + y, widht, height);
        btn.frame = frame;
        [btn setTitle:self.animationTypeArray[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(changedAnimation:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.numberOfLines = 0;
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:btn];
        btn.tag = i;
    }
    
    
    
}


- (void)changedAnimation:(UIButton *)sender {
    int index = sender.tag;
    self.transition.type = self.animationTypeArray[index];
    self.transitionView.text = self.animationTypeArray[index];
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
