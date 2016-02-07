<?php
/**
 *
 * @author Geraldo Andrade <hi@geraldoandrade.com>
 * @date 2016-02-06
 */

// change the following paths if necessary
$yii = dirname(__FILE__) . '/../vendor/yiisoft/yii/framework/yii.php';
$config = dirname(__FILE__) . '/../application/config/main.php';

// remove the following line when in production mode

define('YII_DEBUG', getenv('YII_DEBUG') ? getenv('YII_DEBUG') : false);

require_once($yii);

$loader = require(__DIR__ . '/../vendor/autoload.php');
Yii::$classMap = $loader->getClassMap();
Yii::createWebApplication($config)->run();