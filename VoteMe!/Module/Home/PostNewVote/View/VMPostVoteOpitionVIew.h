//
//  VMPostVoteOpitionVIew.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/30.
//

#import "VMBaseView.h"
#import <PhotosUI/PhotosUI.h>
#import "VMViewControllerManager.h"
#import "VMPictureDetailView.h"
#import "VMPictureDetailProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMPostVoteOpitionVIew : VMBaseView<VMPictureDetailProtocol>

@property(nonatomic, strong) UITextView *optionContentTextView;

@property(nonatomic, strong) UIButton *addPictureButton;

@property(nonatomic, strong) UIImageView *optionHavePictureImageView;

@property(nonatomic, strong) UIImageView *optionNoPictureImageView;

@property(nonatomic, strong) UIButton *deleteOpitionButton;

@property(nonatomic, strong) UIImage *optionImage;

@property(nonatomic, assign) bool havePicture;

-(instancetype)init;

@end

NS_ASSUME_NONNULL_END
