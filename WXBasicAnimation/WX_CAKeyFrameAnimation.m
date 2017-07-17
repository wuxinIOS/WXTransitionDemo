//
//  WX_CAKeyFrameAnimation.m
//  WXTransitionDemo
//
//  Created by BlackEr Gray on 17/7/17.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

#import "WX_CAKeyFrameAnimation.h"

@interface WX_CAKeyFrameAnimation ()

@end

@implementation WX_CAKeyFrameAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    //bezierPath曲线
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:self.view.bounds.size.width * 0.4 startAngle:0 endAngle:2 * M_PI clockwise:NO];
    
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.frame = self.view.frame;
    layer.path = bezierPath.CGPath;
    layer.fillColor = [UIColor whiteColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
    
    UIView *animationView = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 70, 80)];
    animationView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:animationView];
    
    CAKeyframeAnimation *keyAnimation = [[CAKeyframeAnimation alloc]init];
    keyAnimation.keyPath = @"position";
    keyAnimation.duration = 5;
    keyAnimation.path = bezierPath.CGPath;
    keyAnimation.fillMode = kCAFillModeForwards;
    keyAnimation.calculationMode = kCAAnimationPaced;
    keyAnimation.repeatCount = MAXFLOAT;
    
    /**
     rotationMode : 旋转样式
     1）kCAAnimationRotateAuto 根据路径自动旋转
     2）kCAAnimationRotateAutoReverse 根据路径自动翻转
     */
    keyAnimation.rotationMode = kCAAnimationRotateAuto;
    [animationView.layer addAnimation:keyAnimation forKey:@"keyAnimation"];
    
    
    
    
    
    
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
