//
//  ZJZMethods.m
//  ZJZHomework11-02
//
//  Created by bwfwangbin on 16/3/7.
//  Copyright © 2016年 zhangjunzhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJZMethods.h"
#import <QuartzCore/QuartzCore.h>
#import "qrencode.h"


@implementation ZJZMethods

#pragma mark --读取文件URL
+(NSURL *)getURLWithName:(NSString *)name{
    NSArray *arr = [name componentsSeparatedByString:@"."];
    NSString *url = [[NSBundle mainBundle]pathForResource:arr[0] ofType:arr[1]];
    return [NSURL URLWithString:url];
}

#pragma mark -- 播放短音频
+(void)playShortSoundWithName:(NSString *)soundName{
    //    声明SoundID
    SystemSoundID soundID;
    //    绑定音频URL和SsoundID
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)([self getURLWithName:soundName]), &soundID);
    //    委托系统替我们播放这个音频
    AudioServicesPlayAlertSound(soundID);
}
@end


#pragma mark -- 跳转页面时候的效果动画
@implementation UIView (ZJZTransitionAnimation)

- (void)setTransitionAnimationType:(ZJZTransitionAnimationType)transtionAnimationType toward:(ZJZTransitionAnimationToward)transitionAnimationToward duration:(NSTimeInterval)duration
{
    CATransition * transition = [CATransition animation];
    transition.duration = duration;
    NSArray * animations = @[@"cameraIris",
                             @"cube",
                             @"fade",
                             @"moveIn",
                             @"oglFilp",
                             @"pageCurl",
                             @"pageUnCurl",
                             @"push",
                             @"reveal",
                             @"rippleEffect",
                             @"suckEffect"];
    NSArray * subTypes = @[@"fromLeft", @"fromRight", @"fromTop", @"fromBottom"];
    transition.type = animations[transtionAnimationType];
    transition.subtype = subTypes[transitionAnimationToward];
    
    [self.layer addAnimation:transition forKey:nil];
}

@end

//#pragma mark -- 添加手势
@implementation UIViewController (ZJZGesture)
CGRect _rect;
UITapGestureRecognizer *_tapGR;
UITapGestureRecognizer *_tapGR2;
UITapGestureRecognizer *_tapGR3;
UIImageView *_imageV;
CGPoint _jPoint;

-(void)setZJZGestureType:(ZJZGestureType)GestureType ImageView:(UIImageView *)imageV{
    _rect = CGRectMake(0, 0, 0, 0);
    _tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecoginzer:)];
    _tapGR2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecoginzer:)];
    _tapGR3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecoginzer:)];
    _imageV = imageV;
    _imageV.userInteractionEnabled = YES;
    switch (GestureType) {
        case ZJZGestureTypeTap:
            [self createTapGestureRecognizer];
            break;
        case ZJZGestureTypeLongPress:
            [self createLongPressGestureRecognizer];
            break;
        case ZJZGestureTypeSwipe:
            [self createSwipeGestureRecognizer];
            break;
        case ZJZGestureTypePan:
            [self createPanGestureRecognizer];
            break;
        case ZJZGestureTypeRotation:
            [self createRotationGestureRecognizer];
            break;
        case ZJZGestureTypePinch:
            [self createPinchGestureRecognizer];
            break;
        default:
            break;
    }
}

//点击
-(void)createTapGestureRecognizer{
    //双击
    _tapGR2.numberOfTapsRequired = 2;
    _rect = _imageV.frame;
    [_imageV addGestureRecognizer:_tapGR2];
    /**一个view可以添加多个手势，一个手势只能添加到一个view上**/
    //单击
    
    _tapGR.numberOfTapsRequired = 1;
    [_imageV addGestureRecognizer:_tapGR];
    //先响应第二个参数，再响应第一个参数
    [_tapGR requireGestureRecognizerToFail:_tapGR2];
    
    _tapGR3.numberOfTapsRequired = 3;
    [_imageV addGestureRecognizer:_tapGR3];
    //优先响应级 3--2--1
    [_tapGR requireGestureRecognizerToFail:_tapGR3];
    [_tapGR2 requireGestureRecognizerToFail:_tapGR3];
}
-(void)tapGestureRecoginzer:(UITapGestureRecognizer *)sender{
    if (sender.numberOfTapsRequired == 2) {//双击事件
        _imageV.frame = self.view.frame;
        //放大之后使三击失效
        _tapGR3.numberOfTapsRequired = 2;
    }else if(sender.numberOfTapsRequired == 1){//单击事件
        _imageV.frame = _rect;
        //缩小之后使三击有效
        _tapGR3.numberOfTapsRequired = 3;
    }else{//三击事件
        [_imageV removeFromSuperview];
    }
}

//长按
-(void)createLongPressGestureRecognizer{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress)];
    longPress.numberOfTouchesRequired = 1;
    longPress.minimumPressDuration = 2;
    [_imageV addGestureRecognizer:longPress];
}
-(void)longPress{
    //ios 9.0以后弃用
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

//滑动
-(void)createSwipeGestureRecognizer{
    UISwipeGestureRecognizer *swipeGR = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureRecognizer:)];
    swipeGR.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeGR.numberOfTouchesRequired = 1;
    [_imageV addGestureRecognizer:swipeGR];
}
-(void)swipeGestureRecognizer:(UISwipeGestureRecognizer *)sender{
    CGRect rect = _imageV.frame;
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        rect.origin.x -= 50;
    }
    _imageV.frame = rect;
}

//拖拽
-(void)createPanGestureRecognizer{
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:panGR];
}
-(void)pan:(UIPanGestureRecognizer *)sender{
    
    CGPoint point = [sender translationInView:self.view];//手指落点为point的原点，手指偏移量即为point坐标的变化
    static CGPoint center;
    if (sender.state == UIGestureRecognizerStateBegan) {
        center = _imageV.center;//手指每次滑动开始时，将图片当前的中点赋值给center
    }
    _imageV.center = CGPointMake(center.x+point.x, center.y+point.y);
}

//旋转
-(void)createRotationGestureRecognizer{
    UIRotationGestureRecognizer *rotationGR = [[UIRotationGestureRecognizer alloc]init];
    [rotationGR addTarget:self action:@selector(rotation:)];
    //旋转手势的特有属性
    //此属性是用来监听接收手势视图旋转的角度的，并赋值给rotation
    //    rotationGR.rotation
    [_imageV addGestureRecognizer:rotationGR];
}
-(void)rotation:(UIRotationGestureRecognizer *)sender{
    //    the view the gesture is attached to.
    //    sender.view
    static float rotation = 0;
    //UIView的通过角度旋转
    _imageV.transform = CGAffineTransformMakeRotation(rotation +sender.rotation);
    //手势的知识点：手势有以下几个状态（开始、结束、变化、取消、失败、可能）
    if (sender.state == UIGestureRecognizerStateEnded) {
        rotation += sender.rotation;
    }
}

//捏合
-(void)createPinchGestureRecognizer{
    UIPinchGestureRecognizer *pinchGR = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
    [_imageV addGestureRecognizer:pinchGR];
}
-(void)pinch:(UIPinchGestureRecognizer *)sender{
    NSLog(@"%f",sender.scale);
    static float scale = 1;
    _imageV.transform = CGAffineTransformMakeScale(scale*sender.scale, scale*sender.scale);
    if (sender.state == UIGestureRecognizerStateEnded) {
        scale *= sender.scale;
    }
}


enum {
    qr_margin = 3
};

@end
@implementation QRCodeGenerator

+ (void)drawQRCode:(QRcode *)code context:(CGContextRef)ctx size:(CGFloat)size {
    unsigned char *data = 0;
    int width;
    data = code->data;
    width = code->width;
    float zoom = (double)size / (code->width + 2.0 * qr_margin);
    CGRect rectDraw = CGRectMake(0, 0, zoom, zoom);
    
    // draw
    CGContextSetFillColor(ctx, CGColorGetComponents([UIColor blackColor].CGColor));
    for(int i = 0; i < width; ++i) {
        for(int j = 0; j < width; ++j) {
            if(*data & 1) {
                rectDraw.origin = CGPointMake((j + qr_margin) * zoom,(i + qr_margin) * zoom);
                CGContextAddRect(ctx, rectDraw);
            }
            ++data;
        }
    }
    CGContextFillPath(ctx);
}

+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)size {
    if (![string length]) {
        return nil;
    }
    
    QRcode *code = QRcode_encodeString([string UTF8String], 0, QR_ECLEVEL_L, QR_MODE_8, 1);
    if (!code) {
        return nil;
    }
    
    // create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(0, size, size, 8, size * 4, colorSpace, kCGImageAlphaPremultipliedLast);
    
    CGAffineTransform translateTransform = CGAffineTransformMakeTranslation(0, -size);
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1, -1);
    CGContextConcatCTM(ctx, CGAffineTransformConcat(translateTransform, scaleTransform));
    
    // draw QR on this context
    [QRCodeGenerator drawQRCode:code context:ctx size:size];
    
    // get image
    CGImageRef qrCGImage = CGBitmapContextCreateImage(ctx);
    UIImage * qrImage = [UIImage imageWithCGImage:qrCGImage];
    
    // some releases
    CGContextRelease(ctx);
    CGImageRelease(qrCGImage);
    CGColorSpaceRelease(colorSpace);
    QRcode_free(code);
    
    return qrImage;
}

@end

