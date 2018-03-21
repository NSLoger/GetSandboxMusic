//
//  ViewController.m
//  DemoForGetDocumentMusicMsg
//
//  Created by 王刚 on 2018/3/21.
//  Copyright © 2018年 LOVER. All rights reserved.
//

#import "ViewController.h"
#import "WGMusicMsgModel.h"
#import "WGToolsClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self methodForGettingMsg];
}

-(void)methodForGettingMsg{
    //获取到的数据格式为字典类型
    NSArray * localSongsList = [WGToolsClass getLocalMusicListMsg];
    NSLog(@"iPhone中“音乐”中的歌曲列表\n%@",localSongsList);
    
    //下面两个方法获取到的信息用Model存储，可根据WGMusicMsgModel中的相关属性获取到
    NSArray * documentSongsList = [WGToolsClass getDucumentMusicListMsg];
    NSLog(@"--------获取到的存在于沙盒中的歌曲相关信息--------\n%@",documentSongsList);
    NSArray * applicationSongsList = [WGToolsClass getApplicationMusicListMsg];
    NSLog(@"获取APP本身自带音乐相关信息\n%@",applicationSongsList);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
