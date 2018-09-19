//
//  GDCollectionViewCell.m
//  GoodDeed
//
//  Created by HK on 2018/8/10.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDSurveyTypeCollectionViewCell.h"

@implementation GDSurveyTypeCollectionViewCell

+ (GDSurveyTypeCollectionViewCell *)surveyTypeCollectionViewCell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"GDSurveyTypeCollectionViewCell" owner:nil options:nil] firstObject];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageView.userInteractionEnabled = YES;
}

@end
