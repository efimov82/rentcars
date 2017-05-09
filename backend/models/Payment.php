<?php

namespace backend\models;

use yii\db\ActiveRecord;

class Payment extends ActiveRecord
{
  const STATE_NEW     = 1;
  const STATE_CONFIRM = 2;
  /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'payments';
    }
}