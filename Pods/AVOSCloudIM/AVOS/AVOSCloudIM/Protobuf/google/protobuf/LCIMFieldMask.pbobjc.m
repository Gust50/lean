// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: google/protobuf/field_mask.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(LCIM_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define LCIM_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if LCIM_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/LCIMProtocolBuffers_RuntimeSupport.h>
#else
 #import "LCIMProtocolBuffers_RuntimeSupport.h"
#endif

#if LCIM_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/LCIMFieldMask.pbobjc.h>
#else
 #import "google/protobuf/LCIMFieldMask.pbobjc.h"
#endif
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - GPBFieldMaskRoot

@implementation LCIMFieldMaskRoot

@end

#pragma mark - GPBFieldMaskRoot_FileDescriptor

static LCIMFileDescriptor *GPBFieldMaskRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static LCIMFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPBDebugCheckRuntimeVersion();
    descriptor = [[LCIMFileDescriptor alloc] initWithPackage:@"google.protobuf"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - GPBFieldMask

@implementation LCIMFieldMask

@dynamic pathsArray, pathsArray_Count;

typedef struct LCIMFieldMask__storage_ {
  uint32_t _has_storage_[1];
  NSMutableArray *pathsArray;
} LCIMFieldMask__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (LCIMDescriptor *)descriptor {
  static LCIMDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "pathsArray",
        .dataTypeSpecific.className = NULL,
        .number = GPBFieldMask_FieldNumber_PathsArray,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(LCIMFieldMask__storage_, pathsArray),
        .flags = GPBFieldRepeated,
        .dataType = GPBDataTypeString,
      },
    };
    LCIMDescriptor *localDescriptor =
        [LCIMDescriptor allocDescriptorForClass:[LCIMFieldMask class]
                                     rootClass:[LCIMFieldMaskRoot class]
                                          file:GPBFieldMaskRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(LCIMFieldMask__storage_)
                                         flags:0];
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
