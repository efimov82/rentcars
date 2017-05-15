<?php

namespace backend\models;

use Yii;
use yii\db\ActiveRecord;

class Contract extends ActiveRecord
{
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
    
    public function isFinishSoon()
    {
      //echo("id={$this->id} stop=".strtotime($this->date_stop).", now=".strtotime(time()));
      //die();
      if ($this->status == 1)
        return ( (strtotime($this->date_stop) - time()) < 3600*24 );
      else
        return false;
    }
}