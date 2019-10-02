<?php

namespace Preprocess\MovedPermanently;

use Preprocess\PreprocessorInterface;

class MovedPermanentlyResolver implements PreprocessorInterface
{
    /**
     * @var array
     */
    private $redirectionTable;

    public function __construct($redirectionTable)
    {
        $this->redirectionTable = $redirectionTable;
    }

    public function process($requestUri)
    {
        $lastPathItem = $this->getLastPathItem($requestUri);

        if (array_key_exists($lastPathItem, $this->redirectionTable)) {
            $this->performRedirection(str_replace($lastPathItem, $this->redirectionTable[$lastPathItem], $requestUri));
        }
    }

    private function getLastPathItem($path)
    {
        $items = explode('/', trim($path,'/'));

        return $items[sizeof($items) - 1];
    }

    private function performRedirection($url)
    {
        header("HTTP/1.1 301 Moved Permanently");
        header("Location: " . $url);
        exit();
    }
}
