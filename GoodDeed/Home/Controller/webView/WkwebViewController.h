//
//  WkwebViewController.h
//  WKWebViewLearn
//
//  Created by MAC on 2016/12/12.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^notiBlcok)(NSDictionary *);
@interface WkwebViewController : UIViewController

@property (copy,nonatomic) NSString *url;
@property (strong,nonatomic) NSDictionary *taskData;
    
@end
