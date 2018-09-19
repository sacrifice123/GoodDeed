//
//  HKTextView.h
//  TestText
//
//  Created by HK on 2018/8/12.
//  Copyright © 2018 HK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdateHeightBlock) (CGSize size);
typedef void (^TextViewDidEndEdit) (NSString *text);
typedef void (^TextViewDidChanged) (NSString *text);



@interface GDTextView : UITextView 

@property (copy, nonatomic) NSString *placeholer;
@property (strong, nonatomic) UIFont *minimumFont;

@property (nonatomic) CGFloat standardHeight;
@property (copy, nonatomic) UpdateHeightBlock updateHeight;

@property (copy, nonatomic) TextViewDidEndEdit didEndEdit;
@property (copy, nonatomic) TextViewDidChanged didChanged;

@property (copy, nonatomic, readonly) NSString *gdText;


- (CGSize)textViewSize;

@end
