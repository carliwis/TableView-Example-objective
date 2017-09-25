//
//  NewPersonViewController.h
//  Mi Primera Tabla
//
//  Created by Carlos Osuna on 9/25/17.
//  Copyright © 2017 wgdomenzain. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewPersonDelegate <NSObject>
- (void)didAddPersonName:(NSString *)name andImageSelected:(UIImage *)image;
@end

@interface NewPersonViewController : UIViewController
@property (nonatomic, weak) id <NewPersonDelegate> delegate;

@end
