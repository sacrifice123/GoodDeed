//
//  GDCollectionViewCell.h
//  GoodDeed
//
//  Created by HK on 2018/8/10.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDSurveyTypeCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

+ (GDSurveyTypeCollectionViewCell *)surveyTypeCollectionViewCell;


@end
