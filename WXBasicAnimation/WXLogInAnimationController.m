//
//  WXLogInAnimationController.m
//  WXTransitionDemo
//
//  Created by BlackEr Gray on 17/7/17.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

#import "WXLogInAnimationController.h"

@interface WXLogInAnimationController ()
@property(nonatomic, strong)UITextField *userName;
@property(nonatomic, strong)UITextField *passWorld;
@property(nonatomic,strong)UIButton *logoButton;
@end

@implementation WXLogInAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    [self setupUI];

}

- (void)viewDidAppear:(BOOL)animated {
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.userName.center = CGPointMake(self.view.center.x, self.userName.frame.origin.y + self.userName.frame.size.height * 0.5);
    } completion:nil];
    
    [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.passWorld.center = CGPointMake(self.view.center.x, CGRectGetMaxY(self.userName.frame)+40);
    } completion:nil];
    
    [UIView animateWithDuration:0.2 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.logoButton.alpha = 1;
    } completion:nil];
    
    
}


-(void)setupUI{
    
    self.userName = [self textFieldWithFrame:CGRectMake(-200, 70, 200, 30) placeholder:@"userName"];
    [self.view addSubview:self.userName];
    
    self.passWorld = [self textFieldWithFrame:CGRectMake(-200, CGRectGetMaxY(self.userName.frame) + 40, 200, 30) placeholder:@"passWord"];
    [self.view addSubview:self.passWorld];
    
    self.logoButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.logoButton.backgroundColor = [UIColor redColor];
    self.logoButton.frame = CGRectMake(0, 0, 60, 30);
    [self.logoButton setTitle:@"LOGIn" forState:UIControlStateNormal];
    self.logoButton.center = CGPointMake(self.view.center.x, CGRectGetMaxY(self.passWorld.frame) + 40);
    [self.view addSubview:self.logoButton];
    self.logoButton.alpha = 0;
    
}

- (UITextField *)textFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder {
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    textField.placeholder = placeholder;
    textField.backgroundColor = [UIColor whiteColor];
    return textField;
    
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
