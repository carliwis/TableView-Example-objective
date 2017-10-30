//
//  BuyViewController.m
//  Mi Primera Tabla
//
//  Created by Amalia Gatelum on 10/29/17.
//  Copyright © 2017 wgdomenzain. All rights reserved.
//

#import "BuyViewController.h"
@import FirebaseAnalytics;

@interface BuyViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgProduct;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UIButton *btnBuy;
@end

@implementation BuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.product != nil) {
        self.imgProduct.image = self.product[@"image"];
        self.lblName.text = self.product[@"name"];
        self.lblDescription.text = [NSString stringWithFormat:@"Precio: %@",self.product[@"price"]];
    }
    
    [FIRAnalytics logEventWithName:@"pantalla_compra"
                        parameters:@{
                                     @"name": @"pantalla_compra",
                                     @"full_text": @"pantalla_compra"
                                     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnBuy:(UIButton *)sender {
    [FIRAnalytics logEventWithName:@"accion_comprar"
                        parameters:@{
                                     @"name": @"accion_comprar",
                                     @"full_text": @"accion_comprar"
                                     }];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Compra"
                                                                   message:@"Compra exitosa"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Salir" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [self.navigationController popViewControllerAnimated:true];
                                                              [FIRAnalytics logEventWithName:@"accion_compra_exitosa"
                                                                                  parameters:@{
                                                                                               @"name": @"accion_compra_exitosa",
                                                                                               @"full_text": @"accion_compra_exitosa"
                                                                                               }];
                                                          }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
