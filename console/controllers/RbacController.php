<?php
namespace console\controllers;

use Yii;
use yii\console\Controller;
/**
 * Инициализатор RBAC выполняется в консоли php yii rbac/init
 */
class RbacController extends Controller {

    public function actionInit() {
        $auth = Yii::$app->authManager;
        
        $auth->removeAll(); //На всякий случай удаляем старые данные из БД...
        
        // Создадим роли админа и редактора новостей
        $admin = $auth->createRole('admin');
        $manager = $auth->createRole('manager');
        
        // запишем их в БД
        $auth->add($admin);
        $auth->add($manager);
        
        // Создаем наше правило, которое позволит проверить автора новости
        //$authorRule = new \app\rbac\AuthorRule;
        
        // Запишем его в БД
        //$auth->add($authorRule);
        
        // Создаем разрешения. Например, просмотр админки viewAdminPage и редактирование новости updateNews
        //$viewAdminPage = $auth->createPermission('viewAdminPage');
        //$viewAdminPage->description = 'Просмотр админки';
        
        $updateCars = $auth->createPermission('updateCars');
        $updateCars->description = 'Edit car';
        
        // Создадим еще новое разрешение «Редактирование собственной новости» и ассоциируем его с правилом AuthorRule
        //$updateOwnNews = $auth->createPermission('updateOwnNews');
        //$updateOwnNews->description = 'Редактирование собственной новости';
        
        // Указываем правило AuthorRule для разрешения updateOwnNews.
        //$updateOwnNews->ruleName = $authorRule->name;
        
        // Запишем эти разрешения в БД
        //$auth->add($viewAdminPage);
        $auth->add($updateCars);
        //$auth->add($updateOwnNews);
        
        // Теперь добавим наследования. Для роли editor мы добавим разрешение updateNews,
        // а для админа добавим наследование от роли editor и еще добавим собственное разрешение viewAdminPage
        
        // Роли «Редактор новостей» присваиваем разрешение «Редактирование новости»
        //$auth->addChild($editor,$updateOwnNews);

        // админ наследует роль редактора новостей. Он же админ, должен уметь всё! :D
        $auth->addChild($admin, $updateCars);
        
        // Еще админ имеет собственное разрешение - «Просмотр админки»
        //$auth->addChild($admin, $viewAdminPage);

        // Назначаем роль admin пользователю с ID 1
        $auth->assign($admin, 1); 
        
        // Назначаем роль editor пользователю с ID 2
        $auth->assign($editor, 2);
    }
}