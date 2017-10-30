//
//  ViewController.m
//  Mi Primera Tabla
//
//  Created by Walter Gonzalez Domenzain on 20/09/17.
//  Copyright © 2017 wgdomenzain. All rights reserved.
//

#import "Home.h"
#import "cellMainTable.h"
#import "BuyViewController.h"
@import FirebaseAnalytics;
@interface Home ()
@property NSMutableArray *personData;
@end

@implementation Home
/**********************************************************************************************/
#pragma mark - Initialization methods
/**********************************************************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.hidesBackButton = YES;
    [self initController];
}
//-------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [FIRAnalytics logEventWithName:@"pantalla_listado_productos"
                        parameters:@{
                                     @"name": @"pantalla_listado_productos",
                                     @"full_text": @"pantalla_listado_productos"
                                     }];
}
//-------------------------------------------------------------------------------
- (void)initController {
    self.personData = [[NSMutableArray alloc]init];
    [self.personData addObject:@{
                                 @"name" :  @"Bundle VR Worlds para PS4",
                                 @"price" : @"$13,299",
                                 @"image" :  [UIImage imageNamed:@"product1"],
                                 @"description": @""
                                 }];
    [self.personData addObject: @{
                                  @"name" :  @"Tenis Puma Escaper Pro",
                                  @"price" : @"$799",
                                  @"image" :  [UIImage imageNamed:@"product2"],
                                  @"description": @""
                                  }];
    [self.personData addObject: @{
                                  @"name" :  @"Mameluco Monsters Inc. Estampado",
                                  @"price" : @"$259",
                                  @"image" :  [UIImage imageNamed:@"product3"],
                                  @"description": @""
                                  }];
    [self.personData addObject: @{
                                  @"name" :  @"Botas Flexi Cafés",
                                  @"price" : @"$849",
                                  @"image" :  [UIImage imageNamed:@"product4"],
                                  @"description": @""
                                  }];
    [self.personData addObject:@{
                                 @"name" :  @"Botas Jeep Cafés",
                                 @"price" : @"$649",
                                 @"image" :  [UIImage imageNamed:@"product5"],
                                 @"description": @""
                                 }];
}

/**********************************************************************************************/
#pragma mark - Table source and delegate methods
/**********************************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//-------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.personData.count;
}
//-------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}
//-------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Initialize cells
    cellMainTable *cell = (cellMainTable *)[tableView dequeueReusableCellWithIdentifier:@"cellMainTable"];
    
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"cellMainTable" bundle:nil] forCellReuseIdentifier:@"cellMainTable"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellMainTable"];
    }
    NSDictionary *current = self.personData[indexPath.row];
    //Fill cell with info from arrays
    cell.lblName.text       =  current[@"name"];
    cell.lblAge.text        =  current[@"price"];
    cell.imgUser.image      =  current[@"image"];
    
    return cell;
}
//-------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tblMain deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *current = self.personData[indexPath.row];
    [self performSegueWithIdentifier:@"toBuy" sender:current];
    
    [FIRAnalytics logEventWithName:@"accion_selecciona_producto"
                        parameters:@{
                                     @"name": @"accion_selecciona_producto",
                                     @"full_text": [NSString stringWithFormat:@"producto: %@",current[@"name"]]
                                     }];
}


#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 if ([segue.identifier isEqualToString:@"toBuy"]) {
        BuyViewController *detailVC = [segue destinationViewController];
        detailVC.product = sender;
    }
}


@end
