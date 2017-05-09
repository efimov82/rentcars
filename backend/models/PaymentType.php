<?php

namespace backend\models;

use yii\db\ActiveRecord;

class PaymentType extends ActiveRecord
{
  const INCOMING = 1;
  const OUTGOING = 2;
  
  /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'payments_types';
    }
}