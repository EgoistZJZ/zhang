//
//  ZJZSuperViewController.h
//  ZJZHomework11-02
//
//  Created by bwfwangbin on 16/3/7.
//  Copyright © 2016年 zhangjunzhe. All rights reserved.
//

//头文件区
#import <UIKit/UIKit.h>
#import "ZJZMethods.h"

//宏定义区
#define ZJZSIZE [UIScreen mainScreen].bounds.size

#define ZJZCGRectMake2(x,y,w,h) CGRectMake(x, y, w/320.0*ZJZSIZE.width, h/480.0*ZJZSIZE.height)

#define ZJZCGRectMake3(x,y,w,h) CGRectMake(x/320.0*ZJZSIZE.width, y, w/320.0*ZJZSIZE.width, h/480.0*ZJZSIZE.height)

#define ZJZCGRectMake4(x,y,w,h) CGRectMake(x/320.0*ZJZSIZE.width, y/480.0*ZJZSIZE.height, w/320.0*ZJZSIZE.width, h/480.0*ZJZSIZE.height)

@interface ZJZSuperViewController : UIViewController

#pragma mark -- 方法区

//调用相册或相机
-(void)createCameraOrAlbumWithSourceType:(UIImagePickerControllerSourceType)sourceType;

-(void)createNavigationItemsWithImages:(NSArray *)images andWithType:(BOOL)type andWithTag:(NSArray *)tags;
-(void)onBarButtonClick:(UIBarButtonItem *)sender;

@end
