//
//  GDImageSelCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/28.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDImageSelCell.h"
#import "SDPhotoBrowser.h"
@interface GDImageSelCell()<SDPhotoBrowserDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@property (weak, nonatomic) IBOutlet UIView *blurView;

@property (weak, nonatomic) IBOutlet UIImageView *finishImageView;
@end
@implementation GDImageSelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshData:(GDFirstQuestionListModel *)model{
    
    self.model = model;
    GDOptionModel *optionModel = model.firstOptionList[model.index];
    optionModel.optionName = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1543402593910&di=31e7246c9129590d772b1164b9537c5a&imgtype=0&src=http%3A%2F%2Fimg.mp.sohu.com%2Fupload%2F20170812%2F9d2c06b4343a45dda867eaab9ae9e13f_th.png";
    [self.selectImageView gd_setImageWithUrlStr:optionModel.optionName];
}

- (IBAction)buttonClickToMagnify:(id)sender {
    
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.delegate = self;
    browser.sourceImagesContainerView = self;
    browser.currentImageIndex = 0;
    browser.imageCount = 1;
    [browser show];

}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index{
    
    return self.selectImageView.image;
}

- (void)setSelected:(BOOL)selected{
    
    self.blurView.hidden = !selected;
    if (selected) {
        [UIView animateWithDuration:0.6 animations:^{
            self.finishImageView.alpha = 1;
        }];
    }else{
       self.finishImageView.alpha = 0;
    }
    
}

@end
