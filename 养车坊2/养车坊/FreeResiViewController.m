//
//  FreeResiViewController.m
//  养车坊
//
//  Created by qianfeng on 15/8/5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FreeResiViewController.h"

#define kScreenSize [UIScreen mainScreen].bounds.size

@interface FreeResiViewController ()

@end

@implementation FreeResiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor lightGrayColor];
    self.navigationItem.title=@"免责声明";
    [self creatTextView];
    
}
-(void)creatTextView {
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
     UITextView *textView =[[UITextView alloc] initWithFrame:CGRectMake(30, 100, kScreenSize.width-60, 500)];
    
    textView.backgroundColor=[UIColor clearColor];
    
    textView.text=@"   国家统计局宿迁调查队网站（上的内容，仅供您个人而非商业使用。对于内容中所含的版权和其他所有权声明，您应予以尊重并在其副本中予以保留。如果网站内容无权利声明，并不代表网站对其不享有权利，也不意味着网站不主张权利，您应根据诚信原则尊重该等内容的合法权益并进行合法使用。您不得以任何方式修改、复制、公开展示、公布或分发这些材料或者以其他方式把它们用于任何公开或商业目的。禁止以任何目的把这些材料用于其他任何网站或其他平面媒体或网络计算机环境。本站上的内容及编辑等形式均受版权法等法律保护，任何未经授权的使用都可能构成对版权、商标和其他法律权利的侵犯。如果您不接受或违反上述约定，您使用本站的授权将自动终止，同时您应立即销毁任何已下载或打印好的本站内容。\n2、信息发布本站的信息按原样提供，不附加任何形式的保证，包括适销性、适合于特定目的或不侵犯知识产权的保证。此外，也不保证本站信息的绝对准确性和绝对完整性。本站中的内容或在这些内容中介绍的信息等会随时变更，恕不另行通知。本站中的内容也可能已经过期，本站不承诺更新它们。\n3、关于用户提交材料　除个人识别信息，其他任何您发送或邮寄给本站的材料、信息或联系方式(以下统称信息)均将被视为非保密和非专有。本站将对这些信息不承担任何义务。您对本站的使用不得违背法律法规及公众道德，不得向或从本站邮寄或发送任何非法、威胁、诽谤、中伤、淫秽、色情或其他可能违法的材料。若相关人对此信息的内容及影响提出确有证据的警告或异议，本站可随时删除该等信息或无限时中止该信息的网上浏览，而不必事先取得提交者的同意，亦无义务事后通知提交者，情况严重的，本站可采取注销该用户的措施。\n4、用户交流内容本站不负监控或审查用户在本站上发送或邮寄的信息或相互之间单独交流的任何领域信息的责任，包括但不限于交谈室、公告牌或其他用户论坛以及任何交流内容。本站对有关任何这类交流的内容不承担任何责任，无论它们是否会引起诽谤、隐私、淫秽或其它方面的问题。本站保留在发现时删除包含被视为侮辱、诽谤、淫秽或其它不良内容的信息消息的权利。\n5、链接第三方网站　本站到第三方网站的链接仅作为一种方便服务提供给您。如果使用这些链接，您将离开本站。本站没有审查过任何第三方网站，对这些网站及其内容不进行控制，也不负任何责任。如果您决定访问任何与本站链接的第三方网站，其可能带来的结果和风险全部由您自己承担。\n6、责任限度本站对任何损害概不负责，无论这些损害是否由于使用、或不能使用本站的结果、与本站链接的任何网站或者任何这类网站中包含的信息所引起，也不管它们是否有保证、合同、侵权行为或任何其它法律根据以及事前已得到这类损害可能发生的忠告。如果您由于使用本站的信息而导致需要对设备或数据进行维护、修理或纠正，您应意识到须自行承担必须承担由此而造成的所有费用。本站在发生下列情况时不承担责任：信息的传输是由网络服务提供者（本站及其授权人）以外的人发起的；信息的传输、路由、提供连接及存储是通过必要的自动的技术处理过程实现的，信息未经网络服务提供者选择；除了对他人要求作出自动反应之外，网络服务提供者并没选择这些信息的提供者与接收者；网络服务提供者的系统或网络中介性或暂时性存储信息所形成的复制件，在正常情况下，没有被预定的接收者以外的人所获得，保留的时间也没有长于为预定的接收者获得信息提供传输、路由或连接所必须的合理时间；通过系统或网络传输的信息内容原封未动。\n7、一般原则　本站可能随时修改这些条款。您应经常访问本页面以了解当前的条款，因为这些条款与您密切相关。这些条款的某些条文也可能被本站中某些页面上明确指定的法律通告或条款所取代。\n8、本公告的解释权及对本网站使用的解释权归结于国际统计局宿迁调查队。";
    
    textView.textColor=[UIColor blackColor];
    textView.font =[UIFont systemFontOfSize:20];
    
    
    textView.editable=NO;
    [self.view addSubview:textView];
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
