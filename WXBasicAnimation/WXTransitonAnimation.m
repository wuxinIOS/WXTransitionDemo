//
//  WXTransitonAnimation.m
//  WXTransitionDemo
//
//  Created by BlackEr Gray on 17/7/17.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

#import "WXTransitonAnimation.h"

@interface WXTransitonAnimation ()

@property(nonatomic, strong) UIImageView *imgeView;
@property(nonatomic, assign) BOOL tap;
@end

@implementation WXTransitonAnimation

- (UIImageView *)imgeView {
    if (!_imgeView) {
        _imgeView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 100)];
        _imgeView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        _imgeView.image = [UIImage imageNamed:@"1"];
        [_imgeView addGestureRecognizer:tap];
    }
    return _imgeView;
}

- (void)tapAction:(UIGestureRecognizer *)tap {
    /*
     
     UIViewAnimationOptionTransitionNone            //没有效果，默认
     UIViewAnimationOptionTransitionFlipFromLeft    //从左翻转效果
     UIViewAnimationOptionTransitionFlipFromRight   //从右翻转效果
     UIViewAnimationOptionTransitionCurlUp          //从上往下翻页
     UIViewAnimationOptionTransitionCurlDown        //从下往上翻页
     UIViewAnimationOptionTransitionCrossDissolve   //旧视图溶解过渡到下一个视图
     UIViewAnimationOptionTransitionFlipFromTop     //从上翻转效果
     UIViewAnimationOptionTransitionFlipFromBottom  //从上翻转效果
     
     
     
     */
    
    [UIView transitionWithView:tap.view duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        [self animation];
    } completion:nil];
    
    
    
    
}

- (void)animation{
    if (self.tap) {
        self.imgeView.image = [UIImage imageNamed:@"1"];
    } else {
        self.imgeView.image = [UIImage imageNamed:@"2"];
    }
    self.tap = !self.tap;

}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:self.imgeView];
    self.imgeView.center = self.view.center;
    

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
