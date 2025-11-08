#import "include/NSLayoutConstraint+Priority.h"

@implementation NSLayoutConstraint (Priority)

- (instancetype)withPriority:(UILayoutPriority)priority {
    self.priority = priority;
    return self;
}

@end
