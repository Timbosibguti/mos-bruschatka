<?php

namespace Preprocess;

interface PreprocessorInterface
{
    /**
     * @param $param
     * @return mixed
     */
    public function process($param);
}
