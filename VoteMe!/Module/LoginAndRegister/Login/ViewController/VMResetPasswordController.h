//
//  VMResetPasswordController.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/17.
//

#import "VMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMResetPasswordController : VMBaseViewController

@property(nonatomic, strong) UIImageView *backgroundImageView;

@property(nonatomic, strong) UIImageView *loginPageImageView;

@property(nonatomic, strong) UITextField *emailTextField;

@property(nonatomic, strong) UITextField *passwordTextField;

@property(nonatomic, strong) UITextField *checkPasswordTextField;

@property(nonatomic, strong) UIButton *resetPasswordButton;

@property(nonatomic, strong) UILabel *resetPasswordButtonLabel;

@property(nonatomic, strong) UITextField *verificationCodeTextField;

@property(nonatomic, strong) UIButton *sendVerificationCodeButton;

@property(nonatomic, strong) UIView *resetSuccessView;

@end 

NS_ASSUME_NONNULL_END
