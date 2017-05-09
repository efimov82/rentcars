<?php
namespace backend\controllers;

use Yii;
use yii\filters\AccessControl;
use backend\models\Payment;
use backend\models\PaymentCategory;
use backend\models\PaymentType;
use yii\helpers\ArrayHelper;

/**
 * Client controller
 */
class PaymentsController extends RentCarsController
{
  public function behaviors()
  {
    return [
          'access' => [
              'class' => AccessControl::className(),
              'rules' => [
                  [    // all the action are accessible to admin and manager
                      'allow' => true,  
                      'roles' => ['admin', 'manager'],
                  ],   
//                   
              ],
          ],        
      ];
  }
  
  /**
     * Displays homepage.
     *
     * @return string
     */
    public function actionIndex()
    {
      $page = Yii::$app->getRequest()->getQueryParam('page') ? Yii::$app->getRequest()->getQueryParam('page') : 1;
      
      $payments = Payment::find()->limit(20, ($page-1));
      return $this->render('index.tpl', ['payments'=>$payments, 'page'=>$page]);
    }
    
    public function actionAdd()
    {
      $payment = new Payment();
      $this->_passParamsToView($payment);
      
      $categories = ArrayHelper::map(PaymentCategory::find()->all(), 'id', 'name');
      $types = ArrayHelper::map(PaymentType::find()->all(), 'id', 'name');
      
      return $this->render('edit.tpl', ['payment'=>$payment, 'categories'=>$categories, 'types'=>$types]);
    }
    
    public function actionEdit()
    {
      $id = Yii::$app->getRequest()->getQueryParam('id');
      $payment = Payment::findOne(['id'=>$id]);
      if (!$payment)
        return $this->redirect('/');
      
      $categories = ArrayHelper::map(PaymentCategory::find(), 'id', 'name');
      
      return $this->render('edit.tpl', ['payment'=>$payment, 'categories'=>$categories]);
    }
    
    protected function _passParamsToView(Payment $payment)
    {
      
    }
    
    public function actionSave()
    {
      $action = Yii::$app->getRequest()->post('action');
      $id = Yii::$app->getRequest()->post('id');
      $post = Yii::$app->getRequest()->post();
      
      switch ($action)
      {
        case 'save':
          $payment = Payment::findOne(['id'=>$id]);
          if (!$payment)
          {
            $payment = new Payment();
            if (Yii::$app->user->can('admin'))
            {
              $payment->user_id = 1; //(int)$post['user_id'];
              $payment->status = Payment::STATE_CONFIRM;
            }
            else
            {
              $payment->user_id = Yii::$app->user->id;
              $payment->status = Payment::STATE_NEW;
            }


            $payment->creator_id = Yii::$app->user->id;
            $payment->date = date('Y-m-d', strtotime($post['date']));
            $payment->date_create = date('Y-m-d H:i:s');
            $payment->category_id = (int)$post['category_id'];
            $payment->type_id = (int)$post['type_id'];
            $payment->contract_id = $post['contract_id'];
            $payment->transaction_number = $post['transaction_number'];
            $payment->car_id = 3;//$post['car_id  ']; // TODO crech and find Car by number
            $payment->usd = floatval($post['usd']);
            $payment->uero = floatval($post['uero']);
            $payment->thb = floatval($post['thb']);
            $payment->ruble = floatval($post['ruble']);
            $payment->description = $post['description'];
          }
          $payment->save();
          
      default:
          return $this->redirect('/payments');
    }
  }
  
}
