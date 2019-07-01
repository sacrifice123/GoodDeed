//
//  SCAdView.m
//  SCAdViewDemo
//
//  Created by 陈世翰 on 17/2/7.
//  Copyright © 2017年 Coder Chan. All rights reserved.
//

#import "SCAdView.h"
#import "SCAdCollectionViewLayout.h"
#import "GDBaseCell.h"
#import "GDCollectionView.h"
#import "GDSurveyCell.h"
#import "GDGroupCell.h"

///默认的自动轮播的时间间隔
#define SC_BUILDER_DEFAULT_AUTO_SCROLL_CYCLE 1.0
///2D时自动计算linespacing的倍数
#define SC_BUILDER_AUTO_SET_LINESPACING_RATIO 0.15
///不使用3D缩放  >0起效
#define SC_BUILDER_NO_3D -1
///最小的行间距 如果不足够大，会出现两行的情况
#define SC_BUILDER_DEFAULT_MINIMUMINTERITEMSPACING 10000

#define SC_AD_CELL_IDENTIFIER @"SC_AD_CELL_IDENTIFIER"
#define SC_ERROR(_DESC_)  NSCAssert(0,_DESC_)
///轮播两侧准备的item倍数 count of prepared item group at the both side
#define SC_PREPARE_ITEM_TIME 2
@interface SCAdView()<SCCollectionViewFlowLayoutDelegate>
{
    SCAdViewBuilder *_builder;
    ///因为当用户滑动的时候，轮播不应该继续，所以会被停掉，但是当滑动结束，会根据是否开启了轮播而重新开启
    BOOL _isPlaying; //真实是否开启了播放的状态
    BOOL _expctedToPlay;//用户启动的play
}
/**
 *   计时器
 */
@property (nonatomic,strong)NSTimer *timer;
@end

@implementation SCAdViewBuilder
@end

@interface SCAdView()<UICollectionViewDelegate,UICollectionViewDataSource>
/**
 *   collection
 */
@property (nonatomic,strong)GDCollectionView *collectionView;
/**
 *   data
 */
@end

@implementation SCAdView
{
    UIPageControl *page;
    NSInteger idx;
}

-(instancetype)initWithBuilder:(void (^) (SCAdViewBuilder *builder))builderBlock{
    if (self = [super init]) {
        SCAdViewBuilder *builder = [SCAdViewBuilder new];
        builder.allowedInfinite = YES;
        builder.scrollEnabled = YES;
        builder.infiniteCycle = SC_BUILDER_DEFAULT_AUTO_SCROLL_CYCLE;
        builder.threeDimensionalScale  = SC_BUILDER_NO_3D;
        builder.minimumInteritemSpacing = SC_BUILDER_DEFAULT_MINIMUMINTERITEMSPACING;
        builder.minimumLineSpacing = SC_BUILDER_LINE_SPACING_AUTO;
        if (builderBlock) {
            builderBlock(builder);
        }
        [self _auto_set_builder:builder];
        [self setUpWithBuilder:builder];
    }
    return self;
}

-(void)_auto_set_builder:(SCAdViewBuilder *)builder{
    //自动填充lineSpacing
    if (builder.minimumLineSpacing==SC_BUILDER_LINE_SPACING_AUTO) {
        if (builder.threeDimensionalScale>1) {
            if (builder.autoScrollDirection>1) {//用户漏了填写间距，将自动填写
                builder.minimumLineSpacing = (builder.threeDimensionalScale-1)*builder.adItemSize.height/1;
            }else{
                builder.minimumLineSpacing = (builder.threeDimensionalScale-1)*builder.adItemSize.width/1;
            }
        }else if(builder.threeDimensionalScale<0){
            if (builder.autoScrollDirection>1) {//用户漏了填写间距，将自动填写
                builder.minimumLineSpacing = SC_BUILDER_AUTO_SET_LINESPACING_RATIO*builder.adItemSize.height/1;
            }else{
                builder.minimumLineSpacing = SC_BUILDER_AUTO_SET_LINESPACING_RATIO*builder.adItemSize.width/1;
            }
        }
    }
}

- (NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
//- (void)setDataArray:(NSMutableArray *)dataArray{
//
//    _dataArray = dataArray;
//
//    NSArray *temArray = [NSArray array];
//    if (!_builder.allowedInfinite) {
//        if (_builder.adArray) {
//            _dataArray = [NSMutableArray arrayWithArray:_builder.adArray];
//        }
//    }else{//无限轮播
//        if (_builder.adArray && _builder.adArray.count>0) {
//            for (int i=0;i<2*SC_PREPARE_ITEM_TIME+1;i++) {
//                temArray = [temArray arrayByAddingObjectsFromArray:_builder.adArray];
//            }
//        }
//        _dataArray = [NSMutableArray arrayWithArray:temArray];
//    }
//    [self.collectionView reloadData];
//
//}

/**
 *  @brief 初始化
 */
-(void)setUpWithBuilder:(SCAdViewBuilder *)builder{
    _builder = builder;
    self.frame = builder.viewFrame;
    SCAdCollectionViewLayout *layout = [SCAdCollectionViewLayout new];
    layout.scrollDirection = (_builder.autoScrollDirection>1)?UICollectionViewScrollDirectionVertical:UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = builder.adItemSize;
    layout.minimumLineSpacing = builder.minimumLineSpacing;
    layout.minimumInteritemSpacing = builder.minimumInteritemSpacing;
    layout.delegate = self;
    if(_builder.autoScrollDirection>1){
        CGFloat y_inset =(self.frame.size.height-layout.itemSize.height) / 2.f;
        layout.sectionInset = UIEdgeInsetsMake(y_inset,0,y_inset,0);
    }else{
    CGFloat x_inset =(self.frame.size.width-layout.itemSize.width) / 2.f;
    layout.sectionInset = UIEdgeInsetsMake(0, x_inset, 0, x_inset);
    }
    layout.sectionInset = UIEdgeInsetsMake(0, Item_Space, 0, Item_Space);
    self.collectionView = [[GDCollectionView alloc]initWithFrame:(CGRect){0,0,self.frame.size} collectionViewLayout:layout];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.decelerationRate = 0;
    self.collectionView.scrollEnabled = builder.scrollEnabled;
    idx = 0;
    //根据需要增加
    [self.collectionView registerNib:[UINib nibWithNibName:@"GDSurveyCell" bundle:nil] forCellWithReuseIdentifier:@"GDSurveyCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"GDGroupCell" bundle:nil] forCellWithReuseIdentifier:@"GDGroupCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"GDGroupListCell" bundle:nil] forCellWithReuseIdentifier:@"GDGroupListCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"GDCardCell" bundle:nil] forCellWithReuseIdentifier:@"GDCardCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"GDWelcomeCell" bundle:nil] forCellWithReuseIdentifier:@"GDWelcomeCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"GDSuveryStatusCell" bundle:nil] forCellWithReuseIdentifier:@"GDSuveryStatusCell"];



//    if (builder.itemCellNibName.length>0) {
//       // UINib *nib = [UINib nibWithNibName:builder.itemCellNibName bundle:nil];
//    }else if(builder.itemCellClassName.length>0 && NSClassFromString(builder.itemCellClassName)){
//        [self.collectionView registerClass:NSClassFromString(builder.itemCellClassName) forCellWithReuseIdentifier:SC_AD_CELL_IDENTIFIER];
//    }else{
//        SC_ERROR(@"builder必须参数缺失 : ------>必须在builder指定一个cell的类或者nib");
//    }
    [self addSubview:self.collectionView];


}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if(_builder.allowedInfinite){
        CGPoint offet;
        if (_builder.autoScrollDirection<=1) {
           offet = (CGPoint){(_builder.adItemSize.width+_builder.minimumLineSpacing)*(_builder.adArray.count)*SC_PREPARE_ITEM_TIME,0};
        }else{
           offet = (CGPoint){0,(_builder.adItemSize.height+_builder.minimumLineSpacing)*(_builder.adArray.count)*SC_PREPARE_ITEM_TIME};
        }
        
        [self.collectionView setContentOffset:offet];
    }
}
/**
 *  @brief 计时器执行方法,增加偏移量
 */
-(void)_playNextAd{
    
    CGPoint pInUnderView = [self convertPoint:self.collectionView.center toView:self.collectionView];
   // NSLog(@"x===%f",pInUnderView.x);
    // 获取中间的indexpath
    NSIndexPath *indexpath = [self.collectionView indexPathForItemAtPoint:pInUnderView];
    
    // 获取滑动目标的indexPath
    NSIndexPath *to_indexPath;
    if(_builder.autoScrollDirection==SCAdViewScrollDirectionRight || _builder.autoScrollDirection==SCAdViewScrollDirectionBotom){
        to_indexPath=[NSIndexPath indexPathForRow:indexpath.row+1 inSection:0];//向右或向下
    }else{
        to_indexPath=[NSIndexPath indexPathForRow:indexpath.row-1 inSection:0];//向左或向上
    }
    if (_builder.autoScrollDirection>1) {
        [self.collectionView scrollToItemAtIndexPath:to_indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
    }else{
        [self.collectionView scrollToItemAtIndexPath:to_indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
    
}
#pragma mark -collection delegate/datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GDHomeModel *model = self.dataArray[indexPath.item];
    GDBaseCell *cell;
    if (model.type == GDHomeWelcomeType) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GDWelcomeCell" forIndexPath:indexPath];

    }else if (model.type == GDHomeCardType){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GDCardCell" forIndexPath:indexPath];

    }else if (model.type == GDHomeSurveyType||self.type == GDHomeType) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GDSurveyCell" forIndexPath:indexPath];
    }else if (model.type == GDHomeTeamType){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GDGroupCell" forIndexPath:indexPath];
    }else if (model.type == GDHomeTeamFinishType){//创建团队完成
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GDGroupListCell" forIndexPath:indexPath];
    }else if (model.type == GDHomeSuveryStatusType){//互相了解下（没有可以回答的问卷）
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GDSuveryStatusCell" forIndexPath:indexPath];
    }
    if (cell) {
        cell.delegate = self.delegate;
        cell.cardModel = model;
    }
    return cell;
}

// 点击item的时候
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGPoint pInUnderView = [self convertPoint:collectionView.center toView:collectionView];
    
    // 获取中间的indexpath
    NSIndexPath *indexpathNew = [collectionView indexPathForItemAtPoint:pInUnderView];
    
    if (indexPath.row == indexpathNew.row)
    {
        //点击了中间的广告
        if (self.delegate &&[self.delegate respondsToSelector:@selector(sc_didClickAd:)]) {
            [self.delegate sc_didClickAd:self.dataArray[indexPath.row]];
        }
    }
    else
    {
        //点击了背后的广告，将会被移动上来
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self _secretlyChangeIndex];
    if (_expctedToPlay) {
        [self play];
    }
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self _secretlyChangeIndex];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (_expctedToPlay) {
        [self _pauseOperation];
    }
}

-(void)_secretlyChangeIndex{
    if (!_builder.allowedInfinite)return;
    CGPoint pInUnderView = [self convertPoint:self.collectionView.center toView:self.collectionView];
    // 获取中间的indexpath
    NSIndexPath *indexpath = [self.collectionView indexPathForItemAtPoint:pInUnderView];
    NSInteger itemCount =_builder.adArray.count;
    if (indexpath.row<itemCount*SC_PREPARE_ITEM_TIME || indexpath.row>=itemCount*(SC_PREPARE_ITEM_TIME+1)) {
        NSIndexPath *to_indexPath =[NSIndexPath indexPathForRow:indexpath.row%itemCount+itemCount*SC_PREPARE_ITEM_TIME inSection:0];
        if (_builder.autoScrollDirection>1) {
            [self.collectionView scrollToItemAtIndexPath:to_indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
        }else{
            [self.collectionView scrollToItemAtIndexPath:to_indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        }
    }
}


#pragma mark -layout delegate
-(void)sc_collectioViewScrollToIndex:(NSInteger)index{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(sc_scrollToIndex:)]) {
//        if (index == 10) {
//            return;
//        }
//
//        idx ++;
//        if (idx>=page.numberOfPages) {
//            idx = 0;
//        }
//        page.currentPage = idx;

        
        NSLog(@"%li====%li",index,page.currentPage);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint pInUnderView = [self convertPoint:self.collectionView.center toView:self.collectionView];
    // 获取中间的indexpath
    NSIndexPath *indexpath = [self.collectionView indexPathForItemAtPoint:pInUnderView];
    idx = indexpath.row-10;
    if (idx>=page.numberOfPages) {
        idx = 0;
    }
    page.currentPage = idx;


}

#pragma mark -override
-(void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    [self.collectionView setBackgroundColor:backgroundColor];
}

#pragma mark operate
-(void)play{
    if (_builder.allowedInfinite) {
        [self _pauseOperation];
        _expctedToPlay = YES;
        _isPlaying = YES;
        
        if(!self.timer){
            self.timer =[NSTimer scheduledTimerWithTimeInterval:_builder.infiniteCycle target:self selector:@selector(_playNextAd) userInfo:nil repeats:YES];
        }

    }else{
        SC_ERROR(@"builder没有允许无限轮播");
    }
    
}

-(void)pause{
    _expctedToPlay = NO;
    [self _pauseOperation];
}

-(void)_pauseOperation{
    _isPlaying = NO;
    if (_builder.allowedInfinite) {
        if (self.timer) {
             [self.timer invalidate];
        }
        self.timer = nil;
    }
}

-(void)reloadWithDataArray:(NSArray *)adArray{
//    NSArray *dataArray = @[];
//    if (!_builder.allowedInfinite) {
//        if (adArray) {
//            self.dataArray = [NSMutableArray arrayWithArray:adArray];
//        }
//    }else{//无限轮播
//        if (adArray && adArray.count>0) {
//            for (int i=0;i<2*SC_PREPARE_ITEM_TIME+1;i++) {
//                dataArray = [dataArray arrayByAddingObjectsFromArray:adArray];
//            }
//        }
//        self.dataArray = [NSMutableArray arrayWithArray:dataArray];
//    }
    if (adArray) {
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:adArray];
    }

    self.collectionView.scrollEnabled = !(self.dataArray.count==1);
    [self.collectionView reloadData];
//    if (self.dataArray.count>1) {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0];
//        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
//
//    }

}
@end
