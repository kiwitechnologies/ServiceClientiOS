// Generated by Apple Swift version 2.2 (swiftlang-703.0.18.8 clang-703.0.31)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if defined(__has_feature) && __has_feature(modules)
@import CoreData;
@import Foundation;
@import Foundation.NSURLSession;
@import ObjectiveC;
#endif

#import "/Users/kiwitech/TSG-Master/ServiceClient/ServiceClient/TSGServiceClient-Bridging-Header.h"

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class NSManagedObjectContext;
@class NSSet;
@class NSEntityDescription;

SWIFT_CLASS("_TtC16TSGServiceClient3API")
@interface API : NSManagedObject
+ (NSSet * _Nonnull)allProjectAPI:(id _Nonnull)dictArray context:(NSManagedObjectContext * _Nonnull)context;
+ (id _Null_unspecified)getApiForAction:(NSString * _Nonnull)actionID;
- (nonnull instancetype)initWithEntity:(NSEntityDescription * _Nonnull)entity insertIntoManagedObjectContext:(NSManagedObjectContext * _Nullable)context OBJC_DESIGNATED_INITIALIZER;
@end

@class NSNumber;
@class Project;

@interface API (SWIFT_EXTENSION(TSGServiceClient))
@property (nonatomic, copy) NSString * _Nullable dev_baseURL;
@property (nonatomic, copy) NSString * _Nullable prod_baseURL;
@property (nonatomic, copy) NSString * _Nullable qa_baseURL;
@property (nonatomic, copy) NSString * _Nullable stage_baseURL;
@property (nonatomic, copy) NSString * _Nullable dummy_server_URL;
@property (nonatomic, strong) NSNumber * _Nullable actionType;
@property (nonatomic, copy) NSString * _Nullable actionName;
@property (nonatomic, copy) NSString * _Nullable actionID;
@property (nonatomic, strong) NSNumber * _Nullable params_parameters;
@property (nonatomic, strong) Project * _Nullable project;
@property (nonatomic, strong) NSSet * _Nullable parameters;
@property (nonatomic, strong) NSSet * _Nullable headers;
@property (nonatomic, strong) NSSet * _Nullable queryParameters;
@end


SWIFT_CLASS("_TtC16TSGServiceClient3Key")
@interface Key : NSManagedObject
+ (NSSet * _Nonnull)allParameters:(id _Null_unspecified)arrayDict context:(NSManagedObjectContext * _Nonnull)context;
+ (NSSet * _Nonnull)allQueryParams:(id _Null_unspecified)arrQueryParams context:(NSManagedObjectContext * _Nonnull)context;
+ (NSSet * _Nonnull)allHeaders:(id _Null_unspecified)arrHeaders context:(NSManagedObjectContext * _Nonnull)context;
- (nonnull instancetype)initWithEntity:(NSEntityDescription * _Nonnull)entity insertIntoManagedObjectContext:(NSManagedObjectContext * _Nullable)context OBJC_DESIGNATED_INITIALIZER;
@end


@interface Key (SWIFT_EXTENSION(TSGServiceClient))
@property (nonatomic, strong) NSNumber * _Nullable format;
@property (nonatomic, strong) NSNumber * _Nullable minimumLength;
@property (nonatomic, strong) NSNumber * _Nullable maximumLength;
@property (nonatomic, strong) NSNumber * _Nullable size;
@property (nonatomic, strong) NSNumber * _Nullable dataType;
@property (nonatomic, strong) NSNumber * _Nullable required;
@property (nonatomic, copy) NSString * _Nullable keyName;
@property (nonatomic, copy) NSString * _Nullable keyValues;
@property (nonatomic, strong) API * _Nullable parameterAPI;
@property (nonatomic, strong) API * _Nullable headerAPI;
@property (nonatomic, strong) API * _Nullable queriesAPI;
@end


@interface NSURL (SWIFT_EXTENSION(TSGServiceClient))
@property (nonatomic, readonly, copy) NSString * _Nonnull URLString;
@end


@interface NSURLComponents (SWIFT_EXTENSION(TSGServiceClient))
@property (nonatomic, readonly, copy) NSString * _Nonnull URLString;
@end

@class NSMutableURLRequest;

@interface NSURLRequest (SWIFT_EXTENSION(TSGServiceClient))
@property (nonatomic, readonly, strong) NSMutableURLRequest * _Nonnull URLRequest;
@end


@interface NSURLRequest (SWIFT_EXTENSION(TSGServiceClient))
@property (nonatomic, readonly, copy) NSString * _Nonnull URLString;
@end


@interface NSURLSession (SWIFT_EXTENSION(TSGServiceClient))
@end

@class NSMutableDictionary;

SWIFT_CLASS("_TtC16TSGServiceClient7Project")
@interface Project : NSManagedObject
+ (void)saveProjectInfo:(NSMutableDictionary * _Nonnull)dictionary;
+ (BOOL)checkIfProjectIdExist:(NSString * _Nonnull)actionName;
+ (void)deleteProject;
+ (id _Null_unspecified)getProjectDetail:(NSString * _Nullable)projectID;
- (nonnull instancetype)initWithEntity:(NSEntityDescription * _Nonnull)entity insertIntoManagedObjectContext:(NSManagedObjectContext * _Nullable)context OBJC_DESIGNATED_INITIALIZER;
@end

@class NSDate;

@interface Project (SWIFT_EXTENSION(TSGServiceClient))
@property (nonatomic, copy) NSString * _Nullable projectID;
@property (nonatomic, strong) NSDate * _Nullable lastmodifiedDate;
@property (nonatomic, strong) NSSet * _Nullable requiredAPI;
@property (nonatomic, copy) NSString * _Nullable versionNumber;
@property (nonatomic, copy) NSString * _Nullable apiVersion;
@end

@class NSDictionary;

SWIFT_CLASS("_TtC16TSGServiceClient12RequestModel")
@interface RequestModel : NSObject
@property (nonatomic, copy) NSString * _Null_unspecified url;
@property (nonatomic, strong) NSDictionary * _Nullable param;
@property (nonatomic) BOOL isRunning;
@property (nonatomic, copy) NSString * _Null_unspecified apiTag;
@end

@class NSURLSessionTask;
@class TaskDelegate;
@class NSError;
@class NSURLAuthenticationChallenge;
@class NSURLCredential;
@class NSHTTPURLResponse;
@class NSInputStream;
@class NSURLSessionDataTask;
@class NSURLResponse;
@class NSURLSessionDownloadTask;
@class NSData;
@class NSCachedURLResponse;


/// Responsible for handling all delegate callbacks for the underlying session.
SWIFT_CLASS("_TtCC16TSGServiceClient7Manager15SessionDelegate")
@interface SessionDelegate : NSObject <NSURLSessionTaskDelegate, NSURLSessionDelegate, NSURLSessionDataDelegate, NSURLSessionDownloadDelegate>
- (TaskDelegate * _Nullable)objectForKeyedSubscript:(NSURLSessionTask * _Nonnull)task;
- (void)setObject:(TaskDelegate * _Nullable)newValue forKeyedSubscript:(NSURLSessionTask * _Nonnull)task;

/// Initializes the SessionDelegate instance.
///
/// \returns  The new <code>SessionDelegate
/// </code> instance.
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;

/// Overrides default behavior for NSURLSessionDelegate method URLSession:didBecomeInvalidWithError:.
@property (nonatomic, copy) void (^ _Nullable sessionDidBecomeInvalidWithError)(NSURLSession * _Nonnull, NSError * _Nullable);

/// Overrides all behavior for NSURLSessionDelegate method URLSession:didReceiveChallenge:completionHandler: and requires the caller to call the completionHandler.
@property (nonatomic, copy) void (^ _Nullable sessionDidReceiveChallengeWithCompletion)(NSURLSession * _Nonnull, NSURLAuthenticationChallenge * _Nonnull, void (^ _Nonnull)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable));

/// Overrides default behavior for NSURLSessionDelegate method URLSessionDidFinishEventsForBackgroundURLSession:.
@property (nonatomic, copy) void (^ _Nullable sessionDidFinishEventsForBackgroundURLSession)(NSURLSession * _Nonnull);

/// Tells the delegate that the session has been invalidated.
///
/// \param session The session object that was invalidated.
///
/// \param error The error that caused invalidation, or nil if the invalidation was explicit.
- (void)URLSession:(NSURLSession * _Nonnull)session didBecomeInvalidWithError:(NSError * _Nullable)error;

/// Requests credentials from the delegate in response to a session-level authentication request from the remote server.
///
/// \param session The session containing the task that requested authentication.
///
/// \param challenge An object that contains the request for authentication.
///
/// \param completionHandler A handler that your delegate method must call providing the disposition and credential.
- (void)URLSession:(NSURLSession * _Nonnull)session didReceiveChallenge:(NSURLAuthenticationChallenge * _Nonnull)challenge completionHandler:(void (^ _Nonnull)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler;

/// Tells the delegate that all messages enqueued for a session have been delivered.
///
/// \param session The session that no longer has any outstanding requests.
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession * _Nonnull)session;

/// Overrides default behavior for NSURLSessionTaskDelegate method URLSession:task:willPerformHTTPRedirection:newRequest:completionHandler:.
@property (nonatomic, copy) NSURLRequest * _Nullable (^ _Nullable taskWillPerformHTTPRedirection)(NSURLSession * _Nonnull, NSURLSessionTask * _Nonnull, NSHTTPURLResponse * _Nonnull, NSURLRequest * _Nonnull);

/// Overrides all behavior for NSURLSessionTaskDelegate method URLSession:task:willPerformHTTPRedirection:newRequest:completionHandler: and requires the caller to call the completionHandler.
@property (nonatomic, copy) void (^ _Nullable taskWillPerformHTTPRedirectionWithCompletion)(NSURLSession * _Nonnull, NSURLSessionTask * _Nonnull, NSHTTPURLResponse * _Nonnull, NSURLRequest * _Nonnull, void (^ _Nonnull)(NSURLRequest * _Nullable));

/// Overrides all behavior for NSURLSessionTaskDelegate method URLSession:task:didReceiveChallenge:completionHandler: and requires the caller to call the completionHandler.
@property (nonatomic, copy) void (^ _Nullable taskDidReceiveChallengeWithCompletion)(NSURLSession * _Nonnull, NSURLSessionTask * _Nonnull, NSURLAuthenticationChallenge * _Nonnull, void (^ _Nonnull)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable));

/// Overrides default behavior for NSURLSessionTaskDelegate method URLSession:session:task:needNewBodyStream:.
@property (nonatomic, copy) NSInputStream * _Nullable (^ _Nullable taskNeedNewBodyStream)(NSURLSession * _Nonnull, NSURLSessionTask * _Nonnull);

/// Overrides all behavior for NSURLSessionTaskDelegate method URLSession:session:task:needNewBodyStream: and requires the caller to call the completionHandler.
@property (nonatomic, copy) void (^ _Nullable taskNeedNewBodyStreamWithCompletion)(NSURLSession * _Nonnull, NSURLSessionTask * _Nonnull, void (^ _Nonnull)(NSInputStream * _Nullable));

/// Overrides default behavior for NSURLSessionTaskDelegate method URLSession:task:didSendBodyData:totalBytesSent:totalBytesExpectedToSend:.
@property (nonatomic, copy) void (^ _Nullable taskDidSendBodyData)(NSURLSession * _Nonnull, NSURLSessionTask * _Nonnull, int64_t, int64_t, int64_t);

/// Overrides default behavior for NSURLSessionTaskDelegate method URLSession:task:didCompleteWithError:.
@property (nonatomic, copy) void (^ _Nullable taskDidComplete)(NSURLSession * _Nonnull, NSURLSessionTask * _Nonnull, NSError * _Nullable);

/// Tells the delegate that the remote server requested an HTTP redirect.
///
/// \param session The session containing the task whose request resulted in a redirect.
///
/// \param task The task whose request resulted in a redirect.
///
/// \param response An object containing the server’s response to the original request.
///
/// \param request A URL request object filled out with the new location.
///
/// \param completionHandler A closure that your handler should call with either the value of the request
/// parameter, a modified URL request object, or NULL to refuse the redirect and
/// return the body of the redirect response.
- (void)URLSession:(NSURLSession * _Nonnull)session task:(NSURLSessionTask * _Nonnull)task willPerformHTTPRedirection:(NSHTTPURLResponse * _Nonnull)response newRequest:(NSURLRequest * _Nonnull)request completionHandler:(void (^ _Nonnull)(NSURLRequest * _Nullable))completionHandler;

/// Requests credentials from the delegate in response to an authentication request from the remote server.
///
/// \param session The session containing the task whose request requires authentication.
///
/// \param task The task whose request requires authentication.
///
/// \param challenge An object that contains the request for authentication.
///
/// \param completionHandler A handler that your delegate method must call providing the disposition and credential.
- (void)URLSession:(NSURLSession * _Nonnull)session task:(NSURLSessionTask * _Nonnull)task didReceiveChallenge:(NSURLAuthenticationChallenge * _Nonnull)challenge completionHandler:(void (^ _Nonnull)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler;

/// Tells the delegate when a task requires a new request body stream to send to the remote server.
///
/// \param session The session containing the task that needs a new body stream.
///
/// \param task The task that needs a new body stream.
///
/// \param completionHandler A completion handler that your delegate method should call with the new body stream.
- (void)URLSession:(NSURLSession * _Nonnull)session task:(NSURLSessionTask * _Nonnull)task needNewBodyStream:(void (^ _Nonnull)(NSInputStream * _Nullable))completionHandler;

/// Periodically informs the delegate of the progress of sending body content to the server.
///
/// \param session The session containing the data task.
///
/// \param task The data task.
///
/// \param bytesSent The number of bytes sent since the last time this delegate method was called.
///
/// \param totalBytesSent The total number of bytes sent so far.
///
/// \param totalBytesExpectedToSend The expected length of the body data.
- (void)URLSession:(NSURLSession * _Nonnull)session task:(NSURLSessionTask * _Nonnull)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend;

/// Tells the delegate that the task finished transferring data.
///
/// \param session The session containing the task whose request finished transferring data.
///
/// \param task The task whose request finished transferring data.
///
/// \param error If an error occurred, an error object indicating how the transfer failed, otherwise nil.
- (void)URLSession:(NSURLSession * _Nonnull)session task:(NSURLSessionTask * _Nonnull)task didCompleteWithError:(NSError * _Nullable)error;

/// Overrides default behavior for NSURLSessionDataDelegate method URLSession:dataTask:didReceiveResponse:completionHandler:.
@property (nonatomic, copy) NSURLSessionResponseDisposition (^ _Nullable dataTaskDidReceiveResponse)(NSURLSession * _Nonnull, NSURLSessionDataTask * _Nonnull, NSURLResponse * _Nonnull);

/// Overrides all behavior for NSURLSessionDataDelegate method URLSession:dataTask:didReceiveResponse:completionHandler: and requires caller to call the completionHandler.
@property (nonatomic, copy) void (^ _Nullable dataTaskDidReceiveResponseWithCompletion)(NSURLSession * _Nonnull, NSURLSessionDataTask * _Nonnull, NSURLResponse * _Nonnull, void (^ _Nonnull)(NSURLSessionResponseDisposition));

/// Overrides default behavior for NSURLSessionDataDelegate method URLSession:dataTask:didBecomeDownloadTask:.
@property (nonatomic, copy) void (^ _Nullable dataTaskDidBecomeDownloadTask)(NSURLSession * _Nonnull, NSURLSessionDataTask * _Nonnull, NSURLSessionDownloadTask * _Nonnull);

/// Overrides default behavior for NSURLSessionDataDelegate method URLSession:dataTask:didReceiveData:.
@property (nonatomic, copy) void (^ _Nullable dataTaskDidReceiveData)(NSURLSession * _Nonnull, NSURLSessionDataTask * _Nonnull, NSData * _Nonnull);

/// Overrides default behavior for NSURLSessionDataDelegate method URLSession:dataTask:willCacheResponse:completionHandler:.
@property (nonatomic, copy) NSCachedURLResponse * _Nullable (^ _Nullable dataTaskWillCacheResponse)(NSURLSession * _Nonnull, NSURLSessionDataTask * _Nonnull, NSCachedURLResponse * _Nonnull);

/// Overrides all behavior for NSURLSessionDataDelegate method URLSession:dataTask:willCacheResponse:completionHandler: and requires caller to call the completionHandler.
@property (nonatomic, copy) void (^ _Nullable dataTaskWillCacheResponseWithCompletion)(NSURLSession * _Nonnull, NSURLSessionDataTask * _Nonnull, NSCachedURLResponse * _Nonnull, void (^ _Nonnull)(NSCachedURLResponse * _Nullable));

/// Tells the delegate that the data task received the initial reply (headers) from the server.
///
/// \param session The session containing the data task that received an initial reply.
///
/// \param dataTask The data task that received an initial reply.
///
/// \param response A URL response object populated with headers.
///
/// \param completionHandler A completion handler that your code calls to continue the transfer, passing a
/// constant to indicate whether the transfer should continue as a data task or
/// should become a download task.
- (void)URLSession:(NSURLSession * _Nonnull)session dataTask:(NSURLSessionDataTask * _Nonnull)dataTask didReceiveResponse:(NSURLResponse * _Nonnull)response completionHandler:(void (^ _Nonnull)(NSURLSessionResponseDisposition))completionHandler;

/// Tells the delegate that the data task was changed to a download task.
///
/// \param session The session containing the task that was replaced by a download task.
///
/// \param dataTask The data task that was replaced by a download task.
///
/// \param downloadTask The new download task that replaced the data task.
- (void)URLSession:(NSURLSession * _Nonnull)session dataTask:(NSURLSessionDataTask * _Nonnull)dataTask didBecomeDownloadTask:(NSURLSessionDownloadTask * _Nonnull)downloadTask;

/// Tells the delegate that the data task has received some of the expected data.
///
/// \param session The session containing the data task that provided data.
///
/// \param dataTask The data task that provided data.
///
/// \param data A data object containing the transferred data.
- (void)URLSession:(NSURLSession * _Nonnull)session dataTask:(NSURLSessionDataTask * _Nonnull)dataTask didReceiveData:(NSData * _Nonnull)data;

/// Asks the delegate whether the data (or upload) task should store the response in the cache.
///
/// \param session The session containing the data (or upload) task.
///
/// \param dataTask The data (or upload) task.
///
/// \param proposedResponse The default caching behavior. This behavior is determined based on the current
/// caching policy and the values of certain received headers, such as the Pragma
/// and Cache-Control headers.
///
/// \param completionHandler A block that your handler must call, providing either the original proposed
/// response, a modified version of that response, or NULL to prevent caching the
/// response. If your delegate implements this method, it must call this completion
/// handler; otherwise, your app leaks memory.
- (void)URLSession:(NSURLSession * _Nonnull)session dataTask:(NSURLSessionDataTask * _Nonnull)dataTask willCacheResponse:(NSCachedURLResponse * _Nonnull)proposedResponse completionHandler:(void (^ _Nonnull)(NSCachedURLResponse * _Nullable))completionHandler;

/// Overrides default behavior for NSURLSessionDownloadDelegate method URLSession:downloadTask:didFinishDownloadingToURL:.
@property (nonatomic, copy) void (^ _Nullable downloadTaskDidFinishDownloadingToURL)(NSURLSession * _Nonnull, NSURLSessionDownloadTask * _Nonnull, NSURL * _Nonnull);

/// Overrides default behavior for NSURLSessionDownloadDelegate method URLSession:downloadTask:didWriteData:totalBytesWritten:totalBytesExpectedToWrite:.
@property (nonatomic, copy) void (^ _Nullable downloadTaskDidWriteData)(NSURLSession * _Nonnull, NSURLSessionDownloadTask * _Nonnull, int64_t, int64_t, int64_t);

/// Overrides default behavior for NSURLSessionDownloadDelegate method URLSession:downloadTask:didResumeAtOffset:expectedTotalBytes:.
@property (nonatomic, copy) void (^ _Nullable downloadTaskDidResumeAtOffset)(NSURLSession * _Nonnull, NSURLSessionDownloadTask * _Nonnull, int64_t, int64_t);

/// Tells the delegate that a download task has finished downloading.
///
/// \param session The session containing the download task that finished.
///
/// \param downloadTask The download task that finished.
///
/// \param location A file URL for the temporary file. Because the file is temporary, you must either
/// open the file for reading or move it to a permanent location in your app’s sandbox
/// container directory before returning from this delegate method.
- (void)URLSession:(NSURLSession * _Nonnull)session downloadTask:(NSURLSessionDownloadTask * _Nonnull)downloadTask didFinishDownloadingToURL:(NSURL * _Nonnull)location;

/// Periodically informs the delegate about the download’s progress.
///
/// \param session The session containing the download task.
///
/// \param downloadTask The download task.
///
/// \param bytesWritten The number of bytes transferred since the last time this delegate
/// method was called.
///
/// \param totalBytesWritten The total number of bytes transferred so far.
///
/// \param totalBytesExpectedToWrite The expected length of the file, as provided by the Content-Length
/// header. If this header was not provided, the value is
/// <code>NSURLSessionTransferSizeUnknown
/// </code>.
- (void)URLSession:(NSURLSession * _Nonnull)session downloadTask:(NSURLSessionDownloadTask * _Nonnull)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite;

/// Tells the delegate that the download task has resumed downloading.
///
/// \param session The session containing the download task that finished.
///
/// \param downloadTask The download task that resumed. See explanation in the discussion.
///
/// \param fileOffset If the file's cache policy or last modified date prevents reuse of the
/// existing content, then this value is zero. Otherwise, this value is an
/// integer representing the number of bytes on disk that do not need to be
/// retrieved again.
///
/// \param expectedTotalBytes The expected length of the file, as provided by the Content-Length header.
/// If this header was not provided, the value is NSURLSessionTransferSizeUnknown.
- (void)URLSession:(NSURLSession * _Nonnull)session downloadTask:(NSURLSessionDownloadTask * _Nonnull)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes;
- (BOOL)respondsToSelector:(SEL _Null_unspecified)selector;
@end

@class NSURLSessionStreamTask;
@class NSOutputStream;

@interface SessionDelegate (SWIFT_EXTENSION(TSGServiceClient)) <NSURLSessionStreamDelegate>

/// Overrides default behavior for NSURLSessionStreamDelegate method URLSession:readClosedForStreamTask:.
@property (nonatomic, copy) void (^ _Nullable streamTaskReadClosed)(NSURLSession * _Nonnull, NSURLSessionStreamTask * _Nonnull);

/// Overrides default behavior for NSURLSessionStreamDelegate method URLSession:writeClosedForStreamTask:.
@property (nonatomic, copy) void (^ _Nullable streamTaskWriteClosed)(NSURLSession * _Nonnull, NSURLSessionStreamTask * _Nonnull);

/// Overrides default behavior for NSURLSessionStreamDelegate method URLSession:betterRouteDiscoveredForStreamTask:.
@property (nonatomic, copy) void (^ _Nullable streamTaskBetterRouteDiscovered)(NSURLSession * _Nonnull, NSURLSessionStreamTask * _Nonnull);

/// Overrides default behavior for NSURLSessionStreamDelegate method URLSession:streamTask:didBecomeInputStream:outputStream:.
@property (nonatomic, copy) void (^ _Nullable streamTaskDidBecomeInputStream)(NSURLSession * _Nonnull, NSURLSessionStreamTask * _Nonnull, NSInputStream * _Nonnull, NSOutputStream * _Nonnull);

/// Tells the delegate that the read side of the connection has been closed.
///
/// \param session The session.
///
/// \param streamTask The stream task.
- (void)URLSession:(NSURLSession * _Nonnull)session readClosedForStreamTask:(NSURLSessionStreamTask * _Nonnull)streamTask;

/// Tells the delegate that the write side of the connection has been closed.
///
/// \param session The session.
///
/// \param streamTask The stream task.
- (void)URLSession:(NSURLSession * _Nonnull)session writeClosedForStreamTask:(NSURLSessionStreamTask * _Nonnull)streamTask;

/// Tells the delegate that the system has determined that a better route to the host is available.
///
/// \param session The session.
///
/// \param streamTask The stream task.
- (void)URLSession:(NSURLSession * _Nonnull)session betterRouteDiscoveredForStreamTask:(NSURLSessionStreamTask * _Nonnull)streamTask;

/// Tells the delegate that the stream task has been completed and provides the unopened stream objects.
///
/// \param session The session.
///
/// \param streamTask The stream task.
///
/// \param inputStream The new input stream.
///
/// \param outputStream The new output stream.
- (void)URLSession:(NSURLSession * _Nonnull)session streamTask:(NSURLSessionStreamTask * _Nonnull)streamTask didBecomeInputStream:(NSInputStream * _Nonnull)inputStream outputStream:(NSOutputStream * _Nonnull)outputStream;
@end

@class TSGErrorValuesHolder;
@class JSONModelError;
@class NSCoder;

SWIFT_CLASS("_TtC16TSGServiceClient15TSGErrorManager")
@interface TSGErrorManager : JSONModel
@property (nonatomic, strong) TSGErrorValuesHolder * _Nonnull parameter;
@property (nonatomic, strong) TSGErrorValuesHolder * _Nonnull header;
@property (nonatomic, strong) TSGErrorValuesHolder * _Nonnull queryParameter;
@property (nonatomic, strong) NSMutableDictionary * _Nonnull missingAction;
- (void)missingactionKeyMessages:(NSString * _Nonnull)keyName errorMsg:(NSString * _Nonnull)errorMsg;
- (NSString * _Nonnull)mystring;
- (null_unspecified instancetype)initWithString:(NSString * _Null_unspecified)string error:(JSONModelError * _Nullable * _Null_unspecified)err OBJC_DESIGNATED_INITIALIZER;
- (null_unspecified instancetype)initWithString:(NSString * _Null_unspecified)string usingEncoding:(NSUInteger)encoding error:(JSONModelError * _Nullable * _Null_unspecified)err OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithDictionary:(NSDictionary * _Null_unspecified)dict error:(NSError * _Nullable * _Null_unspecified)error OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithData:(NSData * _Null_unspecified)data error:(NSError * _Nullable * _Null_unspecified)error OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC16TSGServiceClient20TSGErrorValuesHolder")
@interface TSGErrorValuesHolder : JSONModel
@property (nonatomic, strong) NSMutableDictionary * _Nonnull missingKey;
@property (nonatomic, strong) NSMutableDictionary * _Nonnull invalidKey;
- (void)missingErrorMessages:(NSString * _Nonnull)keyName errorMsg:(NSString * _Nonnull)errorMsg;
- (void)invalidErrorMessages:(NSString * _Nonnull)keyName errorMsg:(NSString * _Nonnull)errorMsg;
- (null_unspecified instancetype)initWithString:(NSString * _Null_unspecified)string error:(JSONModelError * _Nullable * _Null_unspecified)err OBJC_DESIGNATED_INITIALIZER;
- (null_unspecified instancetype)initWithString:(NSString * _Null_unspecified)string usingEncoding:(NSUInteger)encoding error:(JSONModelError * _Nullable * _Null_unspecified)err OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithDictionary:(NSDictionary * _Null_unspecified)dict error:(NSError * _Nullable * _Null_unspecified)error OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithData:(NSData * _Null_unspecified)data error:(NSError * _Nullable * _Null_unspecified)error OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class NSMutableArray;

SWIFT_CLASS("_TtC16TSGServiceClient9TSGHelper")
@interface TSGHelper : NSObject
@property (nonatomic, copy) NSString * _Nullable appVersion;
@property (nonatomic, strong) Project * _Nullable projectOBJ;
@property (nonatomic, strong) NSMutableDictionary * _Null_unspecified apiHeaderDict;
@property (nonatomic, readonly, strong) NSMutableDictionary * _Nonnull mutRequestDict;
@property (nonatomic, strong) NSMutableArray * _Nonnull serialDownloadRequest;
+ (TSGHelper * _Nonnull)sharedInstance;
@property (nonatomic) NSInteger serviceCount;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (void)setDefaultHeader;
+ (void)setBaseURL:(NSString * _Nonnull)url;
+ (void)setCustomHeader:(NSDictionary * _Nonnull)dict;
+ (void)removeCustomHeader;
@property (nonatomic, copy) NSString * _Null_unspecified pid;
@property (nonatomic, copy) NSString * _Null_unspecified baseUrl;
@property (nonatomic, copy) NSString * _Null_unspecified action;
@property (nonatomic, copy) NSString * _Null_unspecified apiName;
- (void)saveProjectID:(NSMutableDictionary * _Nonnull)dict;
- (void)getAPIVersion:(void (^ _Nonnull)(NSDictionary * _Nonnull dic))sucess failure:(void (^ _Nonnull)(NSError * _Nonnull error))failure;
+ (void)requestedApi:(NSString * _Nonnull)actionID withQueryParam:(NSDictionary<NSString *, NSString *> * _Nullable)queryParamDict withParam:(NSDictionary<NSString *, NSString *> * _Nullable)params withPathParams:(NSMutableDictionary * _Nullable)pathParamDict withTag:(NSString * _Nullable)apiTag onSuccess:(void (^ _Nonnull)(id _Nonnull))success onFailure:(void (^ _Nonnull)(BOOL, NSError * _Nonnull))failed;
- (void)setAppRuningMode;

/// Resume any pending downloads
///
/// <ul><li>paramter url: Resume download url</li></ul>
/// \param success Block to handle response
+ (void)resumeDownloads:(NSString * _Nonnull)path withApiTag:(NSString * _Nullable)apiTag success:(void (^ _Nonnull)(int64_t, int64_t totalBytes))success;

/// Cancel any ongoing alamofire operation
+ (void)cancelAllRequests;
+ (void)cancelRequestWithTag:(NSString * _Nonnull)actionID;
@end


SWIFT_CLASS("_TtC16TSGServiceClient10TSGUtility")
@interface TSGUtility : NSObject
+ (NSString * _Nonnull)createPathParamURL:(NSString * _Nonnull)tempURL pathParamDict:(NSMutableDictionary * _Null_unspecified)pathParamDict;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC16TSGServiceClient19TSGValidationHelper")
@interface TSGValidationHelper : NSObject
+ (void)checkIfItsRequired:(Key * _Nonnull)obj;
+ (void)checkFileSize:(Key * _Nonnull)obj withData:(NSData * _Nullable)data;
+ (void)checkFormats:(Key * _Nonnull)obj withUserDict:(NSDictionary * _Nonnull)dict;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

#pragma clang diagnostic pop
