//
//  TCBlobDownloadManager+Tools.h
//  TCBlobDownload
//
//  Created by Johnson on 5/4/16.
//  Copyright © 2016 thibaultCha. All rights reserved.
//

#import <TCBlobDownload/TCBlobDownload.h>

@interface TCBlobDownloadManager (Assit)

+ (NSDictionary *)allDownloads;
+ (void)addDownloads:(NSURL *)url filePath:(NSString *)filePath;

+ (void)removeAllDownloads;

/**检查是否正在下载或者已经下载过*/
- (BOOL)checkOperationAndFiles:(NSURL *)url downloadPath:(NSString *)downloadPath;
- (BOOL)checkOperationAndFiles:(NSURL *)url downloadPath:(NSString *)downloadPath retryDownload:(BOOL)retryDownload;

@end


@interface NSObject (Assit)

- (void)setFileWithDownloadURLString:(NSString *)URLString
                          customPath:(NSString *)customPathOrNil
                       firstResponse:(void (^)(NSURLResponse *response))firstResponseBlock
                            progress:(void (^)(uint64_t receivedLength, uint64_t totalLength, NSInteger remainingTime, float progress))progressBlock
                               error:(void (^)(NSError *error))errorBlock
                            complete:(void (^)(BOOL downloadFinished, NSString *pathToFile))completeBlock;
@end
