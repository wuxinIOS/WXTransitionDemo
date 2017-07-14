//
//  WXMagicTransiton.h
//  WXTransitionDemo
//
//  Created by BlackEr Gray on 17/7/14.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//控制器push pop的枚举
typedef NS_ENUM(NSUInteger,WXNaviTransitionType){
    WXNaviOneTransitionTypePush = 0,
    WXNaviOneTransitionTypePop
};

@interface WXMagicTransiton : NSObject<UIViewControllerAnimatedTransitioning>


//动画类型初始化方法
+(instancetype)magicTransitionWithType:(WXNaviTransitionType)type;
-(instancetype)initWithTransitionType:(WXNaviTransitionType)type;

@end
