//
//  ViewController.m
//  TCBlobDownloadExample
//
//  Created by Thibault Charbonnier on 18/04/13.
//  Copyright (c) 2013 thibaultCha. All rights reserved.
//

#import "SimpleViewController.h"
#import "MultipleViewController.h"

@implementation SimpleViewController
{
    NSArray *_array;
}

#pragma mark - Init


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.sharedDownloadManager = [TCBlobDownloadManager sharedInstance];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}


#pragma mark - Demo


- (IBAction)download:(id)sender


{
    
    NSArray *ay = @[
                    @{@"a": @"aaa"},
                    @{@"b": @"bbb"},
                    @{@"c": @"ccc"},
                    @{@"d": @"ddd"},
                    @{@"e": @"eee"},
                    ];
    
    
    NSArray *ay1 = [ay filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self == %@", @"aaa"]];
    
    
    
    
    // Delegate
    /*
    [self.sharedDownloadManager startDownloadWithURL:[NSURL URLWithString:self.urlField.text]
                                          customPath:nil
                                            delegate:self];
    */
    
    
    NSString *xx = @"http://dlsw.baidu.com/sw-search-sp/soft/67/25808/MacDict_mac_2.0.1.1461054461.dmg";
    
    // Blocks
    [self.sharedDownloadManager startDownloadWithURL:[NSURL URLWithString:xx]
                                          customPath:[NSString pathWithComponents:@[NSTemporaryDirectory(), @"example"]]
                                       firstResponse:NULL
                                            progress:^(uint64_t receivedLength, uint64_t totalLength, NSInteger remainingTime, float progress) {
                                                if (remainingTime != -1) {
                                                    [self.remainingTime setText:[NSString stringWithFormat:@"%lds", (long)remainingTime]];
                                                }
                                            }
                                               error:^(NSError *error) {
                                                   NSLog(@"%@", error);
                                               }
                                            complete:^(BOOL downloadFinished, NSString *pathToFile) {
                                                NSString *str = downloadFinished ? @"Completed" : @"Cancelled";
                                                [self.remainingTime setText:str];
                                            }];
    
    
    
//    [self.sharedDownloadManager startDownloadWithURL:[NSURL URLWithString:@"xx"]
//                                          customPath:[NSString pathWithComponents:@[NSTemporaryDirectory(), @"example"]]
//                                       firstResponse:NULL
//                                            progress:^(uint64_t receivedLength, uint64_t totalLength, NSInteger remainingTime, float progress) {
//                                                if (remainingTime != -1) {
//                                                    [self.remainingTime setText:[NSString stringWithFormat:@"%lds", (long)remainingTime]];
//                                                }
//                                            }
//                                               error:^(NSError *error) {
//                                                   NSLog(@"%@", error);
//                                               }
//                                            complete:^(BOOL downloadFinished, NSString *pathToFile) {
//                                                NSString *str = downloadFinished ? @"Completed" : @"Cancelled";
//                                                [self.remainingTime setText:str];
//                                            }];
    [self.urlField resignFirstResponder];
}


#pragma mark - TCBlobDownloaderDelegate


- (void)download:(TCBlobDownloader *)blobDownload didReceiveFirstResponse:(NSURLResponse *)response
{

}

- (void)download:(TCBlobDownloader *)blobDownload
  didReceiveData:(uint64_t)receivedLength
         onTotal:(uint64_t)totalLength
{

}

- (void)download:(TCBlobDownloader *)blobDownload didStopWithError:(NSError *)error
{

}

- (void)download:(TCBlobDownloader *)blobDownload didCancelRemovingFile:(BOOL)fileRemoved
{
    
}

- (void)download:(TCBlobDownloader *)blobDownload didFinishWithSuccess:(BOOL)downloadFinished atPath:(NSString *)pathToFile
{

}


#pragma mark - Utilities


- (void)cancelAll:(id)sender
{
    [self.sharedDownloadManager cancelAllDownloadsAndRemoveFiles:YES];
}

- (IBAction)switchToMultipleDownloads:(id)sender
{
    MultipleViewController *multipleViewController = [MultipleViewController new];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:multipleViewController];
    
    [self presentViewController:navController animated:YES completion:nil];
}

@end
