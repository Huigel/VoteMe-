//
//  VMLoginViewController.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/27.
//

#import "VMLoginViewController.h"
#import "VMMainViewController.h"

@interface VMLoginViewController ()

@end

@implementation VMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBarView.hidden = true;
    
    [self configureHierachy];
}

-(void)configureHierachy{
    [self.view addSubview:self.backgroundImageView];
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(21 * HEIGHT_SCALE);
        make.width.mas_equalTo(357 * WIDTH_SCALE);
        make.height.mas_equalTo(672 * HEIGHT_SCALE);
    }];
    
    [self.view addSubview:self.loginPageImageView ];
    [self.loginPageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(126 * HEIGHT_SCALE);
        make.width.mas_equalTo(201 * WIDTH_SCALE);
        make.height.mas_equalTo(153 * HEIGHT_SCALE);
    }];
    
    [self.view addSubview:self.emailTextField];
    [self.emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.loginPageImageView.mas_bottom).with.offset(52 * HEIGHT_SCALE);
        make.width.mas_equalTo(315 * WIDTH_SCALE);
        make.height.mas_equalTo(60 * HEIGHT_SCALE);
    }];
    
    [self.view addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.emailTextField.mas_bottom).with.offset(16 * HEIGHT_SCALE);
        make.width.mas_equalTo(315 * WIDTH_SCALE);
        make.height.mas_equalTo(60 * HEIGHT_SCALE);
    }];
    
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.passwordTextField.mas_bottom).with.offset(162 * HEIGHT_SCALE);
        make.width.mas_equalTo(157 * WIDTH_SCALE);
        make.height.mas_equalTo(40 * HEIGHT_SCALE);
    }];
    
    [self.view addSubview:self.changeToRegisterButton];
    [self.changeToRegisterButton mas_makeConstraints:^(MASConstraintMaker *make) {        make.top.equalTo(self.loginButton.mas_bottom).with.offset(38 * HEIGHT_SCALE);
        make.centerX.equalTo(self.view);
        make.height.mas_offset(150 * WIDTH_SCALE);
        make.height.mas_offset(22 * HEIGHT_SCALE);
    }];
    
    [self.changeToRegisterButton addSubview:self.declareLabel];
    [self.declareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.changeToRegisterButton);
    }];

    //登录页面的控件们
    [self.view addSubview:self.forgetPasswordButton];
    [self.forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-30 * WIDTH_SCALE);
        
        make.top.equalTo(self.passwordTextField.mas_bottom).with.offset(14 * HEIGHT_SCALE);
    }];

    //注册页面的控件们
    [self.view addSubview:self.verificationCodeTextField];
    [self.verificationCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField.mas_bottom).with.offset(16 * HEIGHT_SCALE);
        make.left.equalTo(self.passwordTextField);
        make.width.mas_equalTo(176 * WIDTH_SCALE);
        make.height.mas_equalTo(60 * HEIGHT_SCALE);
    }];
    
    [self.view addSubview:self.sendVerificationCodeButton];
    [self.sendVerificationCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField.mas_bottom).with.offset(26 * HEIGHT_SCALE);
        make.right.equalTo(self.view).with.offset(-30 * WIDTH_SCALE);
        make.width.mas_equalTo(127 * WIDTH_SCALE);
        make.height.mas_equalTo(40 * HEIGHT_SCALE);
    }];
    
    if(self.nowState == VMLoginState){
        self.verificationCodeTextField.hidden = true;
        self.sendVerificationCodeButton.hidden = true;
        self.forgetPasswordButton.hidden = false;
        self.loginPageImageView.image = [UIImage imageNamed:@"LoginPageImage"];
        
        self.loginButtonLabel.text = @"登录";
        self.declareLabel.text = @"没有账户？注册";
    }
    if(self.nowState == VMRegisterState){
        self.forgetPasswordButton.hidden = true;
        self.sendVerificationCodeButton.hidden = false;
        self.verificationCodeTextField.hidden = false;
    
        self.loginPageImageView.image = [UIImage imageNamed:@"LoginPageRegisterImage"];
    
        self.loginButtonLabel.text = @"注册";
        self.declareLabel.text = @"已有帐户？登陆";
    }
    
}


-(void)login{
    if([self.emailTextField.text isEqualToString:@""]){
        [self.view makeToast:@"邮箱不能为空！" duration:1 position:CSToastPositionCenter];
        UIWindow *window = [UIWindow getRootWindow];
        window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[VMMainViewController sharedInstance]];
        [window makeKeyAndVisible];
    }else{
        if(self.nowState == VMLoginState){
            [VMWebManager shareInstance].delegate = self;
            [[VMWebManager shareInstance] loginWithUserEmail:self.emailTextField.text PassWord:self.passwordTextField.text];
        }else if (self.nowState == VMRegisterState){
            if([self.passwordTextField.text isEqualToString:@""]){
                [self.view makeToast:@"密码不能为空" duration:1 position:CSToastPositionCenter];
            }else if ([self.verificationCodeTextField.text isEqualToString:@""]){
                [self.view makeToast:@"验证不能为空" duration:1 position:CSToastPositionCenter];
            }else{
                VMSetUserNameController *vc = [[VMSetUserNameController alloc] initWithEmail:self.emailTextField.text PassWord:self.passwordTextField.text VerificationCode:self.verificationCodeTextField.text];
                [self.navigationController pushViewController:vc animated:true];
            }
        }
    }
}



-(void)sendVerificationCode{
    if([self.emailTextField.text isEqualToString:@""]){
        [self.view makeToast:@"邮箱不能为空！" duration:1 position:CSToastPositionCenter];
    }else{
        
        self.sendVerificationCodeButton.userInteractionEnabled = NO;
        [VMWebManager shareInstance].delegate = self;
        [[VMWebManager shareInstance] sendVerificationCodeWithEmail:self.emailTextField.text];
    }
}

-(void)changePageState{
    self.nowState = (self.nowState == VMLoginState ? VMRegisterState : VMLoginState);
    [self configureHierachy];
}

-(void)enterResetPassword{
    
    VMResetPasswordController *vc = [[VMResetPasswordController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}

#pragma mark - WebManager Delegate
-(void)handleLoginWithResponse:(_Nullable id)response success:(BOOL)success{
    if(success){
        if([[response valueForKey:@"code"] isEqualToString:@"41001"])
        {
            [[VMUserDefaultManager sharedInstance] setValue:[[response valueForKey:@"Data"] valueForKey:@"token"] forKey:@"token"];
            [[VMUserDefaultManager sharedInstance] setValue:self.emailTextField.text forKey:@"email"];
            [[VMUserDefaultManager sharedInstance] setValue:self.passwordTextField.text forKey:@"password"];
            [[VMWebManager shareInstance] resetAuth];
            UIWindow *window = [UIWindow getRootWindow];
            window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[VMMainViewController sharedInstanceWithRefreshFlag:true]];
            
            [[VMMainViewController sharedInstance].view makeToast:@"登录成功" duration:1 position:CSToastPositionCenter];
            [window makeKeyAndVisible];
        }else{
            if([response objectForKey:@"msg"]){
                [self.view makeToast:[response valueForKey:@"msg"] duration:1 position:CSToastPositionCenter];
            }else{
                [self.view makeToast:@"登录失败" duration:1 position:CSToastPositionCenter];
            }
        }
    }else{
        [self.view makeToast:@"登录失败,请检查网络" duration:1 position:CSToastPositionCenter];
    }
}

-(void)handleRegistNotificationSucceess:(BOOL)success{
    self.sendVerificationCodeButton.userInteractionEnabled = YES;
    
    if(success){
        [[[VMViewControllerManager sharedInstance] getNowViewController].view makeToast:@"发送成功" duration:1 position:CSToastPositionCenter];
    }else{
        [[[VMViewControllerManager sharedInstance] getNowViewController].view makeToast:@"发送失败" duration:1 position:CSToastPositionCenter];
    }
}

#pragma mark -lazy load
-(UIImageView *)backgroundImageView{
    if(!_backgroundImageView){
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.image = [UIImage imageNamed:@"LoginPageBackground"];
    }
    return _backgroundImageView;
}

-(UIImageView *)loginPageImageView{
    if(!_loginPageImageView){
        _loginPageImageView = [[UIImageView alloc] init];
        _loginPageImageView.image = [UIImage imageNamed:@"LoginPageImage"];
    }
    return _loginPageImageView;
}

-(UITextField *)emailTextField{
    if(!_emailTextField){
        _emailTextField = [[UITextField alloc] init];
        _emailTextField.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
        
        _emailTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 22 * WIDTH_SCALE, 60 * HEIGHT_SCALE)];
        _emailTextField.leftViewMode = UITextFieldViewModeAlways;
        
        _emailTextField.autocapitalizationType=UITextAutocapitalizationTypeNone;
        
        NSAttributedString *placeHolder = [[NSAttributedString alloc] initWithString:@"邮箱地址" attributes:@{
            NSFontAttributeName:[UIFont systemFontOfSize:(16 * WIDTH_SCALE)],
            NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#B0B0C3"]
        }];
        _emailTextField.attributedPlaceholder = placeHolder;
    }
    return _emailTextField;
}

-(UITextField *)passwordTextField{
    if(!_passwordTextField){
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
        _passwordTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 22 * WIDTH_SCALE, 60 * HEIGHT_SCALE)];
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        _passwordTextField.autocapitalizationType=UITextAutocapitalizationTypeNone;
        
        NSAttributedString *placeHolder = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{
            NSFontAttributeName:[UIFont systemFontOfSize:(16 * WIDTH_SCALE)],
            NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#B0B0C3"]
        }];
        _passwordTextField.attributedPlaceholder = placeHolder;
    }
    return _passwordTextField;
}

-(UIButton *)loginButton{
    if(!_loginButton){
        _loginButton = [[UIButton alloc] init];
        _loginButton.backgroundColor = [UIColor colorWithHexString:@"#DBF2FF"];
        _loginButton.layer.cornerRadius = 18 * WIDTH_SCALE;
        
        
        [_loginButton addSubview:self.loginButtonLabel];
        [self.loginButtonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.centerX.equalTo(_loginButton);
        }];
        
        _loginButton.layer.shadowColor = [UIColor grayColor].CGColor;
        _loginButton.layer.shadowOffset = CGSizeMake(0 * WIDTH_SCALE, 2 * HEIGHT_SCALE);
        _loginButton.layer.shadowOpacity = 0.3;
        _loginButton.layer.shadowRadius = 2.5 * WIDTH_SCALE;
        
        [_loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

-(UILabel *)loginButtonLabel{
    if(!_loginButtonLabel){
        _loginButtonLabel = [[UILabel alloc] init];
        _loginButtonLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _loginButtonLabel.font = [UIFont systemFontOfSize:(16 * WIDTH_SCALE)];
    }
    return _loginButtonLabel;
}

-(UILabel *)declareLabel{
    if(!_declareLabel){
        _declareLabel = [[UILabel alloc] init];
        _declareLabel.text = @"没有账户？注册";
        _declareLabel.textColor = [UIColor colorWithRed:0.322 green:0.329 blue:0.392 alpha:1];
        _declareLabel.font = [UIFont systemFontOfSize:(16 * WIDTH_SCALE)];
    }
    return _declareLabel;
}

-(UIButton *)changeToRegisterButton{
    if(!_changeToRegisterButton){
        _changeToRegisterButton = [[UIButton alloc] init];
        [_changeToRegisterButton addTarget:self action:@selector(changePageState) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeToRegisterButton;
}

-(UIButton *)forgetPasswordButton{
    if(!_forgetPasswordButton){
        _forgetPasswordButton = [[UIButton alloc] init];
        
        [_forgetPasswordButton addTarget:self action:@selector(enterResetPassword) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *forgetPasswordButtonLabel = [[UILabel alloc] init];
        forgetPasswordButtonLabel.text = @"忘记密码？";
        forgetPasswordButtonLabel.textColor = [UIColor colorWithHexString:@"#838391"];
        forgetPasswordButtonLabel.font = [UIFont systemFontOfSize:(16 * WIDTH_SCALE)];
        
        [_forgetPasswordButton addSubview:forgetPasswordButtonLabel];
        [forgetPasswordButtonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(_forgetPasswordButton);
            make.edges.equalTo(_forgetPasswordButton);
        }];
    }
    return _forgetPasswordButton;
}

-(UITextField *)verificationCodeTextField{
    if(!_verificationCodeTextField){
        _verificationCodeTextField = [[UITextField alloc] init];
        _verificationCodeTextField.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
        _verificationCodeTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12 * WIDTH_SCALE, 60 * HEIGHT_SCALE)];
        _verificationCodeTextField.leftViewMode = UITextFieldViewModeAlways;
        _verificationCodeTextField.autocapitalizationType=UITextAutocapitalizationTypeNone;
        
        NSAttributedString *placeHolder = [[NSAttributedString alloc] initWithString:@"验证码" attributes:@{
            NSFontAttributeName:[UIFont systemFontOfSize:(16 * WIDTH_SCALE)],
            NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#B0B0C3"]
        }];
        _verificationCodeTextField.attributedPlaceholder = placeHolder;
    }
    return _verificationCodeTextField;
}

-(UIButton *)sendVerificationCodeButton{
    if(!_sendVerificationCodeButton){
        _sendVerificationCodeButton = [[UIButton alloc] init];
        _sendVerificationCodeButton.backgroundColor = [UIColor colorWithHexString:@"#F8FCFF"];
        _sendVerificationCodeButton.layer.cornerRadius = 18 * WIDTH_SCALE;
        _sendVerificationCodeButton.layer.shadowColor = [UIColor grayColor].CGColor;
        _sendVerificationCodeButton.layer.shadowOffset = CGSizeMake(0 * WIDTH_SCALE, 2 * HEIGHT_SCALE);
        _sendVerificationCodeButton.layer.shadowOpacity = 0.3;
        _sendVerificationCodeButton.layer.shadowRadius = 2.5 * WIDTH_SCALE;
        
        UILabel *sendButtonLabel = [[UILabel alloc] init];
        sendButtonLabel.text = @"发送验证码";
        sendButtonLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        sendButtonLabel.font = [UIFont systemFontOfSize:(16 * WIDTH_SCALE)];
        
        [_sendVerificationCodeButton addSubview:sendButtonLabel];
        [sendButtonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.centerX.equalTo(_sendVerificationCodeButton);
        }];
        
        [_sendVerificationCodeButton addTarget:self action:@selector(sendVerificationCode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendVerificationCodeButton;
}



@end
