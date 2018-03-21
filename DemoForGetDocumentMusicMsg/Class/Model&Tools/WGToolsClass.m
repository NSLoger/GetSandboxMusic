//
//  WGToolsClass.m
//  HeadPhone
//
//  Created by 王刚 on 2018/3/14.
//  Copyright © 2018年 iOS-iMac. All rights reserved.
//

#import "WGToolsClass.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVMetadataItem.h>
#import <MediaPlayer/MediaPlayer.h>
#import "WGMusicMsgModel.h"

@implementation WGToolsClass

#define keyForSongTitle @"musicName"
#define keyForSongDuration @"musicDuration"
#define keyForSongPath @"musicPath"
#define keyForSongArtist @"musicArtist"
#define keyForSongAlbum @"musicAlbum"
#define keyForSongSize @"MusicSize"
#define keyForSongPicture @"musicPic"

+(NSArray *)getLocalMusicListMsg{
    NSMutableArray * arrResult = [[NSMutableArray alloc] init];
    //从iPod库读取音乐文件
    MPMediaQuery * mediaQuery = [[MPMediaQuery alloc] init];
    //读取文件
    MPMediaPropertyPredicate * albumNamePredicate = [MPMediaPropertyPredicate predicateWithValue:[NSNumber numberWithInt:MPMediaTypeMusic] forProperty:MPMediaItemPropertyMediaType];
    [mediaQuery addFilterPredicate:albumNamePredicate];

    NSArray * itemsFromGenericQuery = [mediaQuery items];

    for (MPMediaItem * song in itemsFromGenericQuery) {
        NSString * songTitle = [song valueForKey:MPMediaItemPropertyTitle];
        NSString * songDuration = [song valueForKey:MPMediaItemPropertyPlaybackDuration];
        NSString * songPath = [song valueForKey:MPMediaItemPropertyAssetURL];
        NSString * songArtist = [song valueForKey:MPMediaItemPropertyArtist];
        NSString * songAlbum = [song valueForKey:MPMediaItemPropertyAlbumTitle];
        //歌曲插图（如果没有插图，则返回nil）
        MPMediaItemArtwork * artwork = [song valueForProperty: MPMediaItemPropertyArtwork];

        if (songArtist == nil) {
            songArtist = @"未知歌手";
        }
        if (artwork) {
            NSLog(@"\n%@\n%@\n%@\n%@\n%@\n---------------------------",songTitle,songPath,songArtist,songAlbum,songDuration);
            NSDictionary * dict = @{keyForSongTitle:songTitle,
                                    keyForSongDuration:songDuration,
                                    keyForSongPath:songPath,
                                    keyForSongArtist:songArtist,
                                    keyForSongAlbum:songAlbum,
                                    keyForSongPicture:artwork,
                                    keyForSongSize:@""
                                    };
            [arrResult addObject:dict];
        }else{
            NSDictionary * dict = @{keyForSongTitle:songTitle,
                                    keyForSongDuration:songDuration,
                                    keyForSongPath:songPath,
                                    keyForSongArtist:songArtist,
                                    keyForSongAlbum:songAlbum,
                                    keyForSongSize:@""
                                    };
            [arrResult addObject:dict];
        }
    }
    return [arrResult copy];
}

+(NSArray *)getDucumentMusicListMsg{
    //初始化返回数组
    NSMutableArray * arrResult = [[NSMutableArray alloc] init];
    //文件管理器
    NSFileManager * fileManager = [NSFileManager defaultManager];
    //获取沙盒路径
    NSArray * documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentPath = [documentPaths objectAtIndex:0];
    //获取所有documentPath路径下的所有子文件名
    NSError * err = nil;
    NSArray * arrFilesName = [fileManager contentsOfDirectoryAtPath:documentPath error:&err];
    //遍历数组，先获取到子文件路径，再根据子文件路径获取到文件的所有信息
    for (int i = 0; i<arrFilesName.count; i++) {
        //子文件名
        NSString * subFileName = arrFilesName[i];
        //子文件路径
        NSString * subFilePath = [documentPath stringByAppendingPathComponent:subFileName];
        //首先识别文件格式，获取歌曲其他信息
        if ([subFileName containsString:@"mp3"]) {
            NSDictionary * dictMusicMsg = [self getMusicDetailMsgWithFilePath:subFilePath fileManager:fileManager];
            WGMusicMsgModel * model = [[WGMusicMsgModel alloc] initWithDict:[dictMusicMsg mutableCopy]];
            [arrResult addObject:model];
        }
    }
    return arrResult;
}

+(NSDictionary *)getMusicDetailMsgWithFilePath:(NSString *)filePath fileManager:(NSFileManager *)fileManager{
    //路径地址
    NSURL * musicURL = [NSURL fileURLWithPath:filePath];
    //根据路径地址获取AVURLAsset对象
    AVURLAsset * musicAsset = [AVURLAsset URLAssetWithURL:musicURL options:nil];
    //初始化存储音乐文件信息的字典
    NSMutableDictionary * msgInfoDict = [[NSMutableDictionary alloc] init];
    //--存储歌曲时长--
    CMTime duration = musicAsset.duration;
    float musicDurationSeconds = CMTimeGetSeconds(duration);
    int minute = (int)musicDurationSeconds/60;
    int second = (int)musicDurationSeconds%60;
    NSString * musicDuration = [NSString stringWithFormat:@"%d:%d",minute,second];
    [msgInfoDict setObject:musicDuration forKey:keyForSongDuration];
    //--存储歌曲路径--
    [msgInfoDict setObject:filePath forKey:keyForSongPath];
    //获取文件中数据格式类型
    for (NSString * format in [musicAsset availableMetadataFormats]) {
        //获取特定格式类型
        for (AVMetadataItem * metadataItem in [musicAsset metadataForFormat:format]) {
            if ([metadataItem.commonKey isEqualToString:@"artwork"]){
//                //或略图如果没有会获取不到造成崩溃
//                NSString * mime = [(NSDictionary *)metadataItem.value objectForKey:@"MIME"];
//                NSLog(@"mime: %@",mime);
//
//                [infoDict setObject:mime forKey:@"artwork"];
            }
            else if([metadataItem.commonKey isEqualToString:@"title"]){
                NSString * title = (NSString *)metadataItem.value;
                //--存储音乐名--
                [msgInfoDict setObject:title forKey:keyForSongTitle];
            }
            else if([metadataItem.commonKey isEqualToString:@"artist"]){
                NSString *artist = (NSString *)metadataItem.value;
                //--存储歌手--
                [msgInfoDict setObject:artist forKey:keyForSongArtist];
            }
            else if([metadataItem.commonKey isEqualToString:@"albumName"]){
                NSString *albumName = (NSString *)metadataItem.value;
                //--存储音乐集--
                [msgInfoDict setObject:albumName forKey:keyForSongAlbum];
            }
        }
    }
    //文件其他信息
    NSDictionary * dictItems = [fileManager attributesOfItemAtPath:filePath error:nil];
    //歌曲大小，单位bytes
    NSString * fileSize = [NSString stringWithFormat:@"%@",dictItems[@"NSFileSize"]];
    float musicSize = [fileSize intValue];
    //1G == 1000 M == 1000*1000 K == 1000*1000*1000 byte
    musicSize = musicSize / (1000*1000);
    [msgInfoDict setObject:[NSString stringWithFormat:@"%.1f",musicSize] forKey:keyForSongSize];
    //返回歌曲详情字典
    return msgInfoDict;
}

+(NSArray *)getApplicationMusicListMsg{
    NSMutableArray * arrResult = [[NSMutableArray alloc] init];
    //文件管理器
    NSFileManager * fileManager = [NSFileManager defaultManager];
    //获取音乐数组
    NSArray * musicArray = [NSBundle pathsForResourcesOfType:@"mp3" inDirectory:[[NSBundle mainBundle] resourcePath]];
    for (NSString * musicPath in musicArray) {
        NSDictionary * dictMusicMsg = [self getMusicDetailMsgWithFilePath:musicPath fileManager:fileManager];
        WGMusicMsgModel * model = [[WGMusicMsgModel alloc] initWithDict:[dictMusicMsg mutableCopy]];
        [arrResult addObject:model];
    }
    return arrResult;
}


@end
