<?php
namespace backend\controllers;

use Yii;
use yii\filters\AccessControl;
use backend\controllers\RentCarsController;
use backend\models\Customer;

class CustomersController extends RentCarsController {
  public function behaviors() {
      return [
          'access' => [
              'class' => AccessControl::className(),
              'rules' => [
                  [    // all the action are accessible to superadmin, admin and manager
                      'allow' => true,  
                      'roles' => ['admin', 'manager'],
                  ],   
              ],
          ],        
      ];
  }
  

  public function actionIndex() {
    $customers = Customer::find()->all();
    return $this->render('index.tpl', ['customers'=>$customers]);
  }
  
  public function actionAdd() {
    $customer = new Customer;
    return $this->render('edit.tpl', ['customer'=>$customer]);
  }
  
  public function actionEdit() {
    $id = Yii::$app->getRequest()->getQueryParam('id');
    $customer = Customer::findOne(['id'=>$id]);
    if (!$customer)
      return $this->reqirect('/customers');
    
    return $this->render('edit.tpl', ['customer'=>$customer]);
  }
  
  public function actionSave() {
    $post = Yii::$app->getRequest()->post();
    $action = $post['action'];
    $id = (int)$post['id'];

    $customer = Customer::findOne(['id'=>$id]);
    if (!$customer)
      $customer = new Customer();

    switch ($action){
      case 'save':
        $customer->f_name = trim($post['f_name']);
        $customer->s_name = trim($post['s_name']);
        $customer->l_name = trim($post['l_name']);
        $customer->email = trim($post['email']);
        $customer->phone_m = trim($post['phone_m']);
        $customer->phone_h = trim($post['phone_h']);
        $customer->passport = trim($post['passport']);
        $customer->facebook = trim($post['facebook']);
        $customer->description = trim($post['description']);
        
        $customer->save();
    }

    return $this->redirect('/customers');
  }
    
}
