//
//  ZJZMethods.h
//  ZJZHomework11-02
//
//  Created by bwfwangbin on 16/3/7.
//  Copyright © 2016年 zhangjunzhe. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@interface ZJZMethods : NSObject

#pragma mark --读取文件URL
+(NSURL *)getURLWithName:(NSString *)name;

#pragma mark --播放短音频
/*使用步骤*/
/*#import <AVFoundation/AVFoundation.h>*/

+(void)playShortSoundWithName:(NSString *)soundName;


#pragma mark -- 跳转页面时候的效果动画
/**＊＊＊＊＊＊使用步骤＊＊＊＊＊＊＊＊＊＊*/
/***1.添加QuartzCore.framework  ***/
/***2.导入头文件#import <QuartzCore/QuartzCore.h>***/
@end
typedef enum
{
    ZJZTransitionAnimationTypeCameraIris,
    //相机
    ZJZTransitionAnimationTypeCube,
    //立方体
    ZJZTransitionAnimationTypeFade,
    //淡入
    ZJZTransitionAnimationTypeMoveIn,
    //移入
    ZJZTransitionAnimationTypeOglFilp,
    //翻转
    ZJZTransitionAnimationTypePageCurl,
    //翻去一页
    ZJZTransitionAnimationTypePageUnCurl,
    //添上一页
    ZJZTransitionAnimationTypePush,
    //平移
    ZJZTransitionAnimationTypeReveal,
    //移走
    ZJZTransitionAnimationTypeRippleEffect,
    ZJZTransitionAnimationTypeSuckEffect
}ZJZTransitionAnimationType;

/**动画方向*/
typedef enum
{
    ZJZTransitionAnimationTowardFromLeft,
    ZJZTransitionAnimationTowardFromRight,
    ZJZTransitionAnimationTowardFromTop,
    ZJZTransitionAnimationTowardFromBottom
}ZJZTransitionAnimationToward;

@interface UIView (ZJZTransitionAnimation)

//为当前视图添加切换的动画效果
//参数是动画类型和方向
//如果要切换两个视图，应将动画添加到父视图
- (void)setTransitionAnimationType:(ZJZTransitionAnimationType)transtionAnimationType toward:(ZJZTransitionAnimationToward)transitionAnimationToward duration:(NSTimeInterval)duration;

@end
#pragma mark --二维码
@interface QRCodeGenerator : NSObject

+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)size;

@end
#pragma mark -- 添加手势
typedef enum
{
    //点击
    ZJZGestureTypeTap,
    //长按
    ZJZGestureTypeLongPress,
    //滑动
    ZJZGestureTypeSwipe,
    //拖拽
    ZJZGestureTypePan,
    //旋转
    ZJZGestureTypeRotation,
    //捏合
    ZJZGestureTypePinch
}ZJZGestureType;
@interface UIViewController (ZJZGesture)
-(void)setZJZGestureType:(ZJZGestureType)GestureType ImageView:(UIImageView *)imageV;
@end
