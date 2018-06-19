//
//  GDPreviewViewController.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/8.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDPreviewViewController.h"
#import "GDHomeManager.h"

@interface GDPreviewViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIView *transitionView;
@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation GDPreviewViewController

static CGFloat const XMGAnimationDelay = 0.1;
static CGFloat const XMGSpringFactor = 10;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView reloadData];
    self.collectionView.hidden = YES;
    
    
}

- (UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        _collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-15*3)*0.5, (SCREEN_WIDTH-15*3)*0.5);
        layout.sectionInset = UIEdgeInsetsMake(50, 15, 15, 15);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 10;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 100, 100);
    label.text = [NSString stringWithFormat:@"%li",indexPath.row];
    label.textColor = [UIColor redColor];
    [cell addSubview:label];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.collectionView.hidden = NO;
    [GDHomeManager POPAnimationExecutionWith:self.collectionView];
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self performSelector:@selector(remove) withObject:nil afterDelay:0.2];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (void)remove{
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (UIView *)hh_transitionAnimationView{
    
    return self.view;
}
@end
