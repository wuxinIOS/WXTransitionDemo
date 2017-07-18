//
//  WX_CABasicAnimation.m
//  WXTransitionDemo
//
//  Created by BlackEr Gray on 17/7/17.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

#import "WX_CABasicAnimation.h"

@interface WX_CABasicAnimation ()
@property(strong, nonatomic)CABasicAnimation *basicAnimation;
@property(nonatomic, strong)UIView *redView;
@property(nonatomic,strong) NSString *keyPath;

@end

@implementation WX_CABasicAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.keyPath = @"transform.rotation.x";

    /** 旋转动画 */
    UIView *view_x = [[UIView alloc]initWithFrame:CGRectMake(self.view.center.x - 25, 70, 50, 50)];
    self.redView = view_x;
    view_x.backgroundColor = [UIColor redColor];
    [self.view addSubview:view_x];
    
    CABasicAnimation *transformXAnimation = [[CABasicAnimation alloc]init];
    transformXAnimation.keyPath = self.keyPath;//设置旋转的方向
    transformXAnimation.duration = 2;
    transformXAnimation.beginTime = 0;
    transformXAnimation.repeatCount = MAXFLOAT;
    transformXAnimation.toValue = [NSNumber numberWithFloat:2*M_PI];
    self.basicAnimation = transformXAnimation;
    [view_x.layer addAnimation:transformXAnimation forKey:@"basicAnimation"];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(self.view.center.x - 50, 150, 100, 30);
    [btn setTitle:@"沿x/y/z旋转" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    /**** 缩放动画 */
    UIView *scaleView = [[UIView alloc]initWithFrame:CGRectMake(self.view.center.x-30, CGRectGetMaxY(btn.frame)+20, 60, 60)];
    
    scaleView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scaleView];
    
    CABasicAnimation *scaleAnimation = [[CABasicAnimation alloc]init];
    scaleAnimation.keyPath = @"transform.scale";//动画的样式
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.3];
    scaleAnimation.duration = 1;
    scaleAnimation.beginTime = 0;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.autoreverses = YES;
    [scaleView.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    
    /** 变化内容的动画 */
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.center.x-40, CGRectGetMaxY(scaleView.frame)+20, 80, 100)];
    imgView.image = [UIImage imageNamed:@"1"];
    
    [self.view addSubview:imgView];
    
    CABasicAnimation *contentAnimation = [[CABasicAnimation alloc]init];
    contentAnimation.keyPath = @"contents";//动画的样式
    contentAnimation.fromValue = (id)[UIImage imageNamed:@"1"].CGImage;
    contentAnimation.toValue = (id)[UIImage imageNamed:@"2"].CGImage;
    contentAnimation.duration = 2;
    contentAnimation.beginTime = 0;
    contentAnimation.repeatCount = MAXFLOAT;
    contentAnimation.autoreverses = YES;
    [imgView.layer addAnimation:contentAnimation forKey:@"contentAnimation"];

}

- (UIButton *)buttonWithFrame:(CGRect)frame withTitle:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}



- (void)btnAction:(UIButton *)sender {
    
    if ([self.keyPath isEqualToString:@"transform.rotation.x"]) {
        self.keyPath = @"transform.rotation.y";
    } else if ([self.keyPath isEqualToString:@"transform.rotation.y"]) {
        self.keyPath = @"transform.rotation.z";
    } else if ([self.keyPath isEqualToString:@"transform.rotation.z"]) {
        self.keyPath = @"transform.rotation.x";
    }
    
    self.basicAnimation.keyPath = self.keyPath;
    [self.redView.layer addAnimation:self.basicAnimation forKey:@"basicAnimation"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* keyPath值:
 transform.scale = 比例轉換
 
 transform.scale.x = 闊的比例轉換
 
 transform.scale.y = 高的比例轉換
 
 transform.rotation.z = 平面圖的旋轉
 
 opacity = 透明度
 
 margin
 
 zPosition
 
 backgroundColor    背景颜色
 
 cornerRadius    圆角
 
 borderWidth
 
 bounds
 
 contents
 
 contentsRect
 
 cornerRadius
 
 frame
 
 hidden
 
 mask
 
 masksToBounds
 
 opacity
 
 position
 
 shadowColor
 
 shadowOffset
 
 shadowOpacity
 
 shadowRadius
*/

@end
