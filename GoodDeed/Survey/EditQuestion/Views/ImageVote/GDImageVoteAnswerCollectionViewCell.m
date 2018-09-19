//
//  GDImageVoteAnswerCollectionViewCell.m
//  GoodDeed
//
//  Created by HK on 2018/9/5.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDImageVoteAnswerCollectionViewCell.h"

@implementation GDImageVoteAnswerCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)deleteAction:(UIButton *)sender
{
    if (self.deleteEvent) {
        self.deleteEvent(self, self.viewModel);
    }
}

- (void)setViewModel:(GDEditImageViewModel *)viewModel
{
    _viewModel = viewModel;
    self.deleteButton.hidden = !viewModel.deleteEnabel;
    
    BOOL hasImage = (viewModel.image != nil);
    self.addLabel.hidden = hasImage;
    self.addImageView.hidden = hasImage;
    self.coverImageView.image = viewModel.image;
}

@end
