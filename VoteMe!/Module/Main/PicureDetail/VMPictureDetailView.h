//
//  VMBigPictureScrollView.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/3.
//

#import "VMBaseView.h"
#import "VMPictureDetailProtocol.h"
#import "VMViewControllerManager.h"

typedef NS_ENUM(NSInteger, VMPictureDetailType){
    VMPictureDetailUploadType,
    VMPictureDetailDownloadType
};

NS_ASSUME_NONNULL_BEGIN

@interface VMPictureDetailView : VMBaseView

@property(nonatomic, weak) id<VMPictureDetailProtocol> delegate;

@property(nonatomic, strong) UIImageView *pictureImageView;

@property(nonatomic, strong) UIButton *deletePictureButton;

@property(nonatomic, strong) UIButton *maskButton;

@property(nonatomic, assign) VMPictureDetailType type;

-(instancetype)init;

-(void)setPictureDetailType:(VMPictureDetailType)type;

-(void)configureImageSize;

-(void)showPictureDetail;

+(VMPictureDetailView *)shareInstance;

@end

NS_ASSUME_NONNULL_END
