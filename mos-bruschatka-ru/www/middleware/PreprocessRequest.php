<?php

include 'Preprocess/PreprocessorInterface.php';
include 'Preprocess/MovedPermanently/MovedPermanentlyResolver.php';

use Preprocess\MovedPermanently\MovedPermanentlyResolver;

try {
    $redirectionTable = json_decode(file_get_contents(__DIR__ . '/Config/Preprocess/MovedPermanently/config.json'), true);

    (new MovedPermanentlyResolver($redirectionTable))->process($_SERVER['REQUEST_URI']);
} catch (Throwable $exception) {
    /*_*/
}


/*
 * Todo: Use Symfony DI
 */
