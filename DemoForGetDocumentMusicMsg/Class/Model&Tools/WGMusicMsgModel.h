//
//  WGMusicMsgModel.h
//  HeadPhone
//
//  Created by 王刚 on 2018/3/20.
//  Copyright © 2018年 iOS-iMac. All rights reserved.
//

#import "BaseModel.h"
#import <MediaPlayer/MediaPlayer.h>

@interface WGMusicMsgModel : BaseModel

@property (nonatomic, strong) NSString * musicName;                         //歌名
@property (nonatomic, strong) NSString * musicDuration;                     //歌曲时长
@property (nonatomic, strong) NSString * musicPath;                         //歌曲地址
@property (nonatomic, strong) NSString * musicArtist;                       //歌手
@property (nonatomic, strong) NSString * musicAlbum;                        //歌曲唱片集
@property (nonatomic, strong) MPMediaItemArtwork * musicArtwork;            //封面缩略图
@property (nonatomic, strong) NSString * musicSize;                         //歌曲大小

@end
