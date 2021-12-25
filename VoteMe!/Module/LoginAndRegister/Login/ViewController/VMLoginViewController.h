//
//  VMLoginViewController.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/27.
//

#import "VMBaseViewController.h"
#import "UIWindow+KeyWindow.h"
#import "VMSetUserNameController.h"
#import "VMResetPasswordController.h"
#import <Toast.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, VMLoginPageState) {
    VMLoginState,
    VMRegisterState
};


@interface VMLoginViewController : VMBaseViewController

@property(nonatomic, assign) VMLoginPageState nowState;

@property(nonatomic, strong) UIImageView *backgroundImageView;

@property(nonatomic, strong) UIImageView *loginPageImageView;

@property(nonatomic, strong) UITextField *emailTextField;

@property(nonatomic, strong) UITextField *passwordTextField;

@property(nonatomic, strong) UIButton *loginButton;

@property(nonatomic, strong) UILabel *loginButtonLabel;

@property(nonatomic, strong) UILabel *declareLabel;

@property(nonatomic, strong) UIButton *changeToRegisterButton;

@property(nonatomic, strong) UIButton *forgetPasswordButton;

@property(nonatomic, strong) UITextField *verificationCodeTextField;

@property(nonatomic, strong) UIButton *sendVerificationCodeButton;



 
@end

NS_ASSUME_NONNULL_END
