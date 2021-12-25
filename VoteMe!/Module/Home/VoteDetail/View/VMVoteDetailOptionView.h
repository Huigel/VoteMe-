//
//  VMVoteDetailOptionView.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/30.
//

#import "VMBaseView.h"

typedef NS_ENUM(NSInteger, VMOptionType){
    VMOptionYypeUnselected,
    VMOptionYypeSelected
};

NS_ASSUME_NONNULL_BEGIN

@interface VMVoteDetailOptionView : VMBaseView

@property(nonatomic, strong) UIView *backgroundView;

@property(nonatomic, strong) UILabel *numLabel;

@property(nonatomic, strong) UILabel *declareLabel;

@property(nonatomic, strong) UIView *rateView;

@property(nonatomic, strong) UIImageView *optionPictureImageView;

@property(nonatomic, strong) UIButton *actionButton;

@property(nonatomic, assign) VMOptionType optionType;

//-(instancetype)init;

-(instancetype)initWithType:(VMOptionType)type;

@end

NS_ASSUME_NONNULL_END
