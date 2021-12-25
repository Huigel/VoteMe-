//
//  VMPostNewVoteController.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/29.
//

#import "VMBaseViewController.h"
#import "VMPostVoteCardView.h"
#import <PhotosUI/PhotosUI.h>
#import "BRStringPickerView.h"
#import "VMNewVoteModel.h"
#import "VMPictureDetailProtocol.h"
#import "VMPictureDetailView.h"
#import "VMPictureUploadProtocal.h"
#import "VMPictureUploadManager.h"
#import "VMPictureUploadTask.h"


NS_ASSUME_NONNULL_BEGIN

@interface VMPostNewVoteController : VMBaseViewController<UITextViewDelegate, VMPictureDetailProtocol, VMPictureUploadProtocal>

@property(nonatomic, strong) UIScrollView *contentScrollView;

@property(nonatomic, strong) VMPostVoteCardView *postCardView;

@property(nonatomic, strong) UIButton *imageViewBackgroundButton;

@property(nonatomic, strong) VMLoadingView *uploadingView;

@property(nonatomic, strong) UIImage *voteDetailImage;

@property(nonatomic, strong) VMNewVoteModel *model;

@property(nonatomic, assign) bool havePicture;

@property(nonatomic, strong) NSMutableArray<VMPictureUploadTask *> *uploadTaskArray;

@end

NS_ASSUME_NONNULL_END
