//
//  RootViewController.m
//  DKSVoiceDemo
//
//  Created by aDu on 2017/6/30.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import "RootViewController.h"
#import "SYVoicePush.h"
//#import <iflyMSC/iflyMSC.h>

@interface RootViewController ()

/**语音合成*/
//@property (nonatomic, strong) IFlySpeechSynthesizer *speech;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"语音合成";
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark ========== 开始合成 ==========
- (IBAction)clickButton:(id)sender {
    [[SYVoicePush shareVoice] speedVoiceWithTextStr:self.textView.text];
}

#pragma mark ========== 发送通知 ==========
- (IBAction)sendPush:(id)sender {
    /*
     ios8以上版本需要在appdelegate中注册申请权限 本地通知在软件杀死状态也可以接收到消息
     */
    
    // 1.创建本地通知
    UILocalNotification *localNote = [[UILocalNotification alloc] init];
    // 2.设置本地通知(发送的时间和内容是必须设置的)
    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:3.0];
    localNote.alertBody = @"吃饭了么?";
    
    /**
     其他属性: timeZone 时区
     repeatInterval 多长时间重复一次:一年,一个世纪,一天..
     region 区域 : 传入中心点和半径就可以设置一个区域 (如果进入这个区域或者出来这个区域就发出一个通知)
     regionTriggersOnce  BOOL 默认为YES, 如果进入这个区域或者出来这个区域 只会发出 一次 通知,以后就不发送了
     alertAction: 设置锁屏状态下本地通知下面的 滑动来 ...字样  默认为滑动来查看
     hasAction: alertAction的属性是否生效
     alertLaunchImage: 点击通知进入app的过程中显示图片,随便写,如果设置了(不管设置的是什么),都会加载app默认的启动图
     alertTitle: 以前项目名称所在的位置的文字: 不设置显示项目名称, 在通知内容上方
     soundName: 有通知时的音效 UILocalNotificationDefaultSoundName默认声音
     可以更改这个声音: 只要将音效导入到工程中,localNote.soundName = @"nihao.waw"
     */
    
    localNote.alertAction = @"快点啊"; // 锁屏状态下显示: 滑动来快点啊
    //    localNote.alertLaunchImage = @"123";
    localNote.alertTitle = @"喂小宝";
    localNote.soundName = UILocalNotificationDefaultSoundName;
    localNote.soundName = @"nihao.waw";
    
    /* 这里接到本地通知,badge变为5, 如果打开app,消除掉badge, 则在appdelegate中实现
     [application setApplicationIconBadgeNumber:0];
     */
    localNote.applicationIconBadgeNumber = 5;
    
    // 设置额外信息,appdelegate中收到通知,可以根据不同的通知的额外信息确定跳转到不同的界面
    localNote.userInfo = @{@"type":@1};
    
    // 3.调用通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
}

#pragma mark ========== 取消响应者 ==========
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
