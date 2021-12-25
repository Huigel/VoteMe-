//
//  VMCommentorView.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/4.
//

#import "VMBaseView.h"
#import <PhotosUI/PhotosUI.h>
#import "VMViewControllerManager.h"
#import "VMWebManager.h"
#import "VMPictureDetailView.h"
#import "VMPictureDetailProtocol.h"
#import "VMPictureUploadManager.h"
#import "VMLoadingView.h"

typedef NS_ENUM(NSInteger, VMCommentorMode) {
    VMCommentModeForVote,
    VMCommentModeForComment
};

NS_ASSUME_NONNULL_BEGIN

@interface VMCommentorView : VMBaseView<VMPictureDetailProtocol>

@property(nonatomic, strong) UITextView *inputTextView;

@property(nonatomic, strong) UIButton *addPictureButton;

@property(nonatomic, strong) UIImageView *havePictureImageView;

@property(nonatomic, strong) UIImageView *noPictureImageView;

@property(nonatomic, strong) UIImage *image;

@property(nonatomic, strong) UIButton *sendButton;

@property(nonatomic, assign) bool havePicture;

@property(nonatomic, assign) NSInteger replyTo;

@property(nonatomic, copy) NSString *replyToName;

@property(nonatomic, strong) VMLoadingView *uploadingView;

@property(nonatomic) VMCommentorMode nowMode;

-(instancetype)initWithMode:(VMCommentorMode)mode replyTo:(NSInteger)replyTo;

-(void)resetInputTextField;

@end

NS_ASSUME_NONNULL_END
