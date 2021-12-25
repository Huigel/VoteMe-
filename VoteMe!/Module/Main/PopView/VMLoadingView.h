//
//  VMLoadingView.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/24.
//

#import "VMBaseView.h"
#import "UIImage+GIF.h"
#import "SDWebImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMLoadingView : VMBaseView

@property(nonatomic, strong) UIView *labelBackgroundView;

@property(nonatomic, strong) SDAnimatedImageView *loadingGifImageView;

@property(nonatomic, strong) UILabel *declarelabel;

-(instancetype)init;


@end

NS_ASSUME_NONNULL_END
