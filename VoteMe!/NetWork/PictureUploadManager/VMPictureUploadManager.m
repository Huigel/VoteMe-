//
//  VMPictureUploadManager.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/22.
//

#import "VMPictureUploadManager.h"

@implementation VMPictureUploadManager

+(VMPictureUploadManager *)shareInstance{
    static VMPictureUploadManager *shareInstance;
    static dispatch_once_t flag;
    dispatch_once(&flag, ^{
        shareInstance = [[VMPictureUploadManager alloc] init];
        shareInstance.requestSerializer = [AFJSONRequestSerializer serializer];
        //[shareInstance.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
        shareInstance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",nil];

        

        shareInstance.requestSerializer= [AFHTTPRequestSerializer serializer];

        shareInstance.responseSerializer= [AFJSONResponseSerializer serializer];
    });
    return shareInstance;
}

-(void)resetPictureToken:(NSString *)token{
    self.pictureToken = token;
}


-(void)uploadSinglePictureWithImage:(UIImage *)image{
    
    NSString *url = VMUploadPictureURL;
    
    NSData *imageData;
    NSString *fileName;
    NSString *mimeType;
    
      if (UIImagePNGRepresentation(image) != nil) {
          fileName = [NSString stringWithFormat:@"test1.png"];
          imageData = UIImagePNGRepresentation(image);
          mimeType = @"image/png";
      }else{
          fileName = [NSString stringWithFormat:@"test1.jpg"];
          imageData = UIImageJPEGRepresentation(image, 1.0);
          mimeType = @"image/jpg";
      }
    
    [self POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFormData:[self.pictureToken dataUsingEncoding:NSUTF8StringEncoding] name:@"token"];
        
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:mimeType];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([self.delegate respondsToSelector:@selector(handleSinglePictureUploadWith:success:)]){
            [self.delegate handleSinglePictureUploadWith:responseObject success:true];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if([self.delegate respondsToSelector:@selector(handleSinglePictureUploadWith:success:)]){
            [self.delegate handleSinglePictureUploadWith:nil success:false];
        }
    }];
}

-(void)uploadPictureWithImage:(UIImage *)image Index:(NSInteger)index{
    
    NSString *url = VMUploadPictureURL;
    
    NSData *imageData;
    NSString *fileName;
    NSString *mimeType;
    
    //NSString *hushstr = [image hash];
    
      if (UIImagePNGRepresentation(image) != nil) {
          fileName = [NSString stringWithFormat:@"test1.png"];
          imageData = UIImagePNGRepresentation(image);
          mimeType = @"image/png";
      }else{
          fileName = [NSString stringWithFormat:@"test1.jpg"];
          imageData = UIImageJPEGRepresentation(image, 1.0);
          mimeType = @"image/jpg";
      }
    
    [self POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFormData:[self.pictureToken dataUsingEncoding:NSUTF8StringEncoding] name:@"token"];
        
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:mimeType];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([self.delegate respondsToSelector:@selector(handlePictureUploadWith:index:success:)]){
            [self.delegate handlePictureUploadWith:responseObject index:index success:true];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if([self.delegate respondsToSelector:@selector(handlePictureUploadWith:index:success:)]){
            [self.delegate handlePictureUploadWith:nil index:index success:false];
        }
    }];
}

@end
