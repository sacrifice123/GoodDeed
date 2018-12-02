//
//  GDUploadImageApi.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/9/19.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDUploadImageApi.h"

@interface GDUploadImageApi()
@property (nonatomic, strong) UIImage *image;
@end

@implementation GDUploadImageApi

- (id)initWithImage:(UIImage *)image {
    if (self = [super init]) {
        _image = image;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    
    return YTKRequestMethodPost;
}

- (YTKRequestSerializerType)requestSerializerType{

    return YTKRequestSerializerTypeHTTP;
}

- (NSString *)requestUrl {
    
    return @"/image/uploadImage";
}

- (AFConstructingBlock)constructingBodyBlock{
    __weak typeof(self) weakSelf = self;
    return ^(id<AFMultipartFormData> formData){
        NSData *data = UIImageJPEGRepresentation(weakSelf.image, 0.1);
        NSString *name = @"image.jpeg";
        NSString *formKey = @"image";
        NSString *type = @"image/jpeg";
        [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
    };
}

- (id)jsonValidator{
    return @{ @"imageId": [NSString class] };
}

//-
//- (NSString *)responseImageId {
//
//    NSDictionary *dict = self.responseJSONObject;
//        return dict[@"imageId"];
//}
@end
