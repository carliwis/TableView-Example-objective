//
//  DetailViewController.m
//  Mi Primera Tabla
//
//  Created by Carlos Osuna on 9/26/17.
//  Copyright © 2017 wgdomenzain. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgPerson;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.person != nil) {
        self.imgPerson.image = self.person[@"image"];
        self.lblName.text = self.person[@"name"];
        self.lblDescription.text = self.person[@"description"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
@end
