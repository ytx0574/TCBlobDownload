//
//  TCBlobDownloadManager+Tools.m
//  TCBlobDownload
//
//  Created by Johnson on 5/4/16.
//  Copyright © 2016 thibaultCha. All rights reserved.
//

#import "TCBlobDownloadManager+Assit.h"
#import <objc/runtime.h>

#define SavePath [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:NSStringFromClass([TCBlobDownloadManager class])]


@implementation TCBlobDownloadManager (Assit)

const char AllDownloadsKey;


+ (void)addDownloads:(NSURL *)url filePath:(NSString *)filePath
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSMutableDictionary *dictionary = (id)[TCBlobDownloadManager allDownloads];
        [TCBlobDownloadManager containsURL:url] ?: [dictionary setObject:filePath forKey:url];
        
        [NSKeyedArchiver archiveRootObject:dictionary toFile:SavePath];
        
    });
    
}

+ (void)removeAllDownloads
{
    [[[self allDownloads] allValues] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[NSFileManager defaultManager] removeItemAtPath:obj error:nil];
    }];
    
    [[NSFileManager defaultManager] removeItemAtPath:SavePath error:nil];
}


+ (void)setAllDownlods:(NSDictionary *)dictionary
{
    objc_setAssociatedObject([TCBlobDownloadManager sharedInstance], &AllDownloadsKey, dictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSDictionary *)allDownloads
{
    
    NSDictionary *dictionary = objc_getAssociatedObject([TCBlobDownloadManager sharedInstance], &AllDownloadsKey);
    
    [TCBlobDownloadManager setAllDownlods:dictionary ?: [NSKeyedUnarchiver unarchiveObjectWithFile:SavePath] ?: [NSMutableDictionary dictionary]];
    
    //return new value
    return objc_getAssociatedObject([TCBlobDownloadManager sharedInstance], &AllDownloadsKey);
}

+ (BOOL)containsURL:(NSURL *)url
{
    return [[[TCBlobDownloadManager allDownloads] allKeys] containsObject:url];
}



- (BOOL)checkOperationAndFiles:(NSURL *)url downloadPath:(NSString *)downloadPath
{
    return [self checkOperationAndFiles:url downloadPath:downloadPath retryDownload:NO];
}


- (BOOL)checkOperationAndFiles:(NSURL *)url downloadPath:(NSString *)downloadPath retryDownload:(BOOL)retryDownload
{
    
    TCBlobDownloader *downloader = [[[[self valueForKey:@"operationQueue"] operations] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.downloadURL == %@", url]] firstObject];

    if (retryDownload && !downloader) {
        return YES;
    }else {
        if ([TCBlobDownloadManager containsURL:url]) {
            return NO;
        }else {
            return downloader ? NO : YES;
        }
    }
}

@end



@implementation NSObject (Assit)

- (void)setFileWithDownloadURLString:(NSString *)URLString
    customPath:(NSString *)customPathOrNil
 firstResponse:(void (^)(NSURLResponse *response))firstResponseBlock
      progress:(void (^)(uint64_t receivedLength, uint64_t totalLength, NSInteger remainingTime, float progress))progressBlock
         error:(void (^)(NSError *error))errorBlock
      complete:(void (^)(BOOL downloadFinished, NSString *pathToFile))completeBlock
{
    NSURL *url = [NSURL URLWithString:URLString ?: @""];
    if (!url)
        return;
    
    
    if ([TCBlobDownloadManager containsURL:url]) {
        progressBlock ? progressBlock(1, 1, 0, 1) : nil;
        completeBlock ? completeBlock(YES, [[TCBlobDownloadManager allDownloads] objectForKey:url]) : nil;
    }else {
        [[TCBlobDownloadManager sharedInstance] startDownloadWithURL:url customPath:nil firstResponse:firstResponseBlock progress:progressBlock error:errorBlock complete:completeBlock];
    }
}

@end