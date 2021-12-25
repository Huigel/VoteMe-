//
//  VMVoteDetailHostCell.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/30.
//

#import "VMBaseTableViewCell.h"
#import "VMVoteDetailOptionView.h"
#import "VMOptionSelectedProtocol.h"
#import "VMPictureDetailView.h"
#import "VMViewControllerManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMVoteDetailHostCell : VMBaseTableViewCell

@property(nonatomic, weak) UIViewController<VMOptionSelectedProtocol> *OptionDelectDelegate;

@property(nonatomic, strong) UILabel *createrNameLabel;

@property(nonatomic, strong) UILabel *deadlineLabel;

@property(nonatomic, strong) UILabel *endTimeLabel;

@property(nonatomic, strong) UIView *titleBackgroundView;

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UILabel *detailLabel;

@property(nonatomic, strong) UIImageView *detailImageView;

@property(nonatomic, strong) UILabel *voterNumberLabel;

@property(nonatomic, strong) NSMutableArray<VMVoteDetailOptionView *> *optionArray;

@property(nonatomic, strong) UIButton *submitButton;

@property(nonatomic, strong) UILabel *messageLabel;

@property(nonatomic, assign) BOOL couldVote;

-(instancetype)init;

-(instancetype)initWithCouldVoteFlag:(BOOL)flag;

@end

NS_ASSUME_NONNULL_END
