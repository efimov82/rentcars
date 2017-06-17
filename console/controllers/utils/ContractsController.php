<?php

namespace console\controllers\utils;

use Yii;
use yii\console\Controller;
use backend\models\Contract;
use backend\models\Car;
use backend\models\Payment;
use backend\models\PaymentType;
use backend\models\Customer;
use backend\models\Place;
use backend\models\Area;


/**
 * Import contracts -  php yii utils/contracts/import
 */
class ContractsController extends Controller {
  protected $users = [''=>4, 'T'=>4, 'B'=>5, 'D'=>6, 'P'=>7, 'A'=>8, 'M'=>9, 'Т'=>4, 'Th'=>4, 'K'=>29];
  
//  protected $models = ['Toyota'=>['Vios', 'Altis', 'Fortuner', 'Innova', 'Yaris'],
//                      'Suzuki'=>['Swift', 'Dreza'],
//                      'Isusu'=>['MU5', 'MU7', 'MUX'],
//                      'Honda'=>['City', 'Civic', 'Accord', 'HRV', 'Jazz'],
//                      'Mitsubishi'=>['Pajero Sport'],
//                      'Chevrolet'=>['Captiva'],
//                      'Ford'=>['Fiesta'],
//                      'BMW'=>['320I'],
//                      'Nissan'=>['Almera']
//      
//                      ];
//  
//  protected $colors = ['Black', 'White', 'Grey', 'Red', 'Brown', 'Gold', 'Dark'];
  
  /**
   * format:  IMPORT[0,1],manager,contract#, ,car#,data_start,data_stop,name,passport #,phone_h,second_m,email,hotel,place
   * 
   * Example: 
   * 1,B,02672,  7 000   ,4375,17.09.2016,24.09.2016,Ivan Ivanov,71637202,79135383786,,ivan_stroy@mail.ru,Alamanda Laguna Phuket,Laguna
   */
  public function actionImport(){
    die();
    
    $file = __DIR__.'/data/contracts_17.06.csv';
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
  
  /*public function actionFindWrongContracts() {
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
  }*/
    
  /**
   * 
   * @param string "1,B,02672,  7 000   ,4375,17.09.2016,24.09.2016,Ivan Ivanov,71637202,79135383786,,ivan_stroy@mail.ru,Alamanda Laguna Phuket,Laguna"
   * @return array [user, contract_number, car_number, date_start, date_stop, client_name, hotel, phone_h, phone_m, comment, email, paid]
 */
  protected function parseData($str) {
    $arr = explode(',', $str);
    if (count($arr) != 14)
      return false;
    
    if (!$arr[0]) {
      echo("skip data \n");
      return;
    }
    
    return ['user'=>trim($arr[1]), 
            'contract_number'=>trim($arr[2]), 
            'car_number'=>trim($arr[4]),
            'date_start'=>trim($arr[5]),
            'date_stop'=>trim($arr[6]),
            'client_name'=>trim($arr[7]),
            'passport'=>trim($arr[8]),
            'hotel'=>trim($arr[12]),
            'phone_h'=>trim($arr[9]),
            'phone_m'=>trim($arr[10]),
            'comment'=>trim($arr[13]),
            'email'=>trim($arr[11]),
            'paid'=> preg_replace("/[^0-9]/", '', $arr[3])
            ];
  }
  
  /**
   * 
   * @param array $data [user, contract_number, car_number, date_start, date_stop, client_name, hotel, phone_h, phone_m, comment, paid]
   * 
   */
  protected function save($data){
    $contract = new Contract();
    
    $contract->car_id = $this->saveCar($data);
    $contract->client_id = $this->saveClient($data);
    $contract->place_id = $this->savePlace($data);
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
//    if (((int)$data['car_number'] == 0) || ($data['car_number'] == 1111)){
//      $zorro_car = Car::findOne(['number'=>'Zorro']);
//      if (!$zorro_car){
//        $zorro_car = new Car();
//        $zorro_car->number = 'Zorro';
//        $zorro_car->save();
//      }
//      return $zorro_car->id;  
//    }
    
    $car = Car::findOne(['number'=>(int)$data['car_number']]);
    if ($car) 
      return $car->id;
    
    $car = new Car();
    //$car_data = $this->getCarDataFromString($data['model']);
    $car->number = (int)$data['car_number'];
    //$car->mark = $car_data['mark'];
    //$car->model = $car_data['model'];
    //$car->color = $car_data['color'];
    $car->save();
    echo("Save new car ".$data['car_number']."\n");
    
    return $car->id;
  }
  
  /**
   * 
   * @param array $data [hotel, comment]
   */
  protected function savePlace($data) {
    $place = Place::findOne(['name'=>$data['hotel']]);
    if (!$place) {
      $area = Area::findOne(['name'=>$data['comment']]);
      if (!$area) {
        $area = new Area();
        $area->name = $data['comment'];
        $area->save();
      }
      
      $place = new Place();
      $place->name = $data['hotel'];
      $place->type_id = 1; // hotel
      $place->city_id = 1; // Phuket
      $place->area_id = $area->id;
      $place->save();
    }
    
    return $place->id;
  }


  /**
   * 
   * @param string $str
   * @return [mark, model, color]
 */
  /*protected function getCarDataFromString($str) {
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
  }*/
  
  /**
   * 
   * @param type $data [user, contract_number, car_number, date_start, date_stop, client_name, passport, hotel, phone_h, phone_m, comment, paid]
   * @return type
   */
  protected function saveClient($data){
    $customer = Customer::findOne(['passport'=>trim($data['passport'])]);
    if ($customer)
      return $customer->id;
    
    $customer = new Customer();
    $customer->f_name = $data['client_name'];
    $customer->passport = $data['passport'];
    $customer->phone_m = $data['phone_m'];
    $customer->phone_h = $data['phone_h'];
    $customer->email = $data['email'];
    
    $customer->save();
    return $customer->id;
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
    //$contract->time = $data['time'];
    $contract->number = $data['contract_number'];
    //$contract->description = $data['comment'];
    //$contract->location = $data['hotel'];
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