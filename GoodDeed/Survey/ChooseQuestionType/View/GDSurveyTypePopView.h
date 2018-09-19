//
//  GDSurveyTypePopView.h
//  GoodDeed
//
//  Created by HK on 2018/8/10.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GDSurveyTypePopViewSelectedBlock) (NSInteger index);


@interface GDSurveyTypePopView : UIView


@property (copy, nonatomic) GDSurveyTypePopViewSelectedBlock selected;
@property (copy, nonatomic) dispatch_block_t dismiss;


+ (GDSurveyTypePopView *)showSurveyTypePopViewWithTopImage:(UIImage *)topImage
                                                   topName:(NSString *)topName
                                                  botImage:(UIImage *)botImage
                                                   botName:(NSString *)botName
                                                   selected:(GDSurveyTypePopViewSelectedBlock)selected
                                                   dismiss:(dispatch_block_t)dismiss;

- (instancetype)initWithTopImage:(UIImage *)topImage
                         topName:(NSString *)topName
                        botImage:(UIImage *)botImage
                         botName:(NSString *)botName
                        selected:(GDSurveyTypePopViewSelectedBlock)selected
                         dismiss:(dispatch_block_t)dismiss;

- (void)show;

@end
