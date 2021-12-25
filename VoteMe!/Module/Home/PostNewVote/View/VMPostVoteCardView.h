//
//  VMPostVoteCardView.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/30.
//

#import "VMBaseView.h"
#import "VMPostVoteOpitionVIew.h"



NS_ASSUME_NONNULL_BEGIN

@interface VMPostVoteCardView : VMBaseView

@property(nonatomic, strong) UIView *cardBaseView;

@property(nonatomic, strong) UIView *firstContentView;

@property(nonatomic, strong) UITextView *titleTextView;

@property(nonatomic, strong) UIView *contentTextFieldBackgroundView;

@property(nonatomic, strong) UITextView *contentTextView;


@property(nonatomic, strong) UIButton *addDetailPictureButton;

@property(nonatomic, strong) UIImageView *detailHavePictureImageView;

@property(nonatomic, strong) UIImageView *detailNoPictureImageView;


@property(nonatomic, strong) UIView *secondContentView;

@property(nonatomic, strong) NSMutableArray<VMPostVoteOpitionVIew *> *optionArray;

@property(nonatomic, strong) UIButton *addOptionButton;


@property(nonatomic, strong) UIView *thirdContentView;

@property(nonatomic, strong) UIButton *radioButton;

@property(nonatomic, strong) UIButton *deadlineButton;


@property(nonatomic, strong) UIButton *postButton;

-(instancetype)init;

@end

NS_ASSUME_NONNULL_END
