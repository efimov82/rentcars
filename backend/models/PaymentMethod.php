<?php
namespace backend\models;

use yii\db\ActiveRecord;

class PaymentMethod extends ActiveRecord {
  /**
  * @inheritdoc
  */
  public static function tableName(){
      return 'payments_method';
  }

}