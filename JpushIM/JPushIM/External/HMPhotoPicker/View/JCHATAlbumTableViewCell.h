//
//  AlbumTableViewCell.h
//  photosFramework
//
//  Created by HuminiOS on 15/11/11.
//  Copyright © 2015年 HuminiOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "JCHATAlbumModel.h"

@interface JCHATAlbumTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *albumImage;
@property (weak, nonatomic) IBOutlet UILabel *albumTittle;
@property (weak, nonatomic) PHCollection *albumCollection;

- (void)layoutWithAlbumModel:(JCHATAlbumModel *)model;
@end
