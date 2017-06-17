<?php
namespace backend\controllers;

use Yii;
use yii\filters\AccessControl;

use backend\models\Contract;
use backend\models\Car;
use backend\models\User;
use backend\models\Place;
use backend\models\Area;
use backend\models\Customer;
use backend\models\PaymentCategory;
use backend\models\PaymentType;
use backend\models\Payment;
use yii\helpers\ArrayHelper;
use backend\classes\rcPaginator;

use yii\web\UploadedFile;
use backend\models\UploadedPhotos;

use kartik\mpdf\Pdf;

/**
 * Client controller
 */
class ContractsController extends RentCarsController{
  protected   $photos_dir_web = '/files/contacts/';
  protected   $photos_dir_fs = '../web/files/contacts/';
  protected   $list_equals = [1=>'=', 2=>'>' , 3=>'<', 4=>'>=', 5=>'=<'];
  protected   $list_orders = [1=>['name'=>'Data of start','field'=>'date_start'], 
                              2=>['name'=>'Data of finish','field'=>'date_stop DESC'], 
                              3=>['name'=>'Contract number','field'=>'number']
                            ];

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
    $params['car_number'] = substr(Yii::$app->getRequest()->getQueryParam('car_number'), 0, 5);
    $params['number'] = substr(Yii::$app->getRequest()->getQueryParam('number'), 0, 10);
    $params['customer_id'] = (int)Yii::$app->getRequest()->getQueryParam('customer_id');
    $params['date_start'] = Yii::$app->getRequest()->getQueryParam('date_start');
    $params['date_stop'] = Yii::$app->getRequest()->getQueryParam('date_stop');
    $params['order_by'] = Yii::$app->getRequest()->getQueryParam('order_by');
    $params['page'] = Yii::$app->getRequest()->getQueryParam('page') ? Yii::$app->getRequest()->getQueryParam('page') : 1;

    $count = 50;
    $where = $this->createWhere($params);
    $order = isset($this->list_orders[$params['order_by']]) ? $this->list_orders[$params['order_by']]['field'] : ' date_start';
    $contracts = Contract::find()->where($where)
                                  ->offset(($params['page']-1)*$count)
                                  ->limit($count)
                                  ->orderBy($order);
    $all_records = Contract::find()->where($where)->count(); 
    $pages = ceil($all_records / $count);

    $cars = ArrayHelper::map(Car::find()->all(), 'id', 'number');
    $customers = Customer::find()->indexBy('id')->all();
    $users = User::find()->indexBy('id')->all();
    $places = Place::find()->indexBy('id')->all();
    $areas = Area::find()->indexBy('id')->all();

    $message = Yii::$app->session->getFlash('message');
    $paginator = new rcPaginator(['pages'=>$pages,
                                  'current'=>$params['page']]);

    return $this->render('index.tpl', ['contracts'=>$contracts, 
                                       'params'=>$params, 
                                       'message'=>$message,
                                       'paginator'=>$paginator,
                                       'all_records'=>$all_records,
                                       'users'=>$users,
                                       'places'=>$places,
                                       'areas'=>$areas,
                                       'list_orders'=>$this->list_orders,
                                       'customers'=>$customers,
                                       'cars'=>$cars]);
  }
    
    public function actionAdd(){
      $contract = new Contract();
      $customer = new Customer();
      $data = array_flip($contract->getTableSchema()->getColumnNames());
      $data['car_number'] = '';
      $data['car_mileage'] = 0;
      $error = '';
      
      if (!Yii::$app->getRequest()->isPost){
        return $this->renderPage($data, $contract, $customer, 'edit.tpl');
      }
      
      $post = Yii::$app->getRequest()->post();
      switch ($post['action']){
        case 'save':
      
          // save client
          $contract->client_id = $this->saveClient($post);
          if (!$contract->client_id){
            return $this->renderPage($post, $contract);
          }
          // save contract
          $res = $this->saveContract($contract, $post);
          if (!$res){
            return $this->renderPage($post, $contract, $customer, 'edit.tpl');
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
        return $this->redirect('/contracts');
      
      $car = Car::findOne(['id'=>$contract->car_id]);
      $customer = Customer::findOne(['id'=>$contract->client_id]);
      $data = ['car'=>$car, 'path'=>'/files/contracts/'.$contract->id.'/'];
      
      return $this->renderPage($data, $contract, $customer, 'view.tpl');
    }
    
    public function actionViewPdf() {
      // get your HTML raw content without any layouts or scripts
        $data = ['id'=>365, 'car'=>'Toyota Vios #4605, Color Black',
                'renter'=>'Ivanov Sergey Vitrorovich',
                'pasport'=>'#3393923, date 05.12.06, issue 05.12.07',
                'p'=>'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'];
        $content = $this->renderPartial('pdf.tpl', ['data'=>$data]);
        //echo($content);
        //die();
        
        // setup kartik\mpdf\Pdf component
        $pdf = new Pdf([
            // set to use core fonts only
            'mode' => Pdf::MODE_CORE, 
            // A4 paper format
            'format' => Pdf::FORMAT_A4, 
            // portrait orientation
            'orientation' => Pdf::ORIENT_PORTRAIT, 
            // stream to browser inline
            'destination' => Pdf::DEST_BROWSER, 
            // your html content input
            'content' => $content,  
            // format content from your own css file if needed or use the
            // enhanced bootstrap css built by Krajee for mPDF formatting 
            'cssFile' => '@vendor/kartik-v/yii2-mpdf/assets/kv-mpdf-bootstrap.min.css',
            // any css to be embedded if required
            'cssInline' => '.kv-heading-1{font-size:18px}', 
             // set mPDF properties on the fly
            'options' => ['title' => 'Agreement #342'],
             // call mPDF methods on the fly
            'methods' => [ 
                'SetHeader'=>['Phuker Cars Rental Co'], 
                'SetFooter'=>['{PAGENO}'],
            ]
        ]);

        // return the pdf output as per the destination setting
        return $pdf->render(); 
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
      $action = $post['action'];
      switch ($action){
        case 'save':
          $contract->date_stop = date('Y-m-d', strtotime($post['new_date_stop']));
          $contract->time = (int)$post['time'];
          $contract->save();
          // payment
          $user_id = Yii::$app->user->id;
          $payment = new Payment(
                  ['user_id'    => $user_id, 
                   'creator_id' => $user_id, 
                   'date'       => date('Y-m-d H:i:s'),
                   'date_create'=> date('Y-m-d H:i:s'), 
                   'type_id'    => PaymentType::INCOMING,
                   'contract_id'=> $contract->id, 
                   'car_id'     => $contract->car_id, 
                   'category_id'=> 10, // category_id = 10 - extend contract
                   'status'     => $post['status'],
                   'thb'        => (int)$post['amount_thb'],
                   'euro'       => (int)$post['amount_euro'],
                   'usd'        => (int)$post['amount_usd'],
                   'ruble'      => (int)$post['amount_ruble']
                   ]);
          $payment->save();
          Yii::$app->session->setFlash('message', 'Contract successfully extended.');
      }
      
      $this->redirect('/contracts');
    }
    
    /**
     * 
     * @param [car_number, date_start, date_stop]
     * @return 
    */
    protected function createWhere($params) {
      $res = '';
      if ($params['car_number']) {
        $car = Car::findOne(['number'=>$params['car_number']]);
        if ($car)
          $res .= ' AND car_id='.$car->id;
      }
      if ($params['date_start']) {
        $data_start = date('Y-m-d', strtotime($params['date_start']));
        $res .= " AND date_start >='".$data_start."'";
      }
      if ($params['date_stop']) {
        $data_stop = date('Y-m-d', strtotime($params['date_stop']));
        $res .= " AND date_stop <= '".$data_stop."'";
      }
      if ($params['number']) {
        $res .= " AND number ='".$params['number']."'";
      }
      if ($params['customer_id']) {
        $res .= " AND client_id ='".$params['customer_id']."'";
      }
      if ($res)
        return substr($res, 4);
      else
        return '1=1';
    }
    
    
    
    public function actionClose(){
      $id = Yii::$app->getRequest()->getQueryParam('id');
      $contract = Contract::findOne(['id'=>$id]);
      if (!$contract)
        return $this->redirect('/');
      
      $payments = Payment::find()->where(['contract_id'=>$id])->all();
      $car = Car::findOne(['id'=>$contract->car_id]);
      $categories_pay = PaymentCategory::find()->indexBy('id')->all();
      
      if (!Yii::$app->getRequest()->isPost){
        return $this->render('close.tpl', ['contract'=>$contract, 
                                           'payments'=>$payments, 
                                           'car'=>$car, 
                                           'categories_pay'=>$categories_pay]);
      }
      
      $post = Yii::$app->getRequest()->post();
      $action = $post['action'];
      switch ($action){
        case 'close':
          $this->updateUnpaidPayments($payments);
          $this->createAdditionalPayments($post, $contract);
          
          // Set available status car
          $car->status = Car::STATUS_AVAILABLE;
          $car->save();
          // close contract
          $contract->status = 2;
          $contract->description = trim(htmlentities($post['description']));
          $contract->date_update = date('Y-m-d H:i:s', time());
          $contract->save();
          
          Yii::$app->session->setFlash('message', "Contract #{$id} closed.");
          break;
        default:
          // nothing to do
          
      }
      return $this->redirect('/contracts');
    }

    
    protected function createAdditionalPayments(array $post, Contract $contract){
      if ((int)$post['washing'] > 0){
        $this->_createPayment(5, (int)$post['washing'], $contract);
      }
      
      if ((int)$post['repair'] > 0){
        $this->_createPayment(3, (int)$post['repair'], $contract);
      }
      
      if ((int)$post['gasoline'] > 0){
        $this->_createPayment(4, (int)$post['gasoline'], $contract);
      }
      
      if ((int)$post['overtime'] > 0){
        $this->_createPayment(11, (int)$post['overtime'], $contract);
      }
    }

    
    protected function _createPayment($category_id, $thb_count, Contract $contract){
      $payment = new Payment(
                  ['user_id'    => Yii::$app->user->id, 
                   'creator_id' => Yii::$app->user->id, 
                   'date'       => date('Y-m-d H:i:s'),
                   'date_create'=> date('Y-m-d H:i:s'), 
                   'type_id'    => PaymentType::INCOMING,
                   'contract_id'=> $contract->id, 
                   'car_id'     => $contract->car_id, 
                   'category_id'=> $category_id,
                   'status'     => Payment::STATUS_NEW,
                   'thb'        => $thb_count,
                   ]);
      $payment->save();
    }
    
    protected function updateUnpaidPayments(array $payments){
      $user_id = Yii::$app->user->id;
      foreach($payments as $num=>$payment){
        if ($payment->status == Payment::STATUS_UNPAID){
          $payment->user_id = $user_id;
          $payment->date_update = date('Y-m-d H:i:s', time());
          $payment->status = Payment::STATUS_NEW;
          $payment->save();
        }
      }
    }

    protected function renderPage(array $data, Contract $contract, Customer $customer, $template)
    {
      $cars = Car::find()->where(['status'=>Car::STATUS_AVAILABLE])->all();
      $customers = Customer::find()->all();
      $error = Yii::$app->session->getFlash('error', '');
      
      return $this->render($template, ['data'=>$data, 
                                        'contract'=>$contract, 
                                        'cars'=>$cars, 
                                        'customers'=>$customers, 
                                        'customer'=>$customer, 
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
        $client = Customer::findOne(['id'=>$post['client_id']]);
      }
      
      if (!$client){
        $client = new Customer();
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
    
    protected function savePayments(Contract $contract, array $post)
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
    
    
  protected function savePictures(Contract $contract, array $post)
  {
    $photos = new UploadedPhotos('contracts');
    $arr_photos = $photos->save($contract->id);
    
    $contract->setPhotos($arr_photos);
    $res = $contract->save();
    
    return $res;
  }
    
  public function actionUpload()
  {
    if (Yii::$app->getRequest()->isPost){
      $post = Yii::$app->getRequest()->post();
      //print_r($_FILES);
      $photos = new UploadedPhotos('contracts');
      
      print_r ($photos->save('4'));
      //$files = UploadedFile::getInstances($photos, 'files');
      //$photos->load($files);
        
      //if($model->load($post)){
        

        //if($model->validate()) {
          //$uploaded = $file->saveAs($dir . '/' .'test'  );
        //}
      //}
    }else{
      return $this->render('upload.tpl');
    }
  }
  
}