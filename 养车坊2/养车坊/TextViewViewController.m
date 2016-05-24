//
//  TextViewViewController.m
//  养车坊
//
//  Created by qianfeng on 15/8/5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TextViewViewController.h"
#define kScreenSize [UIScreen mainScreen].bounds.size

@interface TextViewViewController ()

@end

@implementation TextViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor lightGrayColor];
   
    [self creatTextView];
}
-(void)creatTextView {
    
  
    
    UITextView *textView =[[UITextView alloc] initWithFrame:CGRectMake(30, 0, kScreenSize.width-60, 600)];
    textView.backgroundColor=[UIColor lightGrayColor];
   
   self.navigationItem.title=@"关于我们";
    textView.text=@"我们是一群有远大理想的有志青年。我们有梦，我们有目标。我们没有说，并不是没有。而是太远，我们真的一下子实现不了，不想说出让别人谈笑。我们是一群身兼重任的有志青年。我们有责任。我们不是富二代，我们不是高富帅，我们想拥有的都需要自己去争取，自己去拼搏。有些泪。忍住它，温暖眼眶。有些痛，自己去承担。自己跌倒，自己重新爬起来。有些路，要自己走。尽管艰苦，可我们不会轻易说放弃。我们有重任，并不是时时轻松无比，悠闲自在。我们的肩上有使命。我们需要拼搏，我们需要奋斗。我们说出的承诺，要去实现。尽管远，尽管累，不会放弃！ 不管说出的承诺还是心底深处自己对自己的承诺，我们都在默默地努力。我们都努力实现，不想让它变成空话，不想只空有承诺。我们有我们爱的人，有爱着我们的人。我们不想让爱着我们的人失望，我们不能让他们失望，因为他们爱着我们，他们支持着我们，他们相信着我们，他们为我们付出了很多！我们想给我们爱的人幸福，永远的！快乐，长久的！我们想给他们、她们一个坚实的肩膀，可以为他们遮风挡雨，可以让他们依靠。我们爱着他们，我们不能让他们伤心，我们希望我们能给他们快乐和幸福。我们要有那个能力，我们想有那个能力，我们要具备那个能力。幸福和快乐已经预定，但是需要我们亲自把它搬运回来。不管走那条路，我们需要拼搏，我们需要奋斗，我们要战斗，不会说放弃";
    
    textView.font =[UIFont systemFontOfSize:15];
    textView.editable=NO;
    [self.view addSubview:textView];
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
