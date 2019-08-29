//
//  HMPhotoBrowserViewController.h
//  HMPhotoPickerDemo
//
//  Created by HuminiOS on 15/11/16.
//  Copyright © 2015年 HuminiOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "JCHATPhotoSelectViewController.h"

@interface JCHATPhotoBrowserViewController : UIViewController
@property (strong, nonatomic)PHCollection *photoCollection;
@property (strong, nonatomic)PHCachingImageManager *imageManager;
@property (strong, nonatomic)PHFetchResult *allFetchResult;
@property (strong, nonatomic)NSMutableArray *allPhotoArr;
@property (assign, nonatomic)NSIndexPath *currentIndex;
@property (weak, nonatomic) IBOutlet UIButton *selectOriginBtn;
@property (weak, nonatomic)id<JCHATPhotoPickerViewControllerDelegate> photoDelegate;
@property (weak, nonatomic)JCHATPhotoSelectViewController *selectVCDelegate;
@end
