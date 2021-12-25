//
//  VMPictureUploadManager.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/22.
//

#import "AFHTTPSessionManager.h"
#import "VMAPIPath.h"
#import "VMPictureUploadProtocal.h"
#import "VMUserDefaultManager.h"
#import "VMViewControllerManager.h"
#import <UIKit/UIKit.h>
#import <Toast.h>

NS_ASSUME_NONNULL_BEGIN

@interface VMPictureUploadManager : AFHTTPSessionManager

@property(nonatomic, weak) id<VMPictureUploadProtocal> delegate;

@property(nonatomic, copy) NSString *pictureToken;

+(VMPictureUploadManager *)shareInstance;

-(void)resetPictureToken:(NSString *)token;


-(void)uploadSinglePictureWithImage:(UIImage *)image;

-(void)uploadPictureWithImage:(UIImage *)image Index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
