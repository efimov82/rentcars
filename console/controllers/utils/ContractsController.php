<?php

namespace console\controllers\utils;

use Yii;
use yii\console\Controller;
use backend\models\Contract;
use backend\models\Car;
use backend\models\Payment;
use backend\models\PaymentType;
use backend\models\Customer;

/**
 * Import contracts -  php yii utils/contracts/import
 */
class ContractsController extends Controller {
  protected $users = [''=>4, 'T'=>4, 'B'=>5, 'В'=>5, 'D'=>6, 'P'=>7, 'A'=>8, 'M'=>9, 'М'=>9, 'Т'=>4, 'Th'=>4];
  
  protected $models = ['Toyota'=>['Vios', 'Altis', 'Fortuner', 'Innova', 'Yaris'],
                      'Suzuki'=>['Swift', 'Dreza'],
                      'Isusu'=>['MU5', 'MU7', 'MUX'],
                      'Honda'=>['City', 'Civic', 'Accord', 'HRV', 'Jazz'],
                      'Mitsubishi'=>['Pajero Sport'],
                      'Chevrolet'=>['Captiva'],
                      'Ford'=>['Fiesta'],
                      'BMW'=>['320I'],
                      'Nissan'=>['Almera']
      
                      ];
  
  protected $colors = ['Black', 'White', 'Grey', 'Red', 'Brown', 'Gold', 'Dark'];
  
  /**
   * format:  user,contract#,model,car#,time,start,finish,name,hotel,phone, paid ,agent,deposit,who,gas,comments,email
   */
  public function actionImport(){
    die();
    
    $file = __DIR__.'/contracts.csv';
    $f = fopen($file, 'r');
    while(!feof($f)){
      $str = fgets($f);
      $arr = $this->parseData($str);
      if ($arr){
        $this->save($arr);
      } else {
        echo("wrong: $str\n");
      }
    }
    fclose($f);
  }
  
  public function actionFindWrongContracts() {
    $contracts = Contract::find()->all();
    
    foreach ($contracts as $num=>$contract) {
      $date_start = $contract->date_start;
      //echo("id=$contract->id, date_start=$contract->date_start \n");
      $contracts2 = Contract::find()
                              ->where(['AND', "date_start<'".$date_start."'", 
                                              "date_stop>'".$date_start."'",
                                              "car_id=".$contract->car_id])
                              ->all();
                              //->createCommand()->rawSql;
      //echo($contracts2);
      //die;
      if ($contracts2) {
        foreach ($contracts2 as $num=>$cnt){
          echo("Contract #{$contract->id}, car_id={$contract->car_id}, date_start='$date_start' INSIDE contract #$cnt->id, car_id={$cnt->car_id} ($cnt->date_start - $cnt->date_stop) \n");
        }
      }
      // stop  
      $date_stop = $contract->date_stop;
      $contracts2 = Contract::find()->where(['AND', "date_start<'".$date_stop."'", 
                                                    "date_stop>'".$date_stop."'",
                                                    "car_id=".$contract->car_id
                                            ])
                                     ->all();
      if ($contracts2) {
        foreach ($contracts2 as $num=>$cnt){
          echo("Contract #{$contract->id}, car_id={$contract->car_id}, date_stop='$date_stop' INSIDE contract #$cnt->id, car_id={$cnt->car_id} ($cnt->date_start - $cnt->date_stop) \n");
        }
      }
    }
  }
    
  /**
   * 
   * @param string "user,contract#,model,car#,time, start,finish,name,hotel,phone, paid ,agent,deposit,who,gas,comments,email"
   * @return array
 */
  protected function parseData($str) {
    $arr = explode(';', $str);
    if (count($arr) < 16)
      return false;
    
    // бронь - нет paid, contract#, car# - пропускаем
    if (!$arr[1] && !$arr[3] && !$arr[10]) {
      echo("BOKING data \n");
      return;
    }
    
    return ['user'=>trim($arr[0]), 
            'contract_number'=>trim($arr[1]), 
            'car_number'=>trim($arr[3]),
            'model'=>trim($arr[2]),
            'time'=>trim($arr[4]),
            'date_start'=>trim($arr[5]),
            'date_stop'=>trim($arr[6]),
            'client_name'=>trim($arr[7]),
            'hotel'=>trim($arr[8]),
            'phone'=>trim($arr[9]),
            'comment'=>trim($arr[15]),
            'email'=>trim($arr[16]),
            'paid'=> preg_replace("/[^0-9]/", '', $arr[10])
            ];
  }
  
  /**
   * 
   * @param array $data []
   * 
   *  1. 
   *      если номер машины есть в БД - берем его
   *      ксли номера нет - добавляем в БД
   *      если номер пустой - id = 107 = ZORRO
   * КОнткракт  если есть - в поле number занести его
   *  2. если есть контракт + оплата, но нет машины - заносим NONAME
   */
  protected function save($data){
    $contract = new Contract();
    
    $contract->car_id = $this->saveCar($data);
    $contract->client_id = $this->saveClient($data);
    $this->saveContract($contract, $data);
    $this->savePayments($contract, $data);
  }
    
  /**
   * 
   * @param array $data[car_number, model]   
   * @return int
   */
  protected function saveCar($data){
    // HUCK 1111 -> id=107 ZORRO
    if (((int)$data['car_number'] == 0) || ($data['car_number'] == 1111)){
      $zorro_car = Car::findOne(['number'=>'Zorro']);
      if (!$zorro_car){
        $zorro_car = new Car();
        $zorro_car->number = 'Zorro';
        $zorro_car->save();
      }
      return $zorro_car->id;  
    }
    
      
    
    $car = Car::findOne(['number'=>(int)$data['car_number']]);
    if ($car) 
      return $car->id;
    
    $car = new Car();
    $car_data = $this->getCarDataFromString($data['model']);
    $car->number = (int)$data['car_number'];
    $car->mark = $car_data['mark'];
    $car->model = $car_data['model'];
    $car->color = $car_data['color'];
    $car->save();
    echo("Save new car ".$data['car_number']."\n");
    
    return $car->id;
  }
  
  /**
   * 
   * @param string $str
   * @return [mark, model, color]
 */
  protected function getCarDataFromString($str) {
    // find Model and try detect Mark
    $car_data = ['mark'=>'Unknown', 'model'=>'', 'color'=>''];
    foreach($this->models as $mark=>$models){
      foreach ($models as $model){
        if (strpos(strtolower($str), strtolower($model)) !== false){
          $car_data['mark'] = $mark;
          $car_data['model'] = ucfirst(strtolower($model));
          break;
        }
      }
    }
    
    // find color
    foreach($this->colors as $color){
      if (strpos(strtolower($str), strtolower($color)) !== false){
        $car_data['color'] = $color;
        break;
      }
    }
    return $car_data;
  }
  
  /**
   * 
   * @param type $data [client_name, phone, email]
   * @return type
   */
  protected function saveClient($data){
    // don't need save
    return 1;
  }
  
  /**
   * 
   * @param type $contract
   * @param type $data []
   * @return type
   */
  protected function saveContract($contract, $data){
    $contract->user_id =  $this->users[$data['user']];
    $contract->date_create = date('Y-m-d H:i:s');
    $contract->date_start = date('Y-m-d', strtotime($data['date_start']));
    $contract->date_stop = date('Y-m-d', strtotime($data['date_stop']));
    $contract->time = $data['time'];
    $contract->number = $data['contract_number'];
    $contract->description = $data['comment'];
    $contract->location = $data['hotel'];
    $contract->status = 2; // CLOSE

    $contract->save();
    return $contract->id;
  }
  
  protected function savePayments($contract, $data){
    $data_p = ['user_id'=>$contract->user_id, 'creator_id'=>$contract->user_id, 'date'=>$contract->date_start,
                  'date_create'=>date('Y-m-d H:i:s'), 'type_id'=>PaymentType::INCOMING,
                  'contract_id'=>$contract->id, 'car_id'=>$contract->car_id, 'status'=>Payment::STATUS_CONFIRMED];
      
    // rent payment
    $data_p['category_id'] = 2;
    $data_p['thb'] = $data['paid'];

    $payment = new Payment($data_p);
    $payment->save();

    return $payment->id;
  }
}