//
//  ZBImagePickerObject.m
//  BSApp
//
//  Created by 李振彪 on 2016/11/9.
//  Copyright © 2016年 BaoThink. All rights reserved.
//

#import "ZBImagePickerObject.h"
#import "UIImage+Category.h"

@implementation ZBImagePickerObject


#pragma mark 调用相册
- (void)selectImageFromAlbum:(id <UINavigationControllerDelegate, UIImagePickerControllerDelegate> )delegate viewController:(UIViewController *)viewController
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [picker.navigationBar setBarTintColor:[UIColor colorWithRed:0.0/255.0 green:149.0/255.0 blue:250.0/255 alpha:1]];
    picker.delegate = delegate;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    NSArray *temp_MediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
    picker.mediaTypes = temp_MediaTypes;
    picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [viewController presentViewController:picker animated:YES completion:nil];
}


#pragma mark 调用相机

- (void)selectImageFromCamera:(id <UINavigationControllerDelegate, UIImagePickerControllerDelegate>)delegate viewController:(UIViewController *)viewController
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [picker.navigationBar setBarTintColor:[UIColor colorWithRed:0.0/255.0 green:149.0/255.0 blue:250.0/255 alpha:1]];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        NSString *requiredMediaType = ( NSString *)kUTTypeImage;
        NSArray *arrMediaTypes=[NSArray arrayWithObjects:requiredMediaType,nil];
        [picker setMediaTypes:arrMediaTypes];
        picker.showsCameraControls = YES;
        picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        picker.editing = YES;
        picker.delegate = delegate;
        picker.showsCameraControls = YES;
        [viewController presentViewController:picker animated:YES completion:nil];
    }
    
}

////相机相册 Finish的代理
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    
//    
//    __block UIImage *image;
//    __weak SJTaskVC * weakSelf = self;
//    UIImage *origionImage = [info objectForKey:UIImagePickerControllerOriginalImage];
//    //保存图片到系统相册
//    UIImageWriteToSavedPhotosAlbum(origionImage, self, @selector(image:didFinishSaveingWithError:contextInfo:), nil);
//    [self dismissViewControllerAnimated:YES completion:^{
//
//        //压缩图片
//        NSDictionary *dic =[self _compressureImage:origionImage];
//        image = [dic valueForKey:@"image"];
////        NSMutableArray *tempArr = [NSMutableArray array];
////        for (int i = 0; i < weakSelf.datas.count; i++) {
////
////            CSTaskModel *modle = weakSelf.datas[i];
////            if (i == weakSelf.currentTag-tagOffSet){
////                if ([modle.IStatus isEqualToString:@"10"]) {
////                    modle.dImage = image;
////                    modle.dIsHaveImage = YES;
////                    modle.dImageData = [dic valueForKey:@"imageData"];
////                }
////                if ([modle.IStatus isEqualToString:@"50"]) {
////                    modle.rImage = image;
////                    modle.rIsHaveImage = YES;
////                    modle.rImageData = [dic valueForKey:@"imageData"];
////                }
////            }
////
////            [tempArr addObject:modle];
////        }
////        weakSelf.datas = tempArr;
////        [weakSelf.tableView reloadData];
//
//    }];
//    
//}
///** 拍照后, 保存图片到本地失败 */
//-(void)image:(UIImage *)image didFinishSaveingWithError:(NSError *)error contextInfo:(void *)contextInfo{
//    if (error) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误!" message:@"保存图片到相册失败！" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
//        [alert show];
//    }
//}


/** 压缩图片, 转为500kb以下的图片 */
- (NSDictionary *)compressureImage:(UIImage *)origionImage isUnder500k:(BOOL)isUnder500k{
    origionImage = [UIImage fixOrientation:origionImage];

    NSDictionary *dic;
    //初始化, 如果原图小于500k,直接返回初始图片
    UIImage *image = origionImage;
    
   
    NSData *imgData;// [NSData data];
    //以下两种方法，（在JPEG的初始压缩率为1的情况下），尽管初始大小不一样，但第一遍压缩后的，两者的大小是一样的，最终需要压缩的次数，以及最后的大小也是一样的。
    
    if(isUnder500k == YES){
        imgData = UIImagePNGRepresentation(origionImage);
    //    NSLog(@"原图大小_%ld",imgData.length);
    
        //500kb = 512000bit
        CGFloat count = 1.0;//在原图基础上进行压缩
        for (int i = 25 ; i>1; i--) {//_4414092
    
            if (imgData.length > 512000) {
    
                NSData *tempData2 = UIImageJPEGRepresentation(origionImage, count);
                image = [UIImage imageWithData:tempData2];
                count = count - 0.04;//压缩比率每次递减0.04
                imgData = tempData2;
                //NSLog(@"压缩图片,%d,%f_%ld",i,count,tempData2.length);
                
            }
        }
    }else{
        imgData = UIImageJPEGRepresentation(origionImage, 0.5);//后方设置的是在原图被压缩到指定倍数之后返回的图片，1为JPEG原图
    }
    

    dic = @{@"image":image,@"imageData":imgData};
    return dic;
}


@end
