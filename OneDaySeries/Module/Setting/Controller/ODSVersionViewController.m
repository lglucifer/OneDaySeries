//
//  ODSVersionViewController.m
//  OneDaySeries
//
//  Created by TaoXinle on 16/7/1.
//  Copyright © 2016年 cn.com.uzero. All rights reserved.
//

#import "ODSVersionViewController.h"
#import <MessageUI/MessageUI.h>
@interface ODSVersionViewController ()<MFMailComposeViewControllerDelegate>
{
//    UIImageView * bgImgV;
}
@end

@implementation ODSVersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
    self.title = @"版本信息";
    

    
    UIImageView *logImageView = [[UIImageView alloc] initWithFrame:CGRectMake((ODSScreenWidth-80)/2.0f,64.f+30, 80, 80)];
    logImageView.image = [UIImage imageNamed:@"AppIcon60x60"];
    [self.view addSubview:logImageView];
    logImageView.layer.cornerRadius = 10;
    logImageView.layer.masksToBounds = YES;
    

    
    NSString *logStr = [NSString stringWithFormat:@"%@ %@",CurrentAPPName,CurrentVersion];
    UILabel *logLable = [[UILabel alloc] initWithFrame:CGRectMake((ODSScreenWidth-160)/2.0f, 44+30+80+30, 160, 30)];
    logLable.textColor = [UIColor lightGrayColor];
    logLable.font = [UIFont systemFontOfSize:16];
    logLable.backgroundColor = [UIColor clearColor];
    [logLable setTextAlignment:NSTextAlignmentCenter];
    logLable.text = logStr;
    [self.view addSubview:logLable];

    
    UIImageView *topMiddleImageView = [[UIImageView alloc] initWithFrame:CGRectMake((ODSScreenWidth-280)/2.0f,ODSScreenHeight - 230 , 280, 1)];
    topMiddleImageView.image = [UIImage imageNamed:@"secion_c_Line.png"];
    [self.view addSubview:topMiddleImageView];
    
    UIImageView *topBottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake((ODSScreenWidth-280)/2.0f,ODSScreenHeight - 180 , 280, 1)];
    topBottomImageView.image = [UIImage imageNamed:@"secion_c_Line.png"];
    [self.view addSubview:topBottomImageView];
    
    
    
    UILabel *phoneLable = [[UILabel alloc] initWithFrame:CGRectMake((ODSScreenWidth-280)/2.0f, ODSScreenHeight - 220, 100, 30)];
    phoneLable.textColor = [UIColor lightGrayColor];
    phoneLable.font = [UIFont systemFontOfSize:14];
    phoneLable.backgroundColor = [UIColor clearColor];
    phoneLable.text = @"联系邮箱";
    [self.view addSubview:phoneLable];
    
    
    UIButton *phoneNumBtn = [[UIButton alloc] initWithFrame:CGRectMake(ODSScreenWidth-(ODSScreenWidth-280)/2.0f-180, ODSScreenHeight - 220, 180, 30)];
    [phoneNumBtn setTitleColor:[UIColor colorWithRGB:0x03225C] forState:UIControlStateNormal];
    phoneNumBtn.titleLabel.font= [UIFont systemFontOfSize:14];
    phoneNumBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [phoneNumBtn setTitle:ContactMail forState:UIControlStateNormal];
    [phoneNumBtn addTarget:self action:@selector(mailClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneNumBtn];
    
    
    UILabel *bottomLable = [[UILabel alloc] initWithFrame:CGRectMake((ODSScreenWidth-260)/2, ODSScreenHeight - 150, 260, 30)];
    bottomLable.textColor = [UIColor lightGrayColor];
    bottomLable.font = [UIFont systemFontOfSize:14];
    bottomLable.backgroundColor = [UIColor clearColor];
    bottomLable.textAlignment = NSTextAlignmentCenter;
    bottomLable.text =[NSString stringWithFormat:@"版权所有:%@",CurrentAPPName];
    [self.view addSubview:bottomLable];
    
    
    UIButton * adBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [adBtn setFrame:CGRectMake((ODSScreenWidth-260)/2, ODSScreenHeight - 150+30+20, 260, 30)];
    [adBtn setBackgroundColor:[UIColor colorWithRed:0.027 green:0.58 blue:0.757 alpha:0.8]];
    [adBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:adBtn];
    adBtn.layer.cornerRadius = 5;
    adBtn.layer.masksToBounds = YES;
    [adBtn setTitle:@"检查新版本" forState:UIControlStateNormal];
    [adBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [adBtn addTarget:self action:@selector(checkNewVerison) forControlEvents:UIControlEventTouchUpInside];

    // Do any additional setup after loading the view.
}

-(void)checkNewVerison
{
    
}

- (void)mailClick
{

    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    
    if (mailClass != nil)
    {
        if ([mailClass canSendMail])
        {
            [self displayComposerSheet];
        }
        else
        {
            [self launchMailAppOnDevice];
        }
    }
    else
    {
        [self launchMailAppOnDevice];
    }
    
    
}

//可以发送邮件的话
-(void)displayComposerSheet
{
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    
    mailPicker.mailComposeDelegate = self;
    
    //设置主题
    [mailPicker setSubject: @"意见反馈"];
    
    // 添加发送者
    NSArray *toRecipients = [NSArray arrayWithObject: ContactMail];
    //NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
    //NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com", nil];
    [mailPicker setToRecipients: toRecipients];
    //[picker setCcRecipients:ccRecipients];
    //[picker setBccRecipients:bccRecipients];
    
    // 添加图片
    
    NSString *emailBody = @"意见反馈：";
    [mailPicker setMessageBody:emailBody isHTML:YES];
    
    [self presentViewController:mailPicker animated:YES completion:^{
        
    }];
}
-(void)launchMailAppOnDevice
{
    NSString *recipients = @"mailto:first@example.com&subject=my email!";
    //@"mailto:first@example.com?cc=second@example.com,third@example.com&subject=my email!";
    NSString *body = @"&body=email body!";
    
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    email = [email stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];
    
}
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //    NSString *msg;
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
        {
            [controller dismissViewControllerAnimated:YES completion:^{
                //                [hud hide:YES];
                //                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
            break;
        case MFMailComposeResultSaved:
        {
            [controller dismissViewControllerAnimated:YES completion:^{
                //                [hud hide:YES];
                //                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
            break;
        case MFMailComposeResultSent:
        {
            [controller dismissViewControllerAnimated:YES completion:^{
                //                [hud hide:YES];
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
            break;
        case MFMailComposeResultFailed:
        {
            [controller dismissViewControllerAnimated:YES completion:^{
                //                [hud hide:YES];
                //                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
            break;
        default:
            break;
    }
    
    //    [controller dismissViewControllerAnimated:YES completion:^{
    //        [hud hide:YES];
    //        [self.navigationController popViewControllerAnimated:YES];
    //    }];
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
