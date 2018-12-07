//
//  GDEditPageModel.m
//  GoodDeed
//
//  Created by HK on 2018/9/4.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDEditPageModel.h"

@interface GDEditPageModel ()

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (nonatomic, getter=withImage) BOOL image;


// For StackRank
@property (strong, nonatomic) GDEditRankEmptyViewModel *rankEmptyModel;

@end


@implementation GDEditPageModel

- (instancetype)initWithType:(GDSurveyEditType)type withImage:(BOOL)image
{
    self = [super init];
    if (self) {
        _type = type;
        _image = image;
        [self initializeDataSourceWithType:type];
        [self initializeImageData:image];
    }
    
    return self;
}


//- (void)addNoti{
//
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillShow:)
//                                                 name:UIKeyboardWillShowNotification
//                                               object:nil];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillHide:)
//                                                 name:UIKeyboardWillHideNotification
//                                               object:nil];
//
//}
//
//- (void)keyboardWillShow:(NSNotification *)notification {
//
//
//
//}
//
//- (void)keyboardWillHide:(NSNotification *)notification {
//
//
//
//}


- (void)initializeDataSourceWithType:(GDSurveyEditType)type
{
    switch (type) {
        case GDSurveyTypeChooseOne : {       // 单选
            [self initializeChooseOneDataSource];
        } break;
        case GDSurveyTypeChooseMultiple : {  // 多选
            [self initializeChooseMultipleDataSource];
        } break;
        case GDSurveyTypeSlidingScale : {    // 滑动
            [self initializeSlidingScaleDataSource];
        } break;
        case GDSurveyTypeBoundedRange : {    // 定量
            [self initializeBounddRangeDataSource];
        } break;
        case GDSurveyTypeStackRank : {       // 排序
            [self initializeStackRankDataSource];
        } break;
        case GDSurveyTypeImageVote : {       // 勾选图片
            [self initializeImageVoteDataSource];
        } break;
        case GDSurveyTypeText : {            //  填写
            [self initializeTextDataSource];
        } break;
        default:
            break;
    }
}

- (void)initializeImageData:(BOOL)image
{
    if (image) {
        _imageModel = [[GDEditImageViewModel alloc] init];
    } else {
        _imageModel = nil;
    }
}


#pragma mark - Public
// 数据源
- (NSInteger)numberOfItems
{
    return self.dataSource.count;
}

- (GDEditBaseViewModel *)itemAtIndex:(NSInteger)index
{
    if (index < self.dataSource.count) {
        return self.dataSource[index];
    }
    return nil;
}

// 增加新选项
- (void)addOption
{
    switch (self.type) {
        case GDSurveyTypeChooseOne: {
            [self chooseOneListAddOption];
        } break;
        case GDSurveyTypeChooseMultiple: {
            [self chooseMultipleListAddOption];
        } break;
        case GDSurveyTypeImageVote: {
            GDEditImageViewModel *image = [[GDEditImageViewModel alloc] init];
            image.kCellReuseId = kImageVoteAnswerCell;
            image.deleteEnabel = YES;
            [self.dataSource insertObject:image atIndex:[self.dataSource indexOfObject:[self.dataSource lastObject]]];
            for (id model in self.dataSource) {
                if ([model isKindOfClass:[GDEditBaseViewModel class]]) {
                    [(GDEditBaseViewModel *)model setDeleteEnabel:YES];
                }
            }
        }
        case GDSurveyTypeStackRank: {
            [self stackRankListAddOption];
        }
        default:
            break;
    }
}

// 删除选项
- (void)removeOption:(GDEditBaseViewModel *)option
{
    
    switch (self.type) {
        case GDSurveyTypeChooseOne: {
            [self chooseOneListRemoveOption:option];
        } break;
        case GDSurveyTypeChooseMultiple: {
            [self chooseMultipleListRemoveOption:option];
        } break;
        case GDSurveyTypeImageVote: {
            
        }
        case GDSurveyTypeStackRank: {
            [self stackRankListRemoveOption:option];
        }
        default:
            break;
    }
    
    [self.dataSource removeObject:option];
    if (self.type == GDSurveyTypeImageVote && self.dataSource.count <= 4) {
        for (id model in self.dataSource) {
            if ([model isKindOfClass:[GDEditBaseViewModel class]]) {
                [(GDEditBaseViewModel *)model setDeleteEnabel:NO];
            }
        }
    }
}

// 更新问卷图片
- (void)updateIncludeImage:(UIImage *)image
{
    self.imageModel.image = image;
}


#pragma GDEditBaseViewModel - Initialize DataSource

#pragma mark -  Choose One
- (void)initializeChooseOneDataSource
{
    [self.dataSource removeAllObjects];
    GDEditQuestionViewModel *questionModel = [[GDEditQuestionViewModel alloc] initWithPlaceholer:@"点击此处\n准备编辑你的提问"];
    questionModel.type = GDSurveyTypeChooseOne;
    
    GDEditTextViewModel *option_0 = [GDEditTextViewModel chooseOneViewModelWithSortIndex:0 deleteEnabel:NO];
    GDEditTextViewModel *option_1 = [GDEditTextViewModel chooseOneViewModelWithSortIndex:1 deleteEnabel:NO];
    GDEditToolViewModel *addOption = [GDEditToolViewModel chooseOneViewModel];
    
    [self.dataSource addObject:questionModel];
    [self.dataSource addObject:option_0];
    [self.dataSource addObject:option_1];
    [self.dataSource addObject:addOption];
}

- (void)chooseOneListAddOption
{
     GDEditBaseViewModel *lastOption = [self.dataSource objectAtIndex:(self.dataSource.count - 2)];
    GDEditTextViewModel *option = [GDEditTextViewModel chooseOneViewModelWithSortIndex:(lastOption.sortIndex + 1) deleteEnabel:YES] ;
    [self.dataSource insertObject:option atIndex:[self.dataSource indexOfObject:[self.dataSource lastObject]]];
    
    //[self updateDeleteEnabelOfItems:(self.dataSource.count - 2 > 2)];

    [self updateDeleteEnabelOfItems:NO addOption:option];
    
}

- (void)chooseOneListRemoveOption:(GDEditBaseViewModel *)option
{
    if ([self.dataSource containsObject:option]) {
        [self.dataSource removeObject:option];
        //[self updateDeleteEnabelOfItems:(self.dataSource.count - 2 > 2)];
        [self updateDeleteEnabelOfItems:NO];
    }
}

#pragma mark -  ChooseMultip
- (void)initializeChooseMultipleDataSource
{
    [self.dataSource removeAllObjects];
    GDEditQuestionViewModel *questionModel = [[GDEditQuestionViewModel alloc] initWithPlaceholer:@"点击此处\n准备编辑你的提问"];
    questionModel.type = GDSurveyTypeChooseMultiple;
    
    GDEditTextViewModel *option_0 = [GDEditTextViewModel chooseMultipViewModelWithSortIndex:0 deleteEnabel:NO];
    GDEditTextViewModel *option_1 = [GDEditTextViewModel chooseMultipViewModelWithSortIndex:1 deleteEnabel:NO];
    GDEditToolViewModel *addOption = [GDEditToolViewModel chooseMultipViewModel];
    
    [self.dataSource addObject:questionModel];
    [self.dataSource addObject:option_0];
    [self.dataSource addObject:option_1];
    [self.dataSource addObject:addOption];
}

- (void)chooseMultipleListAddOption
{
    GDEditBaseViewModel *lastOption = [self.dataSource objectAtIndex:(self.dataSource.count - 2)];
    GDEditTextViewModel *option = [GDEditTextViewModel chooseMultipViewModelWithSortIndex:(lastOption.sortIndex + 1) deleteEnabel:YES];
    

    [self.dataSource insertObject:option atIndex:[self.dataSource indexOfObject:[self.dataSource lastObject]]];
    
    //[self updateDeleteEnabelOfItems:(self.dataSource.count - 2 > 2)];
    [self updateDeleteEnabelOfItems:NO addOption:option];
}

- (void)chooseMultipleListRemoveOption:(GDEditBaseViewModel *)option
{
    if ([self.dataSource containsObject:option]) {
        [self.dataSource removeObject:option];
       // [self updateDeleteEnabelOfItems:(self.dataSource.count - 2 > 2)];
        [self updateDeleteEnabelOfItems:NO];
        
    }
}

#pragma mark - SlidingScale
- (void)initializeSlidingScaleDataSource
{
    [self.dataSource removeAllObjects];
    GDEditQuestionViewModel *questionModel = [[GDEditQuestionViewModel alloc] initWithPlaceholer:@"点击此处\n准备编辑你的提问"];
    questionModel.type = GDSurveyTypeSlidingScale;
    
    GDEditSlidingScaleViewModel *slidingScaleModel = [GDEditSlidingScaleViewModel slidingScaleViewModel];
    [self.dataSource addObject:questionModel];
    [self.dataSource addObject:slidingScaleModel];
}

#pragma mark - BoundRange
- (void)initializeBounddRangeDataSource
{
    [self.dataSource removeAllObjects];
    GDEditQuestionViewModel *questionModel = [[GDEditQuestionViewModel alloc] initWithPlaceholer:@"点击此处\n准备编辑你的提问"];
    questionModel.type = GDSurveyTypeBoundedRange;
    GDEditBoundRangeViewModel *answerModel = [GDEditBoundRangeViewModel boundRangeViewModel];
    [self.dataSource addObject:questionModel];
    [self.dataSource addObject:answerModel];
}

#pragma mark - StackRank
- (void)initializeStackRankDataSource
{
    [self.dataSource removeAllObjects];
    GDEditQuestionViewModel *questionModel = [[GDEditQuestionViewModel alloc] initWithPlaceholer:@"点击此处\n准备编辑你的提问"];
    questionModel.type = GDSurveyTypeStackRank;
    
    GDEditRankIndexViewModel *indexModel_1 = [[GDEditRankIndexViewModel alloc] initWithIndex:1];
    GDEditRankIndexViewModel *indexModel_2 = [[GDEditRankIndexViewModel alloc] initWithIndex:2];
    GDEditRankIndexViewModel *indexModel_3 = [[GDEditRankIndexViewModel alloc] initWithIndex:3];

    GDEditRankEmptyViewModel *emptyModel = [[GDEditRankEmptyViewModel alloc] init];
    self.rankEmptyModel = emptyModel;
    
    GDEditTextViewModel *answer_1 = [GDEditTextViewModel stackRangeViewModel:1 deleteEnabel:NO] ;
    GDEditTextViewModel *answer_2 = [GDEditTextViewModel stackRangeViewModel:2 deleteEnabel:NO] ;
    GDEditTextViewModel *answer_3 = [GDEditTextViewModel stackRangeViewModel:3 deleteEnabel:NO] ;
    
    GDEditToolViewModel *addModel = [GDEditToolViewModel stackRankViewModel];

    [self.dataSource addObject:questionModel];
    [self.dataSource addObject:indexModel_1];
    [self.dataSource addObject:indexModel_2];
    [self.dataSource addObject:indexModel_3];
    [self.dataSource addObject:emptyModel];
    [self.dataSource addObject:answer_1];
    [self.dataSource addObject:answer_2];
    [self.dataSource addObject:answer_3];
    [self.dataSource addObject:addModel];
}

// 排序增加选项
- (void)stackRankListAddOption
{
    NSInteger index = [self.dataSource indexOfObject:self.rankEmptyModel];
    GDEditRankIndexViewModel *lastRankModel = [self.dataSource objectAtIndex:(index - 1)];
    
    GDEditRankIndexViewModel *addIndexModel = [[GDEditRankIndexViewModel alloc] initWithIndex:(lastRankModel.index + 1)];
    [self.dataSource insertObject:addIndexModel atIndex:index];
    
    GDEditTextViewModel *answer = [GDEditTextViewModel stackRangeViewModel:3 deleteEnabel:YES] ;
    [self.dataSource insertObject:answer atIndex:(self.dataSource.count - 1)];

    //[self updateDeleteEnabelOfItems:(addIndexModel.index > 3)];
    [self updateDeleteEnabelOfItems:NO addOption:addIndexModel];
}

- (void)stackRankListRemoveOption:(GDEditBaseViewModel *)model
{
    if ([self.dataSource containsObject:model]) {
        [self.dataSource removeObject:model];
        NSInteger index = [self.dataSource indexOfObject:self.rankEmptyModel];
        [self.dataSource removeObjectAtIndex:(index - 1)];
        GDEditRankIndexViewModel *lastRankModel = [self.dataSource objectAtIndex:(index - 1)];
        [self.dataSource removeObject:lastRankModel];
        
        //[self updateDeleteEnabelOfItems:((lastRankModel.index  - 1)> 3)];
        [self updateDeleteEnabelOfItems:NO];
    }
}

#pragma mark - ImageVote
- (void)initializeImageVoteDataSource
{
    GDEditQuestionViewModel *questionModel = [[GDEditQuestionViewModel alloc] initWithPlaceholer:@"点击此处\n准备编辑你的提问"];
    questionModel.type = GDSurveyTypeImageVote;
    questionModel.kCellReuseId = kImageVoteQuestionCell;
    questionModel.cellDefaultHeight = 64.f;
    questionModel.cellHeight = 64.f;

    GDEditImageViewModel *image_0 = [[GDEditImageViewModel alloc] init];
    image_0.kCellReuseId = kImageVoteAnswerCell;
    image_0.deleteEnabel = NO;
    
    GDEditImageViewModel *image_1 = [[GDEditImageViewModel alloc] init];
    image_1.kCellReuseId = kImageVoteAnswerCell;
    image_1.deleteEnabel = NO;
    
     GDEditToolViewModel *addOption = [GDEditToolViewModel imageVoteViewModel];
    
    [self.dataSource addObject:questionModel];
    [self.dataSource addObject:image_0];
    [self.dataSource addObject:image_1];
    [self.dataSource addObject:addOption];
}

#pragma mark - Text
- (void)initializeTextDataSource
{
    [self.dataSource removeAllObjects];
    GDEditQuestionViewModel *questionModel = [[GDEditQuestionViewModel alloc] initWithPlaceholer:@"点击此处\n准备编辑你的提问"];
    questionModel.type = GDSurveyTypeText;
    GDEditTextViewModel *answerModel = [GDEditTextViewModel textViewModel];
    
    [self.dataSource addObject:questionModel];
    [self.dataSource addObject:answerModel];
}

#pragma mark - Tools
- (void)updateDeleteEnabelOfItems:(BOOL)deleteEnabel
{
    for (GDEditBaseViewModel *item in self.dataSource) {
        if ([item isKindOfClass:[GDEditBaseViewModel class]]) {
            [item setDeleteEnabel:deleteEnabel];
        }
    }
}

- (void)updateDeleteEnabelOfItems:(BOOL)deleteEnabel addOption:(GDEditBaseViewModel *)item{
    [self updateDeleteEnabelOfItems:deleteEnabel];
    if (item) {
        item.deleteEnabel = YES;
    }
    
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

@end
