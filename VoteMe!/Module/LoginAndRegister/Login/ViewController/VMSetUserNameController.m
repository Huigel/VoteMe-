//
//  VMSetUserNameController.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/4.
//

#import "VMSetUserNameController.h"
#import "VMMainViewController.h"

@interface VMSetUserNameController ()

@end

@implementation VMSetUserNameController

-(instancetype)initWithEmail:(NSString *)email PassWord:(NSString *)password VerificationCode:(NSString *)code{
    self = [super init];
    
    self.email = email;
    self.password = password;
    self.verificationCode = code;
    

    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    [self.view addSubview:self.declareLabel];
    [self.declareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(236 * HEIGHT_SCALE);
        //make.width.mas_equalTo(357 * WIDTH_SCALE);
        make.height.mas_equalTo(54 * HEIGHT_SCALE);
    }];
    
    [self.view addSubview:self.userNameTextField];
    [self.userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.declareLabel.mas_bottom).with.offset(47 * HEIGHT_SCALE);
        make.width.mas_equalTo(176 * WIDTH_SCALE);
        make.height.mas_equalTo(60 * HEIGHT_SCALE);
    }];
    
    [self.view addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-143 * HEIGHT_SCALE);
        make.width.mas_equalTo(157 * WIDTH_SCALE);
        make.height.mas_equalTo(40 * HEIGHT_SCALE);
    }];
}

-(void)regist{
    if([self.userNameTextField.text isEqualToString:@""]){
        [self.view makeToast:@"ID不能为空" duration:1 position:CSToastPositionCenter];
    }else{
        [VMWebManager shareInstance].delegate = self;
        [[VMWebManager shareInstance] registerWithUserEmail:self.email PassWord:self.password VerificationCode:self.verificationCode userName:self.userNameTextField.text];
    }
    

}

-(void)handleRegistWithResponse:(_Nullable id)response success:(BOOL)success{
    if(success){
        if([[response valueForKey:@"msg"] isEqualToString:@"注册成功"]){
            [[VMUserDefaultManager sharedInstance] setValue:[[response valueForKey:@"Data"] valueForKey:@"token"] forKey:@"token"];
            [[VMUserDefaultManager sharedInstance] setValue:self.email forKey:@"email"];
            [[VMUserDefaultManager sharedInstance] setValue:self.password forKey:@"password"];
            [[VMUserDefaultManager sharedInstance] setValue:self.userNameTextField.text forKey:@"userName"];
            [[VMWebManager shareInstance] resetAuth];
            
            
            UIWindow *window = [UIWindow getRootWindow];
            window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[VMMainViewController sharedInstanceWithRefreshFlag:true]];
            
            
            [[VMMainViewController sharedInstance].view makeToast:@"注册成功" duration:1 position:CSToastPositionCenter];
            
            [window makeKeyAndVisible];
            
        }else{
            if([response objectForKey:@"msg"]){
                [self.view makeToast:[response valueForKey:@"msg"] duration:1 position:CSToastPositionCenter];
            }else{
                [self.view makeToast:@"注册失败" duration:1 position:CSToastPositionCenter];
            }
        }
    }else{
        [self.view makeToast:@"注册失败" duration:1 position:CSToastPositionCenter];
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

-(UILabel *)declareLabel{
    if(!_declareLabel){
        _declareLabel = [[UILabel alloc] init];
        _declareLabel.text = @"输入你的ID\n（唯一且不可修改噢~）";
        _declareLabel.font = [UIFont systemFontOfSize:18 * WIDTH_SCALE];
        _declareLabel.numberOfLines = 2;
        _declareLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    }
    return _declareLabel;
}

-(UITextField *)userNameTextField{
    if(!_userNameTextField){
        _userNameTextField = [[UITextField alloc] init];
        _userNameTextField.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
        
        _userNameTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 22 * WIDTH_SCALE, 60 * HEIGHT_SCALE)];
        _userNameTextField.leftViewMode = UITextFieldViewModeAlways;
        
        _userNameTextField.autocapitalizationType=UITextAutocapitalizationTypeNone;
        
        NSAttributedString *placeHolder = [[NSAttributedString alloc] initWithString:@"ID" attributes:@{
            NSFontAttributeName:[UIFont systemFontOfSize:(16 * WIDTH_SCALE)],
            NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#B0B0C3"]
        }];
        _userNameTextField.attributedPlaceholder = placeHolder;
    }
    return _userNameTextField;
}

-(UIButton *)registerButton{
    if(!_registerButton){
        _registerButton = [[UIButton alloc] init];
        _registerButton.backgroundColor = [UIColor colorWithHexString:@"#DBF2FF"];
        _registerButton.layer.cornerRadius = 24 * WIDTH_SCALE;
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:16 * WIDTH_SCALE];
        [_registerButton setTitle:@"进入" forState:(UIControlStateNormal)];
        [_registerButton setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:(UIControlStateNormal)];
        [_registerButton addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

@end
