//
//  VMUserPageButton.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/28.
//

#import "VMBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMUserPageButton : VMBaseView

@property(nonatomic, strong) UIView *iconBaseView;

@property(nonatomic, strong) UIImageView *iconImageView;

@property(nonatomic, strong) UILabel *iconDeclareLabel;

@property(nonatomic, strong) UIButton *actionButton;



-(instancetype)initWithImageName:(NSString *)imageName labelTaxt:(NSString *)labelText;

@end

NS_ASSUME_NONNULL_END
