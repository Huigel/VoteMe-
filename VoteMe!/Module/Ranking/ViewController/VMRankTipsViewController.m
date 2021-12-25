//
//  VMRankTipsViewController.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/28.
//

#import "VMRankTipsViewController.h"

@interface VMRankTipsViewController ()

@end

@implementation VMRankTipsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarView.title.hidden = true;
    self.navigationBarView.backBtn.hidden = false;
    [self.navigationBarView.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [self configureHierachy];
    // Do any additional setup after loading the view.
}


-(void)configureHierachy{
    [self.view addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(100 * HEIGHT_SCALE);
        make.width.mas_equalTo(326 * WIDTH_SCALE);
        make.bottom.equalTo(self.view).with.offset(-86 * HEIGHT_SCALE);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RankTipsPageImage"]];
    [self.containerView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.containerView);
        make.top.equalTo(self.containerView).with.offset(13 * HEIGHT_SCALE);
        make.width.mas_equalTo(246 * WIDTH_SCALE);
        make.height.mas_equalTo(207 * HEIGHT_SCALE);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"科普：什么是排行榜？如何计算积分排名？";
    titleLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    titleLabel.font = [UIFont systemFontOfSize:14 * WIDTH_SCALE weight:1.2 * WIDTH_SCALE];
    [self.containerView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).with.offset(21 * WIDTH_SCALE);
        make.top.equalTo(self.containerView).with.offset(215 * HEIGHT_SCALE);
        make.width.mas_equalTo(300 * WIDTH_SCALE);
        make.height.mas_equalTo(20 * HEIGHT_SCALE);
    }];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.text = @"2021-11-24  16:38";
    timeLabel.textColor = [UIColor colorWithHexString:@"#CDD0CB"];
    timeLabel.font = [UIFont systemFontOfSize:8 * WIDTH_SCALE];
    [self.containerView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).with.offset(23 * WIDTH_SCALE);
        make.top.equalTo(self.containerView).with.offset(244 * HEIGHT_SCALE);
        make.width.mas_equalTo(200 * WIDTH_SCALE);
        make.height.mas_equalTo(11 * HEIGHT_SCALE);
    }];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.text = @"这里是科普，但是我目前懒得填内容，我画原型要吐了。这里是科普，但是我目前懒得填内容，我画原型要吐了。这里是科普，但是我目前懒得填内容，我画原型要吐了。这里是科普，但是我目前懒得填内容，我画原型要吐了。这里是科普，但是我目前懒得填内容，我画原型要吐了。\n这里是科普，但是我目前懒得填内容，我画原型要吐了。这里是科普，但是我目前懒得填内容，我画原型要吐了。这里是科普，但是我目前懒得填内容，我画原型要吐了。这里是科普，但是我目前懒得填内容，我画原型要吐了。\n这里是科普，但是我目前懒得填内容，我画原型要吐了。这里是科普，但是我目前懒得填内容，我画原型要吐了。这里是科普，但是我目前懒得填内容，我画原型要吐了。这里是科普，但是我目前懒得填内容，我画原型要吐了。这里是科普，但是我目前懒得填内容，我画原型要吐了。这里是科普，但是我目前懒得填内容，我画原型要吐了。\n这里是科普，但是我目前懒得填内容，我画原型要吐了。这里是科普，但是我目前懒得填内容，我画原型要吐了。这里是科普，但是我目前懒得填内容，我画原型要吐了。这里是科普，但是我目前懒得填内容，我画原型要吐了。这里是科普，但是我目前懒得填内容，我画原型要吐了。";
    contentLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    contentLabel.font = [UIFont systemFontOfSize:10 * WIDTH_SCALE];
    contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    contentLabel.numberOfLines = 0;
    [self.containerView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).with.offset(20 * WIDTH_SCALE);
        make.top.equalTo(self.containerView).with.offset(274 * HEIGHT_SCALE);
        make.width.mas_equalTo(285 * WIDTH_SCALE);
        make.height.mas_equalTo(320 * HEIGHT_SCALE);
    }];
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:TRUE];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - lazy load
-(UIView *)containerView{
    if(!_containerView){
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor colorWithHexString:kVMBackgroundColor];
        _containerView.layer.shadowColor = [UIColor grayColor].CGColor;
        _containerView.layer.shadowOffset = CGSizeMake(0 * WIDTH_SCALE, 2 * HEIGHT_SCALE);
        _containerView.layer.shadowOpacity = 0.4;
        _containerView.layer.shadowRadius = 3 * WIDTH_SCALE;
        _containerView.layer.cornerRadius = 10 * WIDTH_SCALE;
    }
    return _containerView;
}

@end
