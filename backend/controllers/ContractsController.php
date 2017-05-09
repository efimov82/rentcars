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
class ContractsController extends RentCarsController
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
      
    }
}
