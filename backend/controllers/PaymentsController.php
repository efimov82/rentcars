<?php
namespace backend\controllers;

use Yii;
use yii\filters\AccessControl;
use backend\models\Payment;
use backend\models\PaymentCategory;
use backend\models\PaymentType;
use backend\models\User;
use backend\models\Car;
use backend\models\Contract;
use yii\helpers\ArrayHelper;

/**
 * Client controller
 */
class PaymentsController extends RentCarsController{
  public function behaviors(){
    return [
          'access' => [
              'class' => AccessControl::className(),
              'rules' => [
                  [    // all the action are accessible to admin and manager
                      'allow' => true,  
                      'roles' => ['admin', 'manager'],
                  ],   
              ],
          ],        
      ];
  }
  
  /**
    * Displays homepage.
    *
    * @return string
    */
  public function actionIndex(){
    $page = Yii::$app->getRequest()->getQueryParam('page', 1);// ? Yii::$app->getRequest()->getQueryParam('page') : 1;
    $car_number = (int)Yii::$app->getRequest()->getQueryParam('car_number', '0');
    $contract_id = (int)Yii::$app->getRequest()->getQueryParam('contract_id', '0');
    
    $count = 20;
    $where = ['status'=>[Payment::STATUS_NEW, 
                         Payment::STATUS_CONFIRMED, 
                         Payment::STATUS_UNPAID]];
    if ($car_number){
      $car = Car::findOne(['number'=>$car_number]);
      if ($car)
        $where['car_id'] = $car->id;
      else
        $where['car_id'] = 0;
    }
    
    if ($contract_id)
      $where['contract_id'] = $contract_id;
    
    $payments = Payment::find()->offset(($page-1)*$count)
                               ->limit($count)
                               ->where($where)
                               ->orderBy(['date_create'=>SORT_DESC]);

    $users = User::find()->indexBy('id')->all();
    $categories = PaymentCategory::find()->indexBy('id')->all();
    $cars = Car::find()->indexBy('id')->all();

    return $this->render('index.tpl', ['payments'=>$payments, 
                                        'users'=>$users, 
                                        'categories'=>$categories, 
                                        'cars'=>$cars,
                                        'car_number'=>$car_number,
                                        'page'=>$page]);
  }

  public function actionAdd(){
    $payment = new Payment();

    return $this->showAddEditPage($payment);
  }

  public function actionEdit(){
    $id = Yii::$app->getRequest()->getQueryParam('id');
    $payment = Payment::findOne(['id'=>$id]);
    if (!$payment || ($payment->status == Payment::STATUS_DELETED)){
      return $this->redirect('/payments');
    }

    return $this->showAddEditPage($payment);
  }
   
   
  protected function showAddEditPage(Payment $payment){
    $categories = ArrayHelper::map(PaymentCategory::find()->all(), 'id', 'name');
    $types = ArrayHelper::map(PaymentType::find()->all(), 'id', 'name');
    $cars = Car::find()->all();
    $contracts = Contract::find()->all();

    return $this->render('edit.tpl', ['payment'=>$payment, 
                                      'categories'=>$categories, 
                                      'types'=>$types,
                                      'cars'=>$cars,
                                      'contracts'=>$contracts]);
  }

   public function actionSave(){
     $post = Yii::$app->getRequest()->post();
     $action = $post['action'];
     $id = (int)$post['id'];

     $payment = Payment::findOne(['id'=>$id]);
     // check for Delete status
     if ($payment && ($payment->status == Payment::STATUS_DELETED))
       return $this->redirect ('/payments');
     
     switch ($action){
       case 'save':
        if (!$payment){
          $payment = new Payment(['status' => Payment::STATUS_NEW,
                                  'creator_id' => Yii::$app->user->id,
                                  'date_create' => date('Y-m-d H:i:s')]);
        }
        
        if (Yii::$app->user->can('admin')){
          $payment->status = (int)$post['status'];
        }
        // Поле creator_id = реальный создатель, user_id - кому приписан контракт, к случае если админ захочет добавить кому то контракт
        // ВОЗМОЖНО стоит это упразднить
        $payment->user_id = Yii::$app->user->id;
        $payment->date = date('Y-m-d', strtotime($post['date']));
        
        $payment->category_id = (int)$post['category_id'];
        $payment->type_id = (int)$post['type_id'];
        $payment->contract_id = (int)$post['contract_id'];
        $payment->transaction_number = $post['transaction_number'];
        $payment->car_id = (int)$post['car_id']; // TODO chect for CAR ID
        $payment->usd = floatval($post['usd']);
        $payment->euro = floatval($post['euro']);
        $payment->thb = floatval($post['thb']);
        $payment->ruble = floatval($post['ruble']);
        $payment->description = $post['description'];

        $res = $payment->save();
        break;
      case 'delete':
        if ($payment){
          if (Yii::$app->user->can('admin')){
            $payment->status = Payment::STATUS_DELETED;
            $payment->date_update = date('Y-m-d H:i:s');
            $payment->save();
          }else{
            if (($payment->creator_id == Yii::$app->user->identity->id) && 
                ($payment->status == Payment::STATUS_NEW)){
              $payment->delete();
            }
          }
        }
      }
      return $this->redirect('/payments');
    }
}