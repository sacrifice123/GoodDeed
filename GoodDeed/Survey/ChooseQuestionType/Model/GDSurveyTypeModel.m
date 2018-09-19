//
//  GDSurveyTypeModel.m
//  GoodDeed
//
//  Created by HK on 2018/8/10.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDSurveyTypeModel.h"

@implementation GDSurveyTypeModel

- (instancetype)initWithType:(GDSurveyEditType)type
{
    self = [super init];
    if (self) {
        
        _type = type;
        
        [self initailizeData];
        
    }
    
    return self;
}

- (void)initailizeData
{
    

    switch (self.type) {
        case GDSurveyTypeChooseOne: {       // 单选
            _name = @"单选题";
            _image = [UIImage imageNamed:@"st_choose_one"];
        } break;
        case GDSurveyTypeChooseMultiple: {  // 多选
            _name = @"多选题";
            _image = [UIImage imageNamed:@"st_choose_multiple"];
        } break;
        case GDSurveyTypeSlidingScale: {    // 滑动
            _name = @"滑动";
            _image = [UIImage imageNamed:@"st_sliding_scale"];
        } break;
        case GDSurveyTypeBoundedRange: {    // 定量
            _name = @"定量";
            _image = [UIImage imageNamed:@"st_bounded_range"];
        } break;
        case GDSurveyTypeStackRank: {       // 排序
            _name = @"排序";
            _image = [UIImage imageNamed:@"st_stack_rank"];
        } break;
        case GDSurveyTypeImageVote: {       // 勾选图片
            _name = @"勾选图片";
            _image = [UIImage imageNamed:@"st_image_vote"];
        } break;
        case GDSurveyTypeText: {            //  填写
            _name = @"填写";
            _image = [UIImage imageNamed:@"st_text"];
        } break;
        default:
            break;
    }
    
}

@end
