//
//  ZJZSuperViewController.m
//  ZJZHomework11-02
//
//  Created by bwfwangbin on 16/3/7.
//  Copyright © 2016年 zhangjunzhe. All rights reserved.
//

#import "ZJZSuperViewController.h"




@interface ZJZSuperViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation ZJZSuperViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)createCameraOrAlbumWithSourceType:(UIImagePickerControllerSourceType)sourceType{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    //设置类型
    imagePicker.sourceType = sourceType;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:^{}];
}

#pragma mark -- pickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"%@",info);
    if ([[info objectForKey:@"UIImagePickerControllerMediaType"]isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(20+50, 64+20, image.size.width*0.05, image.size.height*0.05)];
        imageV.image = image;
        [self.view addSubview:imageV];
    }
    [picker dismissViewControllerAnimated:YES completion:^{}];
}


-(void)createNavigationItemsWithImages:(NSArray *)images andWithType:(BOOL)type andWithTag:(NSArray *)tags{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 0 ; i < images.count ;i ++) {
        NSString *string = images[i];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:string]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(onBarButtonClick:)];
        item.tag = [tags[i] intValue];
        [arr addObject:item];
    }
    if (type == YES) {
        self.navigationItem.leftBarButtonItems = arr;
    }else{
        self.navigationItem.rightBarButtonItems = arr;
    }
}

-(void)onBarButtonClick:(UIBarButtonItem *)sender{
    
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
