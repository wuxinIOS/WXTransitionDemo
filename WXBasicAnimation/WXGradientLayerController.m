//
//  WXGradientLayerController.m
//  WXTransitionDemo
//
//  Created by BlackEr Gray on 17/7/18.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

#import "WXGradientLayerController.h"

#define ARC4RANDOM_MAX      0x100000000

@interface WXGradientLayerController ()
@property(nonatomic, strong)NSTimer *timer;
@property(nonatomic, strong)CAGradientLayer *gradientLayer;
@end

@implementation WXGradientLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    UIView *gradientView = [[UIView alloc]initWithFrame:CGRectMake(10, 200, 100, 10)];
    gradientView.center = self.view.center;
    gradientView.layer.borderWidth = 1;
    gradientView.layer.borderColor = [UIColor blueColor].CGColor;
    //    gradientView.backgroundColor = [UIColor redColor];
    gradientView.layer.cornerRadius = gradientView.bounds.size.height * 0.5;
    gradientView.layer.masksToBounds = YES;
    [self.view addSubview:gradientView];
    
    
    
    //CAGradientLayer知识点
    CAGradientLayer *gradientLayoer = [[CAGradientLayer alloc]init];
    gradientLayoer.colors = @[(id)[UIColor blueColor].CGColor,(id)[UIColor orangeColor].CGColor,(id)[UIColor redColor].CGColor];
    gradientLayoer.frame = gradientView.bounds;
    gradientLayoer.cornerRadius = gradientLayoer.bounds.size.height * 0.5;
    gradientLayoer.locations = @[@0.2,@0.6,@1];
    gradientLayoer.startPoint = CGPointMake(0, 0.5);
    gradientLayoer.endPoint = CGPointMake(1, 0.5);
    gradientLayoer.type = kCAGradientLayerAxial;
    
    [gradientView.layer addSublayer:gradientLayoer];
    self.gradientLayer = gradientLayoer;
    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(colorChanged) userInfo:nil repeats:YES];
    

}

- (void)colorChanged{
    
    double val1 = (rand()%100000)*0.00001;
    double val2 = (rand()%100000)*0.00001;
    self.gradientLayer.locations = @[@(val1),@(val2),@1];
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
