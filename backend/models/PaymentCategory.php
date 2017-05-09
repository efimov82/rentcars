<?php

namespace backend\models;

use yii\db\ActiveRecord;

class PaymentCategory extends ActiveRecord
{
  /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'payments_categories';
    }
}