//
//  ViewController.m
//  RichText
//
//  Created by Tesiro on 16/10/5.
//  Copyright © 2016年 Tesiro. All rights reserved.
//

#import "ViewController.h"
#import "EmotionController.h"
#import "UITextView+Input.h"
#import "FindEmoticon.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *labelZhuanHuan;
@property (nonatomic, strong)EmotionController *emotionVC;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initEmotionController];
}
#pragma mark ---初始化emotioncontroller－－－－
- (void)initEmotionController {
    self.emotionVC = [[EmotionController alloc] initWithemotionCallBack:^(Emoticon *emotion) {
        [self.textView insertEmoticon:emotion];
    }];
    self.textView.inputView = self.emotionVC.view;
}
- (IBAction)sendItermClick:(id)sender {
    self.labelZhuanHuan.text = [self.textView getEmoticonString];
    self.labelZhuanHuan.attributedText = [[FindEmoticon shareInstance] findATTriString:self.textView.text font:[UIFont systemFontOfSize:17]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
