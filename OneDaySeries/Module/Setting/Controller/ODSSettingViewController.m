//
//  ODSSettingViewController.m
//  OneDaySeries
//
//  Created by TaoXinle on 16/7/1.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSSettingViewController.h"
#import "ODSCollectionViewController.h"
#import "OSDWebViewController.h"
#import "ODSVersionViewController.h"
@interface ODSSettingViewController ()
@property (nonatomic,strong) UITableView * settingTableV;
@property (nonatomic,strong) NSArray * titleArray1;
@property (nonatomic,strong) NSArray * titleArray2;
@property (nonatomic,strong) NSArray * titleArray3;
@end

@implementation ODSSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    
    self.titleArray1 = [NSArray arrayWithObjects:@"我的收藏", nil];
    self.titleArray2 = [NSArray arrayWithObjects:@"晚安吻起源",@"版本信息",@"说点什么", nil];
    self.titleArray3 = [NSArray arrayWithObjects:@"清除缓存", nil];
    
    self.settingTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ODSScreenWidth, ODSScreenHeight) style:UITableViewStyleGrouped];
    //    self.tableview.rowHeight = 200;
    self.settingTableV.delegate = self;
    self.settingTableV.dataSource = self;
    self.settingTableV.backgroundColor = [UIColor clearColor];
    self.settingTableV.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.settingTableV];

    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section==1?3:1;
}
-(CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    static NSString *settingIdentifier = @"seetingcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:settingIdentifier];
    }
//    if (indexPath.row==0) {
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    else
//        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ODSScreenWidth-50, 50)];
    titleLabel.backgroundColor = [UIColor clearColor];
    [titleLabel setTextColor:[UIColor colorWithWhite:100/255.0f alpha:1]];
    titleLabel.font = [UIFont systemFontOfSize:15];
    [cell.contentView addSubview:titleLabel];

    switch (indexPath.section) {
        case 0:
            titleLabel.text = [self.titleArray1 objectAtIndex:indexPath.row];
            break;
        case 1:
            titleLabel.text = [self.titleArray2 objectAtIndex:indexPath.row];
            break;
        case 2:
            titleLabel.text = [self.titleArray3 objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }
    //    if (indexPath.row==1) {
    //        UISwitch * switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(ScreenWidth-20-10-53, 10, 80, 30)];
    //        [switchBtn setOn:YES];
    //        [switchBtn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    //        [cell.contentView addSubview:switchBtn];
    //    }
    if (indexPath.section==2){
        UILabel * subL = [[UILabel alloc] initWithFrame:CGRectMake(ODSScreenWidth-20-120, 0, 120, 50)];
        subL.backgroundColor = [UIColor clearColor];
        [subL setTextAlignment:NSTextAlignmentRight];
        [subL setTextColor:[UIColor colorWithWhite:180/255.0f alpha:1]];
        subL.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:subL];
        subL.text = [NSString stringWithFormat:@"%.2fM",20.f];
    }
    else
    {
        UIImageView * morev = [[UIImageView alloc] initWithFrame:CGRectMake(ODSScreenWidth-20-10, 14, 16, 22)];
        [morev setImage:[UIImage imageNamed:@"more_detail"]];
        [cell.contentView addSubview:morev];
    }
    
    return cell;
    
}

-(void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0){
        ODSCollectionViewController * collectionV = [[ODSCollectionViewController alloc] init];
        [self.navigationController pushViewController:collectionV animated:YES];
    }
    if (indexPath.section==1){
        if (indexPath.row==0) {
            OSDWebViewController * webV = [[OSDWebViewController alloc] init];
            webV.title = @"晚安吻起源";
            webV.urlStr = @"http://mp.weixin.qq.com/s?__biz=MjM5MDk5Mjc0NA==&mid=208739886&idx=1&sn=45c962dbf0c9721de0a2527efe91360b&3rd=MzA3MDU4NTYzMw==&scene=6#rd";
            [self.navigationController pushViewController:webV animated:YES];
        }
        else if (indexPath.row==1){
            ODSVersionViewController * versionV = [[ODSVersionViewController alloc] init];
            [self.navigationController pushViewController:versionV animated:YES];
        }
        else if(indexPath.row==2){
            NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/tian-tian-cheng-yu/id843601091?ls=1&mt=8"];
            if([[UIApplication sharedApplication] canOpenURL:url])
            {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
