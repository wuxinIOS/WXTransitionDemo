//
//  ViewController.m
//  WXTransitionDemo
//
//  Created by BlackEr Gray on 17/7/13.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

#import "ViewController.h"
#import "ModalViewController.h"
#import "WXMagicMoveController.h"
#import "WXPageController.h"

#import "FTT_Roundview.h"


@interface ViewController ()<ModalViewControllerDelegate>


@property(nonatomic, strong) UIButton *followMeBtn;

@property(nonatomic, strong) UIButton *clickButton;

@property(nonatomic, strong) FTT_Roundview *romateView;

@property(nonatomic, strong) NSMutableArray *titleArray;

@property(nonatomic, strong) NSMutableArray *imgArray;

@property(nonatomic, assign) CGPoint lastPoint;

@property(nonatomic,strong) NSTimer *timer;

@property(nonatomic, assign) CGFloat angle;

@end

@implementation ViewController

#pragma mark -- 懒加载

- (UIButton *)clickButton{
    if (!_clickButton) {
        _clickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _clickButton.backgroundColor = [UIColor redColor];
        _clickButton.frame = CGRectMake(0, 0, 100, 100);
        _clickButton.center = self.view.center;
        _clickButton.layer.cornerRadius = _clickButton.frame.size.width * 0.5;
        _clickButton.layer.masksToBounds = YES;
        [_clickButton setTitle:@"隐藏" forState:UIControlStateNormal];
        [_clickButton addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _clickButton;
}

- (UIButton *)followMeBtn {
    if (!_followMeBtn) {
        _followMeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _followMeBtn.backgroundColor = [UIColor clearColor];
        _followMeBtn.frame = CGRectMake(0, 0, 150, 150);
        _followMeBtn.center = CGPointMake(100, 100);
        _followMeBtn.layer.cornerRadius = _followMeBtn.frame.size.width * 0.5;
        _lastPoint = _followMeBtn.center;
        //_followMeBtn.layer.masksToBounds = YES;
        [_followMeBtn setTitle:@"·" forState:UIControlStateNormal];
        _followMeBtn.titleLabel.font = [UIFont systemFontOfSize:50];
        [_followMeBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _followMeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _followMeBtn.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        
    }
    return _followMeBtn;
}
- (FTT_Roundview *)romateView {
    if (!_romateView) {
        
        _romateView = [[FTT_Roundview alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width)];
        _romateView.center = self.view.center;
        _romateView.BtnBackgroudColor = [UIColor whiteColor];
    }
    return _romateView;
}

- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [@[@"神奇移动",@"抖动",@"扩散",@"翻页(page)",@"弹性(bounce)"] mutableCopy];
    }
    return _titleArray;
}

- (NSMutableArray *)imgArray{
    if (!_imgArray) {
        _imgArray = [@[@"btn_increase",@"business_center_2",@"home_2",@"message_2",@"task_management_2"] mutableCopy];
    }
    
    return _imgArray;
}


#pragma mark -- 系统方法

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       

    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    
    self.angle = M_PI * 0.0;
    
    __weak ViewController *weakself = self;
    self.romateView.back  = ^(NSInteger num ,NSString *name ) {
        [weakself romateViewItemDicClick:num title:name];
    };
    
    



}

#pragma mark -- 初始化

- (void)setupUI{
    
    [self setupRomateView];
    [self setupClickBtn];
    [self setupFollowBtn];
    [self setupTimer];

}

- (void)setupRomateView{
   
    [self.view addSubview:self.romateView];

    [self.romateView BtnType:FTT_RoundviewTypeCustom BtnWitch:100 adjustsFontSizesTowidth:YES msaksToBounds:YES conrenrRadius:50 image:self.imgArray TitileArray:self.titleArray titileColor:[UIColor blackColor]];



}

- (void)setupFollowBtn{
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [self.followMeBtn addGestureRecognizer:pan];
    [self.view insertSubview:self.followMeBtn atIndex:[self.view subviews].count];

    [self addRound];
}

- (void)addRound{
    
    int roundCount = 5;
    CGFloat angle = - M_PI * 2 / roundCount;
    CGFloat radius = self.followMeBtn.bounds.size.width * 0.5;
    CGFloat x = self.followMeBtn.bounds.size.width * 0.5;
    CGFloat y = self.followMeBtn.bounds.size.height * 0.5;
    
    for (int i = 0; i<roundCount; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor orangeColor];
        button.frame = CGRectMake(0, 0, 50, 50);
        button.layer.cornerRadius = button.bounds.size.width * 0.5;
        button.layer.masksToBounds = YES;
        
        CGFloat num = (i + 3 - 0.1) * 1.0;
        CGPoint center = CGPointMake(x + radius * cos(num *angle ), y + radius*sin(num *angle));
        button.center = center;

        [self.followMeBtn addSubview:button];
        
        
    }
    
}


- (void)setupClickBtn{
    [self.view addSubview:self.clickButton];


}


- (void)setupTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(automaticRotation) userInfo:nil repeats:YES];
    
}




#pragma mark -- 手势处理
- (void)clickBtnAction:(UIButton *)sender {
    [self.romateView show];
    if ([sender.titleLabel.text isEqualToString:@"隐藏"]) {
        [sender setTitle:@"显示" forState:UIControlStateNormal];
    } else {
        [sender setTitle:@"隐藏" forState:UIControlStateNormal];
    }
    
}

- (void)romateViewItemDicClick:(NSInteger)num title:(NSString *)title{
    
    
    if ([title  isEqual: @"弹性(bounce)"]) {
        [self bounceBtnClicked:nil];
    } else if ([title isEqualToString:@"神奇移动"]) {
        WXMagicMoveController *magicMoveVC = [[WXMagicMoveController alloc]init];
        UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:magicMoveVC];
        magicMoveVC.title = @"神奇移动";
        [self presentViewController:navc animated:YES completion:nil];
        
    } else if ([title isEqualToString:@"翻页(page)"]) {
        WXPageController *pageController = [[WXPageController alloc]init];
        pageController.navigationController.delegate = pageController;
        pageController.title = @"翻页效果";
        [self.navigationController pushViewController:pageController animated:YES];
    }
    
}

-(void) bounceBtnClicked:(id)sender
{
    ModalViewController *mvc =  [[ModalViewController alloc] init];
    mvc.transitioningDelegate = mvc;//设置将要呈现的控制器的动画的代理
    mvc.delegate = self;
    [self presentViewController:mvc animated:YES completion:nil];
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

- (void)automaticRotation{
    self.angle += 0.01;
    
    if (self.angle > 6.28) {
        self.angle = 0;
    }
    
    
    self.followMeBtn.transform = CGAffineTransformMakeRotation(self.angle);
    
}

#pragma mark--ModalViewController协议
- (void)modalViewControllerDidClickDismissButton:(ModalViewController *)modalViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
