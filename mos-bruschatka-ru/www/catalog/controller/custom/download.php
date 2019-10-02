<?php

class ControllerCustomDownload extends Controller
{
    const CONFIG_PATH = DIR_APPLICATION . 'resources/config/download.json';
    const DOWNLOADS_DIRECTORY = DIR_ASSETS . 'downloads/';

    public function index()
    {
        $hostname = $_SERVER['HTTP_HOST'];
        $type = $this->request->get['type'];
        $config = json_decode(file_get_contents(self::CONFIG_PATH));

        try {
            $this->performFileResponse(self::DOWNLOADS_DIRECTORY . $config->{$type}->{$hostname});
        } catch(Throwable $exception) {
            $this->performBadRequestResponse();
        }
    }

    /**
     * @param string $filePath
     * @throws Exception
     */
    private function performFileResponse($filePath)
    {
        if (is_file($filePath)) {
            if (ob_get_level()) {
                ob_end_clean();
            }

            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename=' . basename($filePath));
            header('Content-Transfer-Encoding: binary');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . filesize($filePath));

            readfile($filePath);

            exit;
        } else {
            throw new Exception("Unable to get file");
        }
    }

    private function performBadRequestResponse()
    {
        http_response_code(400);

        exit;
    }
}
