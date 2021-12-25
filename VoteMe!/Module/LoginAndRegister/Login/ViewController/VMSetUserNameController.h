//
//  VMSetUserNameController.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/4.
//

#import "VMBaseViewController.h"
#import "UIWindow+KeyWindow.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMSetUserNameController : VMBaseViewController

@property(nonatomic, strong) UIImageView *backgroundImageView;

@property(nonatomic, strong) UILabel *declareLabel;

@property(nonatomic, strong) UITextField *userNameTextField;

@property(nonatomic, strong) UIButton *registerButton;


@property(nonatomic, copy) NSString *email;

@property(nonatomic, copy) NSString *password;

@property(nonatomic, copy) NSString *verificationCode;

-(instancetype)initWithEmail:(NSString *)email PassWord:(NSString *)password VerificationCode:(NSString *)code;

@end

NS_ASSUME_NONNULL_END
