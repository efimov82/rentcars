<?php

namespace backend\models;

use Yii;
use yii\db\ActiveRecord;

class Contract extends ActiveRecord{
  public  $statuses = [1=>'Open', 2=>'Closed'];
  public  $car_number = 0;
  
  /**
    * @inheritdoc
    */
  public static function tableName(){
    return 'contracts';
  }
    
  public function getStatusName(){
    if (isset($this->statuses[$this->status])){
      return $this->statuses[$this->status];
    }else{
      return 'unknown';
    }
  }
    
  public function isFinishSoon(){
    if ($this->status == 1)
      return ( (strtotime($this->date_stop) - time()) < 3600*24 );
    else
      return false;
  }
  
  public function setPhotos($mixed){
    if (is_array($mixed))
      $this->photos = implode(';', $mixed);
    else
      $this->photos = $mixed;
  }
  
  public function getPhotos(){
    return explode(';', $this->photos);
  }
}