<?php

namespace backend\models;

use Yii;
use yii\db\ActiveRecord;

class Car extends ActiveRecord
{
  public static  $statuses = [1=>'available', 2=>'leased', 3=>'booked', 4=>'under repair', 5=>'unavailable'];
  /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'cars';
    }
    
    public function getStatusName()
    {
      return self::$statuses[$this->status];
    }
}