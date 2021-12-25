//
//  VMPictureDetailController.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/22.
//

#import "VMBaseViewController.h"
//未使用
typedef NS_ENUM(NSInteger, VMPictureDetailType){
    VMPictureDetailUploadType,
    VMPictureDetailDownloadType
};

NS_ASSUME_NONNULL_BEGIN

@interface VMPictureDetailController : VMBaseViewController

@property(nonatomic, strong) UIButton *deletePictureButton;

@property(nonatomic, strong) UIImageView *imageView;

@property(nonatomic, assign) VMPictureDetailType type;



@end

NS_ASSUME_NONNULL_END
