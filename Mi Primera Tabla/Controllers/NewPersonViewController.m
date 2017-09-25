//
//  NewPersonViewController.m
//  Mi Primera Tabla
//
//  Created by Carlos Osuna on 9/25/17.
//  Copyright © 2017 wgdomenzain. All rights reserved.
//

#import "NewPersonViewController.h"

@interface NewPersonViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtDescription;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;
@end

@implementation NewPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)btnBack:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)btnSave:(UIButton *)sender {
    if (self.delegate != nil) {
        [self.delegate didAddPersonName:self.txtName.text andImageSelected:self.imgProfile.image];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITapGestures

- (IBAction)btnEditImage:(UITapGestureRecognizer *)sender {
    NSLog(@"JIJIJI click");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Selecciona una opción" preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *selfie = [UIAlertAction actionWithTitle:@"Tomar selfie" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"TomarSelfie");
        [self takeSelfie];
    }];
    
    UIAlertAction *gallery = [UIAlertAction actionWithTitle:@"Seleccionar foto" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Seleccionar foto");
        [self selectFromGallery];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancelar" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:selfie];
    [alert addAction:gallery];
    [alert addAction:cancel];
    [self presentViewController:alert animated:true completion:nil];
}

#pragma mark - Utils

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)takeSelfie {
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)selectFromGallery {
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *choosenImage = info[UIImagePickerControllerEditedImage];
    self.imgProfile.image = choosenImage;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
