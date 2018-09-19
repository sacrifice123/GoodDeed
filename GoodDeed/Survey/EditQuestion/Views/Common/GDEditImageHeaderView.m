//
//  GDEditImageHeaderView.m
//  GoodDeed
//
//  Created by HK on 2018/8/21.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDEditImageHeaderView.h"

@interface GDEditImageHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIImageView *addIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *addLabel;

@end

@implementation GDEditImageHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)]];
}

+ (GDEditImageHeaderView *)editImageHeaderViewWithImage:(UIImage *)image clickEvent:(dispatch_block_t)clickEvent
{
    GDEditImageHeaderView *view = [GDEditImageHeaderView editImageHeaderViewFromXib];
    view.clickEvent = clickEvent;
    view.image = image;
    return view;
}

+ (GDEditImageHeaderView *)editImageHeaderViewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"GDEditImageHeaderView" owner:nil options:nil] firstObject];
}

- (void)click
{
    if (self.clickEvent) {
        self.clickEvent();
    }
}


- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
    self.addIconImageView.hidden = image;
    self.addLabel.hidden = image;
}

@end
