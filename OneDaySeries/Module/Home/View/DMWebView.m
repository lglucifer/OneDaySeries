
#import "DMWebView.h"

#import <objc/runtime.h>

@implementation DMWebView

- (id)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame])) return self;
    [self setup];
    return self;
}

- (id)initWithCoder:(NSCoder*)coder {
    if (!(self = [super initWithCoder:coder])) return self;
    [self setup];
    return self;
}

-(void)setup {
    if ([self respondsToSelector:@selector(scrollView)]) {
        UIScrollView *scrollView = [self scrollView];
        [scrollView setDelaysContentTouches:NO];
        scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    }
    self.backgroundColor = [UIColor whiteColor];
    
        [self.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if ([self respondsToSelector:@selector(scrollView)]) {
        for (UIView *subview in self.scrollView.subviews) {
            if ([subview isKindOfClass:[UIImageView class]]) {
                subview.hidden = YES;
            }
        }
    }
    
    if (!objc_getAssociatedObject(self.scrollView, "associated_height")) {
        NSValue *value = [NSValue valueWithCGSize:self.scrollView.contentSize];
        [self observeValueForKeyPath:@"contentSize" ofObject:self.scrollView change:@{NSKeyValueChangeNewKey : value} context:nil];
    }
}


- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"] && self.footerView) {
        NSNumber *incumbentheight = objc_getAssociatedObject(object, "associated_height");
        
        NSValue *newValue = [change objectForKey:NSKeyValueChangeNewKey];
        CGSize newSize;
        [newValue getValue:&newSize];
        
        if (!incumbentheight || [incumbentheight floatValue] != newSize.height) {
            CGFloat newHeight = newSize.height + self.footerView.frame.size.height;
            
            // now setup the footer.
            if (!self.footerView.superview) {
                     [self.scrollView addSubview:self.footerView];
            } else if ([self.footerView superview] != self.scrollView) {
                    [self.footerView removeFromSuperview];
                    [self.scrollView addSubview:self.footerView];
            }
            
            self.footerView.frame = (CGRect){0,newSize.height, .size = self.footerView.frame.size};
            
            objc_setAssociatedObject(object, "associated_height", @(newHeight), OBJC_ASSOCIATION_COPY);
            
            self.scrollView.contentSize = (CGSize){newSize.width, newSize.height+self.footerView.frame.size.height};
            
        } else {
            objc_setAssociatedObject(object, "associated_height", @(newSize.height), OBJC_ASSOCIATION_COPY);
        }
    }
}

-(void)dealloc {
    [self.scrollView removeObserver:self forKeyPath:@"contentSize"];
}


@end
