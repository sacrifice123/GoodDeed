//
//  GDGroupListCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/9/20.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDGroupListCell.h"
#import "GDGroupListItemCell.h"

@interface GDGroupListCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *groupTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneySubLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UIView *inviteView;

@end
@implementation GDGroupListCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"GDGroupListItemCell" bundle:nil] forCellWithReuseIdentifier:@"GDGroupListItemCell"];
    //请求我的团队的列表数据
    [GDHomeManager getGroupInfoWithCompletionBlock:^(NSMutableArray *array) {
        
        if (array) {
            CGFloat sum = 0.0;
            for (GDGroupListModel *obj in array) {
                self.groupTitleLabel.text = obj.name;
                if (obj&&![obj.money isKindOfClass:[NSNull class]]) {
                    sum += obj.money.floatValue;
                }
            }
            NSString *strValue=[NSString stringWithFormat:@"%0.2f", sum];
            NSArray *values = [strValue componentsSeparatedByString:@"."];
            self.totalMoneyLabel.text = values.firstObject;
            self.totalMoneySubLabel.text = values.lastObject;
            [self.dataArray addObjectsFromArray:array];
            [self.collectionView reloadData];
        }
    }];
}


- (NSMutableArray *)dataArray{
    
    if (_dataArray==nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (IBAction)invite:(id)sender {
    
    self.inviteView.hidden = NO;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
    return self.dataArray.count>4?4:self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GDGroupListItemCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"GDGroupListItemCell" forIndexPath:indexPath];
    cell.isMore = (self.dataArray.count>4);
    if (self.dataArray.count>indexPath.row) {
        GDGroupListModel *model = self.dataArray[indexPath.row];
        model.index = indexPath;
        cell.model = model;

    }
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((SCREEN_WIDTH-65-30)*0.5, (SCREEN_WIDTH-65-30)*0.5+30);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 20, 0, 20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 25;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 3) {
        self.inviteView.hidden = NO;
    }
}

//完成
- (IBAction)finish:(id)sender {
    
    self.inviteView.hidden = YES;
}


@end
