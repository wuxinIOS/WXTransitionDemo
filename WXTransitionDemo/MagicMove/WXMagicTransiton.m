//
//  WXMagicTransiton.m
//  WXTransitionDemo
//
//  Created by BlackEr Gray on 17/7/14.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

#import "WXMagicTransiton.h"
#import "WXMagicMoveController.h"
#import "WXMagicMovePushController.h"

@interface WXMagicTransiton()
@property(nonatomic, assign)WXNaviTransitionType type;
@end


@implementation WXMagicTransiton


#pragma mark -- 初始化方法
- (instancetype)initWithTransitionType:(WXNaviTransitionType)type{
    if (self = [super init]) {
        self.type = type;
    }
    return self;
}

+ (instancetype)magicTransitionWithType:(WXNaviTransitionType)type{
    return [[self alloc]initWithTransitionType:type];
}


#pragma mark --UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    
    if (self.type == WXNaviOneTransitionTypePush) {
        
        [self pushWith:transitionContext];
        
    } else if (self.type == WXNaviOneTransitionTypePop) {
        [self popWith:transitionContext];
    }
    
    
    
    
}

- (void)pushWith:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    //拿到原控制器
    WXMagicMoveController *fromVC = (WXMagicMoveController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    //拿到将要显示的控制器
    WXMagicMovePushController *toVC = (WXMagicMovePushController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //拿到当前点击的cell的imageView
    UICollectionViewCell *cell = (UICollectionViewCell *)[fromVC.collectionView cellForItemAtIndexPath:fromVC.currentIndexPath];
    
    //拿到容器视图
    UIView *containerView = [transitionContext containerView];
    
    
    UIImageView *imgView = [cell viewWithTag:10];
    
    //过渡视图
    //snapshotViewAfterScreenUpdates 对cell的imageView截图保存成另一个视图用于过渡，并将视图转换到当前控制器的坐标
    UIView *tempView = [imgView snapshotViewAfterScreenUpdates:NO];
    tempView.frame = [imgView convertRect:imgView.bounds toView: containerView];
    
    //设置动画前的各个控件的状态
    imgView.hidden = YES;
    toVC.view.alpha = 0;
    toVC.imageView.hidden = YES;
    
    //tempView 添加到containerView中，要保证在最前方，所以后添加
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    
    //开始做动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1 / 0.55 options:0 animations:^{
        tempView.frame = [toVC.imageView convertRect:toVC.imageView.bounds toView:containerView];
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        tempView.hidden = YES;
        toVC.imageView.hidden = NO;
        //如果动画过渡取消了就标记不完成，否则才完成，这里可以直接写YES，如果有手势过渡才需要判断，必须标记，否则系统不会中动画完成的部署，会出现无法交互之类的bug
        imgView.hidden = NO;
        [transitionContext completeTransition:YES];
    }];
    

}

- (void)popWith:(id<UIViewControllerContextTransitioning>)transitionContext{
   
    WXMagicMovePushController *fromVC = (WXMagicMovePushController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    WXMagicMoveController *toVC = (WXMagicMoveController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UICollectionViewCell *cell = (UICollectionViewCell *)[toVC.collectionView cellForItemAtIndexPath:toVC.currentIndexPath];
    UIView *containerView = [transitionContext containerView];
    //这里的lastView就是push时候初始化的那个tempView
    UIView *tempView = containerView.subviews.lastObject;
    UIImageView *imgView = [cell viewWithTag:10];
    //设置初始状态
    imgView.hidden = YES;
    fromVC.imageView.hidden = YES;
    tempView.hidden = NO;
    [containerView insertSubview:toVC.view atIndex:0];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.55 initialSpringVelocity:1 / 0.55 options:0 animations:^{
        tempView.frame = [imgView convertRect:imgView.bounds toView:containerView];
        fromVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        //由于加入了手势必须判断
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {//手势取消了，原来隐藏的imageView要显示出来
            //失败了隐藏tempView，显示fromVC.imageView
            tempView.hidden = YES;
            fromVC.imageView.hidden = NO;
        }else{//手势成功，cell的imageView也要显示出来
            //成功了移除tempView，下一次pop的时候又要创建，然后显示cell的imageView
            imgView.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];
}




@end
