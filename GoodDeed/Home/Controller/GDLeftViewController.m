//
//  GDLeftViewController.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDLeftViewController.h"
#import "GDLeftCell.h"
#import "GDLeftHeaderView.h"
#import "GDLeftModel.h"
#import "GDPGChooseViewController.h"
#import "GDHomeViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>


@interface GDLeftViewController ()<UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) GDLeftHeaderView *headerView;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@end

@implementation GDLeftViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    __weak typeof(self) weakSelf = self;
    self.headerView.chooseBlock = ^{
        [weakSelf chooseHeadImage];
    };
    [self.tableView registerNib:[UINib nibWithNibName:@"GDLeftCell" bundle:nil] forCellReuseIdentifier:@"GDLeftCell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:GDReloadHome object:nil];
}

- (UIImagePickerController *)imagePickerController{
    
    if (_imagePickerController == nil) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        // 设置代理
        _imagePickerController.delegate = self;
        // 是否显示裁剪框编辑（默认为NO），等于YES的时候，照片拍摄完成可以进行裁剪
        _imagePickerController.allowsEditing = YES;

    }
    
    return _imagePickerController;
}

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.bounces = NO;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#535353"];
    }
    return _tableView;
}

- (GDLeftHeaderView *)headerView{
    
    if (_headerView == nil) {
        _headerView = [[NSBundle mainBundle] loadNibNamed:@"GDLeftHeaderView" owner:self options:nil].lastObject;
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 130);
    }
    return _headerView;
}

- (NSMutableArray *)datas{
    
    if (_datas == nil) {
        _datas = [[NSMutableArray alloc] init];
        NSArray *titles = @[@"首页",@"我的事业",@"我的团队",@"我的调查",@"反馈与帮助",@"退出"];
        for (int i=0; i<titles.count; i++) {
            GDLeftModel *model = [[GDLeftModel alloc] init];
            model.title = titles[i];
            [_datas addObject:model];
        }
    }
    return _datas;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GDLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GDLeftCell" forIndexPath:indexPath];
    GDLeftModel *model = self.datas[indexPath.row];
    model.index = indexPath;
    cell.model = model;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 75;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//    return self.headerView;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 130;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   // [GDHomeManager closeDrawerWithFull];
    [self showHomeView:NO];
    switch (indexPath.row) {
        case 0://首页
        case 2://我的团队
        case 3://我的调查
        {
            GDHomeViewController *home = [self getHomeVc];
            [home reloadDataWithIndex:indexPath.row];
            [GDHomeManager closeDrawer];
        }
            break;

        case 1:{//我的事业
            GDPGChooseViewController *chooseVc = [GDPGChooseViewController new];
            chooseVc.isClose = NO;
            [self presentViewController:chooseVc animated:YES completion:nil];
        }
            
            break;
        case 4:{//反馈与帮助
            [GDHomeManager closeDrawer];
            [self showHomeView:YES];
        }
            break;
        case 5:{//退出
            [self showQuitAlert];
        }
            break;

        default:
            break;
    }
    
}

//反馈与帮助
- (void)showHomeView:(BOOL)isHelp{
    
    GDHomeViewController *home = [self getHomeVc];
    if (home) {
        for (UIView *view in home.view.subviews) {
            if (view.tag == 1001&&isHelp) {
                [home showHelpView];
                break;
            }else if (view.tag == 1000){
                [home showAdHorizontally];
                break;
            }
        }
    }
}

- (GDHomeViewController *)getHomeVc{
    MMDrawerController *mmdc = [GDHomeManager getRootMMDVc];
    UINavigationController *nav = (UINavigationController *)mmdc.centerViewController;
    if (nav.viewControllers&&nav.viewControllers.count>0) {
        for (UIViewController *obj in nav.viewControllers) {
            if ([obj isKindOfClass:[GDHomeViewController class]]) {
                return (GDHomeViewController *)obj;
            }
        }
    }
    return nil;
}

- (void)chooseHeadImage {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    // Create the actions.
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self showCamera];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self selectImageFromAlbum];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    

    // Add the actions.
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showQuitAlert {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"你确定要退出GoodDeed吗？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [GDHomeManager clearCache];
        GDWindow.rootViewController = [GDHomeManager getRootController:NO];
        
    }];
    [otherAction setValue:[UIColor colorWithHexString:@"#FF3B30"] forKey:@"titleTextColor"];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark 打开相机
- (void)showCamera{
    
    // 设置照片来源为相机
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 设置进入相机时使用前置或后置摄像头
    self.imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    // 展示选取照片控制器
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
    
}


#pragma mark 从相册获取图片
- (void)selectImageFromAlbum
{
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
// 完成图片的选取后调用的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // 选取完图片后跳转回原控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    // 从info中将图片取出，并加载到imageView当中
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [GDHomeManager uploadImage:image];
    //[self upload:image];
    if (self.headerView.imageBlock) {
        self.headerView.imageBlock(image);
    }
}

- (void)upload:(UIImage *)image{
    
    //请求地址
    NSMutableString *url = [[NSMutableString alloc] init];
    [url appendString:GDBaseUrl];
    [url appendString:@"/image/uploadImage"];
    
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
//    //分界线 --AaB03x
//    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
//    //结束符 AaB03x--
//    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
//
    NSMutableString *body = [[NSMutableString alloc] init];
    
    
    //[body appendFormat:@"%@\r\n",MPboundary];
    
    　　//请求参数
    // [body appendFormat:@"Content-Disposition: form-data;name=\"%@\"\r\n\r\n",@"token"];
    
    　　//参数值
    //[body appendFormat:@"%@\r\n", [UtilTool getToken]];
    
    NSData *imageData = UIImagePNGRepresentation(image);
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData;
    //将body字符串转化为UTF8格式的二进制
    myRequestData=[NSMutableData data];
    
    
   // [body appendFormat:@"%@\r\n",MPboundary];
    [body appendFormat:@"Content-Disposition: form-data; name=\"uploadFile\"; filename=\"%@\"\r\n",@"temp.png"];
    [body appendFormat:@"Content-Type: image/png\r\n\r\n"];
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    [myRequestData appendData:imageData];
    
//    //声明结束符：--AaB03x--
//    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
//    //加入结束符--AaB03x--
//    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:url]];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    //    [request setTimeoutInterval:[DataStore getHttpTimeout]];
    [request setHTTPMethod:@"POST"];
    //设置HTTPHeader中Content-Type的值
    NSString *cttype=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];    //设置HTTPHeader
    [request setValue:cttype forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%ld", [myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:myRequestData];
    NSOperationQueue *queue=[NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data, NSError *connectionError){
    NSLog(@"response = %@",response);
    NSLog(@"data = %@",data);
    NSString *urlString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"urlString = %@",urlString);
        
    UIImage *image1 = [UIImage imageWithData:data];
    NSLog(@"image = %@",image1);
        
        
        
        
}];

//        NSLog(@"response = %@",response);
//        NSLog(@"data = %@",data);
//        NSLog(@"error = %@",connectionError);
//    }];
   

}
// 取消选取调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//刷新列表
- (void)reloadTableView{
    [self.tableView reloadData];

}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
