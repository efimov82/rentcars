<?php
namespace backend\controllers;

use Yii;
use yii\filters\AccessControl;
use backend\models\Contract;
use backend\models\Car;
use backend\models\Client;
use backend\models\PaymentCategory;
use backend\models\PaymentType;
use backend\models\Payment;
use yii\helpers\ArrayHelper;

/**
 * Client controller
 */
class ContractsController extends RentCarsController{
  public function behaviors(){
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
   * Displays list contracts.
   *
   * @return string
   */
  public function actionIndex(){
    $car_number = (int)Yii::$app->getRequest()->getQueryParam('car_number');
    $page = Yii::$app->getRequest()->getQueryParam('page') ? Yii::$app->getRequest()->getQueryParam('page') : 1;

    $count = 20;
    if ($car_number){
      $car_id = 0;
      $car = Car::findOne(['number'=>$car_number]);
      if ($car){
        $car_id = $car->id;
      }
      $contracts = Contract::find()->where(['car_id'=>$car_id])
                                    ->offset(($page-1)*$count)
                                    ->limit($count)
                                    ->orderBy(['date_create'=>SORT_DESC]);
    }else{
      $contracts = Contract::find()->offset(($page-1)*$count)
                                    ->limit($count)
                                    ->orderBy(['date_create'=>SORT_DESC]);
    }

    $cars = ArrayHelper::map(Car::find()->all(), 'id', 'number');
    $customers = Client::find()->indexBy('id')->all();

    $message = Yii::$app->session->getFlash('message');

    return $this->render('index.tpl', ['contracts'=>$contracts, 
                                       'page'=>$page, 
                                       'car_number'=>$car_number, 
                                       'message'=>$message,
                                       'customers'=>$customers,
                                       'cars'=>$cars]);
  }
    
    public function actionAdd(){
      $contract = new Contract();
      $client = new Client();
      $data = array_flip($contract->getTableSchema()->getColumnNames());
      $data['car_number'] = '';
      $data['car_mileage'] = 0;
      $error = '';
      
      if (!Yii::$app->getRequest()->isPost){
        return $this->renderPage($data, $contract, $client, 'edit.tpl');
      }
      
      $post = Yii::$app->getRequest()->post();
      switch ($post['action']){
        case 'save':
      
          // save clien
          $contract->client_id = $this->saveClient($post);
          if (!$contract->client_id){
            return $this->renderPage($post, $contract);
          }
          // save contract
          $res = $this->saveContract($contract, $post);
          if (!$res){
            return $this->renderPage($post, $contract, $client);
          }

          $this->savePayments($contract, $post);
          $this->savePictures($contract, $post);
          Yii::$app->session->setFlash('message', 'Contract save success!');
          break;
        case 'dalete':
          // TODO
      }
      return $this->redirect('/contracts');
    }
    
    public function actionView(){
      $id = Yii::$app->getRequest()->getQueryParam('id');
      $contract = Contract::findOne(['id'=>$id]);
      if (!$contract)
        return $this->redirect('/');
      
      $car = Car::findOne(['id'=>$contract->car_id]);
      $client = Client::findOne(['id'=>$contract->client_id]);
      $data = ['car_number'=>$car->number, 'car_mileage'=>$car->mileage];
      
      return $this->renderPage($data, $contract, $client, 'view.tpl');
    }

    
    public function actionExtend(){
      $id = Yii::$app->getRequest()->getQueryParam('id');
      $contract = Contract::findOne(['id'=>$id]);
      if (!$contract)
        return $this->redirect('/');
      
      $payments_statuses = Payment::getListStatuses();
      if (!Yii::$app->getRequest()->isPost){
        return $this->render('extend.tpl', ['contract'=>$contract, 'payments_statuses'=>$payments_statuses]);
      }
      
      $post = Yii::$app->getRequest()->post();
      // TODO save + add payment
    }
    
    public function actionEdit(){
      $id = Yii::$app->getRequest()->getQueryParam('id');
      $contract = Contract::findOne(['id'=>$id]);
      if (!$contract)
        return $this->redirect('/');
      
      $car = Car::findOne(['id'=>$contract->car_id]);
      $client = Client::findOne(['id'=>$contract->client_id]);
      $data = ['car_number'=>$car->number, 'car_mileage'=>$car->mileage];
      
      if (!Yii::$app->getRequest()->isPost){
        return $this->renderPage($data, $contract, $client, 'edit.tpl');
      }
      
      $post = Yii::$app->getRequest()->post();
      // TODO - уточнить что именно сохранить и как
    }
    
    public function actionClose(){
      $id = Yii::$app->getRequest()->getQueryParam('id');
      $contract = Contract::findOne(['id'=>$id]);
      if (!$contract)
        return $this->redirect('/');
      
      $this->render('close.tpl', ['contract'=>$contract]);
    }


    protected function renderPage($data, $contract, $client, $template)
    {
      $cars = Car::find()->where(['status'=>Car::STATUS_AVAILABLE])->all();
      $clients = Client::find()->all();
      $error = Yii::$app->session->getFlash('error', '');
      
      return $this->render($template, ['data'=>$data, 
                                        'contract'=>$contract, 
                                        'cars'=>$cars, 
                                        'client'=>$client, 
                                        'clients'=>$clients, 
                                        'error'=>$error]);
    }
    
    
    /**
     * 
     * @param array $post
     * @return int client_id | 0
     */
    protected function saveClient(array $post)
    {
      $client = null;
      if (isset($post['client_id']) && (int)$post['client_id']){
        $client = Client::findOne(['id'=>$post['client_id']]);
      }
      
      if (!$client){
        $client = new Client();
      }
      
      $client->s_name = $post['s_name'];
      $client->passport = $post['passport'];
      $client->phone_m = $post['phone_m'];
      $client->phone_h = $post['phone_h'];
      $client->email = $post['email'];
      $client->nationality = $post['nationality'];
      
      if (!$client->save()){
        Yii::$app->session->setFlash('error', 'Error save client data.');
        return false;
      }
      
      return $client->id;
    }

    /**
     * Creare/update contact
     * 
     * @param Contract $contract
     * @param array $post
     * @return boolean
     */
    protected function saveContract(Contract &$contract, array $post){
      if ($contract->isNewRecord){
        $contract->user_id =  Yii::$app->user->id;
        $contract->date_create = date('Y-m-d H:i:s');
        $contract->status = 1; // OPEN
        $car_status = Car::STATUS_LEASED;
      }else{
        $contract->date_update = date('Y-m-d H:i:s');
        $contract->status = (int)$post['status'];
        $car_status = Car::STATUS_AVAILABLE;
      }
      
      $contract->date_start = date('Y-m-d', strtotime($post['date_start']));
      $contract->date_stop = date('Y-m-d', strtotime($post['date_stop']));
      $contract->time = (int)$post['time'];
      
      $car = Car::findOne(['id'=>(int)$post['car_id']]);
      if (!$car){
        Yii::$app->session->setFlash('error', 'Car not found or not avaliable for rent.');
        return false;
      }else{ // change mileage, status car
        $car->mileage = $post['car_mileage'];
        $car->status = $car_status;
        $car->save();
      }
      
      $contract->car_id = $car->id;
      
      return $contract->save();
    }
    
    protected function savePayments($contract, $post)
    {
      $user_id = Yii::$app->user->id;
      $data = ['user_id'=>$user_id, 'creator_id'=>$user_id, 'date'=>date('Y-m-d', strtotime($post['date_start'])),
                  'date_create'=>date('Y-m-d H:i:s'), 'type_id'=>PaymentType::INCOMING,
                  'contract_id'=>$contract->id, 'car_id'=>$contract->car_id, 'status'=>Payment::STATUS_NEW];
      
      
      // rent payment
      // category_id = 9 - deposit TODO think about change it
      $data1 = $data;
      $data1['category_id'] = 2;
      $data1['thb'] = (int)$post['amount_thb'];
      $data1['euro'] = (int)$post['amount_euro'];
      $data1['usd'] = (int)$post['amount_usd'];
      $data1['ruble'] = (int)$post['amount_ruble'];
      
      $payment_deposit = new Payment($data1);
      $payment_deposit->save();
      // deposit
      // category_id = 2 TODO change it
      $data2 = $data;
      $data2['category_id'] = 9;
      $data2['thb'] = (int)$post['deposit_thb'];
      $data2['euro'] = (int)$post['deposit_euro'];
      $data2['usd'] = (int)$post['deposit_usd'];
      $data2['ruble'] = (int)$post['deposit_ruble'];
      
      $payment_rent = new Payment($data2);
      $payment_rent->save();
    }
    
    
    protected function savePictures($contract, $post)
    {
      return true;
    }
}