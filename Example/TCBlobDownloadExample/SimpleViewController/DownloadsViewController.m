//
//  DownloadsViewController.m
//  TCBlobDownloadExample
//
//  Created by Johnson on 5/4/16.
//  Copyright © 2016 thibaultCha. All rights reserved.
//

#import "DownloadsViewController.h"
#import <TCBlobDownload/TCBlobDownload.h>

@interface DownloadsViewController () <UITableViewDataSource>
{
    NSArray *_array;
    __weak IBOutlet UITableView *_tableView;
}
@end

@implementation DownloadsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _array = @[
               @"http://down.kuwo.cn/mac/kwplayer_mac.dmg",
               @"http://dldir1.qq.com/music/clntupate/QQMusicForYQQ.exe",
               @"http://dldir1.qq.com/music/clntupate/mac/QQMusic3.1.2Build01.dmg",
               @"http://dldir1.qq.com/music/clntupate/ios/QQMusicIPhone5.8.1build04_yqq.ipa",
               @"http://dldir1.qq.com/music/clntupate/QQMusic.apk",
               @"http://downmini.kugou.com/kugou8046.exe",
               @"http://downmobile.kugou.com/Android/KugouPlayer/8066/KugouPlayer_219_V8.0.6.apk",
               @"http://downmobile.kugou.com/upload/ios_beta/kugou.ipa",
               @"http://downmobile.kugou.com/iPad/1100/kugouHD_1002_V1.1.0.ipa",
               @"http://download.taobaocdn.com/wireless/xiami-android-spark/latest/xiami-android-spark_701287.apk",
               @"http://res.xiami.net/download/XMusicSetup_2_0_2_1618.exe",
               @"http://dbison.alicdn.com/updates/xiami-1.3.4-1840.dmg",
               ];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xxx"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xxx"];
    }
    
    cell.textLabel.text = _array[indexPath.row];
    __weak id wself = cell;
    [cell setFileWithDownloadURLString:_array[indexPath.row] customPath:nil firstResponse:nil progress:nil error:nil complete:^(BOOL downloadFinished, NSString *pathToFile) {
        __strong UITableViewCell* cell = wself;
        cell.textLabel.text = pathToFile;
    }];
    return cell;
}
@end
