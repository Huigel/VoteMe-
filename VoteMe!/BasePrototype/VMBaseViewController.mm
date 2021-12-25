//
//  CIBaseViewController.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/21.
//

#import "VMBaseViewController.h"

@interface VMBaseViewController ()

@end

@implementation VMBaseViewController

-(void)viewWillAppear:(BOOL)animated{
    //[self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.fd_prefersNavigationBarHidden = true;
    
    [self.view addSubview:self.navigationBarView];
    [self.navigationBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(88 * HEIGHT_SCALE);
    }];
    
    
    
    [self.navigationBarView.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

-(VMNavigationBar *)navigationBarView{
    if(!_navigationBarView){
        _navigationBarView = [[VMNavigationBar alloc] init];
    }
    return _navigationBarView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
