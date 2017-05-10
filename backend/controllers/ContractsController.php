<?php
namespace backend\controllers;

use Yii;
use yii\filters\AccessControl;
use backend\models\Contract;
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
      
      $contracts = Contract::find()->limit(20, ($page-1));
      return $this->render('index.tpl', ['contracts'=>$contracts, 'page'=>$page]);
    }
    
    public function actionAdd()
    {
      $contract = new Contract();
      
      
      return $this->render('edit.tpl', ['contract'=>$contract]);
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
    
    public function actionSave()
    {
      
    }
}
