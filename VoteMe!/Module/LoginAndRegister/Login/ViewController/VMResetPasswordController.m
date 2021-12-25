//
//  VMResetPasswordController.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/17.
//

#import "VMResetPasswordController.h"

@interface VMResetPasswordController ()

@end

@implementation VMResetPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBarView.hidden = false;
    self.navigationBarView.backBtn.hidden = false;
    self.navigationBarView.title.text = @"重置密码";
    
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
    
    [self.view addSubview:self.emailTextField];
    [self.emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(200 * HEIGHT_SCALE);
        make.width.mas_equalTo(315 * WIDTH_SCALE);
        make.height.mas_equalTo(60 * HEIGHT_SCALE);
    }];
    
    [self.view addSubview:self.verificationCodeTextField];
    [self.verificationCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailTextField.mas_bottom).with.offset(16 * HEIGHT_SCALE);
        make.left.equalTo(self.emailTextField);
        make.width.mas_equalTo(176 * WIDTH_SCALE);
        make.height.mas_equalTo(60 * HEIGHT_SCALE);
    }];
    
    [self.view addSubview:self.sendVerificationCodeButton];
    [self.sendVerificationCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailTextField.mas_bottom).with.offset(26 * HEIGHT_SCALE);
        make.right.equalTo(self.view).with.offset(-30 * WIDTH_SCALE);
        make.width.mas_equalTo(127 * WIDTH_SCALE);
        make.height.mas_equalTo(40 * HEIGHT_SCALE);
    }];
    
    [self.view addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.verificationCodeTextField.mas_bottom).with.offset(16 * HEIGHT_SCALE);
        make.width.mas_equalTo(315 * WIDTH_SCALE);
        make.height.mas_equalTo(60 * HEIGHT_SCALE);
    }];
    
    [self.view addSubview:self.checkPasswordTextField];
    [self.checkPasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.passwordTextField.mas_bottom).with.offset(16 * HEIGHT_SCALE);
        make.width.mas_equalTo(315 * WIDTH_SCALE);
        make.height.mas_equalTo(60 * HEIGHT_SCALE);
    }];
    
    [self.view addSubview:self.resetPasswordButton];
    [self.resetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.checkPasswordTextField.mas_bottom).with.offset(80 * HEIGHT_SCALE);
        make.width.mas_equalTo(157 * WIDTH_SCALE);
        make.height.mas_equalTo(40 * HEIGHT_SCALE);
    }];
    
}


-(void)back{
    [self.navigationController popViewControllerAnimated:TRUE];
}

-(void)sendVerificationCode{
    [VMWebManager shareInstance].delegate = self;
    [[VMWebManager shareInstance] sendResetPasswordCodeWithEmail:self.emailTextField.text];
}

-(void)resetPassword{
    if([self checkInputCorrect]){
        [VMWebManager shareInstance].delegate = self;
        [[VMWebManager shareInstance] resetPasswordWithEmail:self.emailTextField.text newPassword:self.passwordTextField.text code:self.verificationCodeTextField.text];
        //[self resetPasswordSuccess];
    }
}

-(BOOL)checkInputCorrect{
    if([self.emailTextField.text isEqualToString:@""]){
        [self.view makeToast:@"邮箱不能为空" duration:1 position:CSToastPositionCenter];
        return false;
    }

    if([self.verificationCodeTextField.text isEqualToString:@""]){
        [self.view makeToast:@"验证码不能为空" duration:1 position:CSToastPositionCenter];
        return false;
    }
    
    if([self.passwordTextField.text isEqualToString:@""]){
        [self.view makeToast:@"新密码不能为空" duration:1 position:CSToastPositionCenter];
        return false;
    }
    
    if(![self.checkPasswordTextField.text isEqualToString:self.passwordTextField.text]){
        [self.view makeToast:@"确认密码与新密码不一致" duration:1 position:CSToastPositionCenter];
        return false;
    }
    
    return true;
}

-(void)resetPasswordSuccess{
    [self.view addSubview:self.resetSuccessView];
    [self.resetSuccessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


#pragma mark - web delegate
-(void)handleResetPasswordWithResponse:(_Nullable id)response success:(BOOL)success{
    
    if(success){
        if([[response valueForKey:@"code"] isEqualToString:@"43000"]){
            [self resetPasswordSuccess];
        }else{
            [self.view makeToast:[response valueForKey:@"msg"] duration:1 position:CSToastPositionCenter];
        }
    }else{
        [self.view makeToast:@"网络异常" duration:1 position:CSToastPositionCenter];
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
        
        NSAttributedString *placeHolder = [[NSAttributedString alloc] initWithString:@"新密码" attributes:@{
            NSFontAttributeName:[UIFont systemFontOfSize:(16 * WIDTH_SCALE)],
            NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#B0B0C3"]
        }];
        _passwordTextField.attributedPlaceholder = placeHolder;
    }
    return _passwordTextField;
}

-(UITextField *)checkPasswordTextField{
    if(!_checkPasswordTextField){
        _checkPasswordTextField = [[UITextField alloc] init];
        _checkPasswordTextField.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
        _checkPasswordTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 22 * WIDTH_SCALE, 60 * HEIGHT_SCALE)];
        _checkPasswordTextField.leftViewMode = UITextFieldViewModeAlways;
        _checkPasswordTextField.autocapitalizationType=UITextAutocapitalizationTypeNone;
        
        NSAttributedString *placeHolder = [[NSAttributedString alloc] initWithString:@"确认密码" attributes:@{
            NSFontAttributeName:[UIFont systemFontOfSize:(16 * WIDTH_SCALE)],
            NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#B0B0C3"]
        }];
        _checkPasswordTextField.attributedPlaceholder = placeHolder;
    }
    return _checkPasswordTextField;
}

-(UIButton *)resetPasswordButton{
    if(!_resetPasswordButton){
        _resetPasswordButton = [[UIButton alloc] init];
        _resetPasswordButton.backgroundColor = [UIColor colorWithHexString:@"#DBF2FF"];
        _resetPasswordButton.layer.cornerRadius = 18 * WIDTH_SCALE;
        
        
        [_resetPasswordButton addSubview:self.resetPasswordButtonLabel];
        [self.resetPasswordButtonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.centerX.equalTo(_resetPasswordButton);
        }];
        
        _resetPasswordButton.layer.shadowColor = [UIColor grayColor].CGColor;
        _resetPasswordButton.layer.shadowOffset = CGSizeMake(0 * WIDTH_SCALE, 2 * HEIGHT_SCALE);
        _resetPasswordButton.layer.shadowOpacity = 0.3;
        _resetPasswordButton.layer.shadowRadius = 2.5 * WIDTH_SCALE;
        
        [_resetPasswordButton addTarget:self action:@selector(resetPassword) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetPasswordButton;
}

-(UILabel *)resetPasswordButtonLabel{
    if(!_resetPasswordButtonLabel){
        _resetPasswordButtonLabel = [[UILabel alloc] init];
        _resetPasswordButtonLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _resetPasswordButtonLabel.font = [UIFont systemFontOfSize:(16 * WIDTH_SCALE)];
        _resetPasswordButtonLabel.text = @"重置";
    }
    return _resetPasswordButtonLabel;
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

-(UIView *)resetSuccessView{
    if(!_resetSuccessView){
        _resetSuccessView = [[UIView alloc] init];
        _resetSuccessView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoginPageBackground"]];
        [_resetSuccessView addSubview:backgroundImageView];
        [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_resetSuccessView);
            make.top.equalTo(_resetSuccessView).with.offset(21 * HEIGHT_SCALE);
            make.width.mas_equalTo(357 * WIDTH_SCALE);
            make.height.mas_equalTo(672 * HEIGHT_SCALE);
        }];
        
        UILabel *declareLabel = [[UILabel alloc] init];
        declareLabel.text = @"重置密码成功！";
        declareLabel.font = [UIFont boldSystemFontOfSize:18 * WIDTH_SCALE];
        declareLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        [_resetSuccessView addSubview:declareLabel];
        [declareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_resetSuccessView).with.offset(232 * HEIGHT_SCALE);
            make.centerX.equalTo(_resetSuccessView);
        }];
        
        UIImageView *successImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ResetPasswordSuccessImage"]];
        [_resetSuccessView addSubview:successImageView];
        [successImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(declareLabel).with.offset(34 * HEIGHT_SCALE);
            make.left.equalTo(_resetSuccessView).with.offset(70 * WIDTH_SCALE);
            make.width.mas_equalTo(283 * WIDTH_SCALE);
            make.height.mas_equalTo(188 * HEIGHT_SCALE);
        }];
        
        
        UIButton *returnButton = [[UIButton alloc] init];
        returnButton.backgroundColor = [UIColor colorWithHexString:@"#DBF2FF"];
        returnButton.layer.cornerRadius = 18 * WIDTH_SCALE;
        [UIView configureShadow:returnButton];
        [returnButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [_resetSuccessView addSubview:returnButton];
        [returnButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(successImageView.mas_bottom).with.offset(56 * HEIGHT_SCALE);
            make.centerX.equalTo(_resetSuccessView);
            make.width.mas_equalTo(157 * WIDTH_SCALE);
            make.height.mas_equalTo(40 * HEIGHT_SCALE);
        }];
        
        UILabel *sendButtonLabel = [[UILabel alloc] init];
        sendButtonLabel.text = @"进入使用";
        sendButtonLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        sendButtonLabel.font = [UIFont systemFontOfSize:(16 * WIDTH_SCALE)];
        [returnButton addSubview:sendButtonLabel];
        [sendButtonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.centerX.equalTo(returnButton);
        }];
        
    }
    return _resetSuccessView;
}

@end
