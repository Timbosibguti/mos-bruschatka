<?php

class ModelExtensionModuleAccubackup extends Model
{
    
    /**
     * Check validate scheduled status
     * 
     * @param array() $settings 
     * 
     * @return boolean 
     */
    public function validateScheduled($settings)
    {
        $status = false;

        if (!empty($settings) && $settings['Enabled'] == 'yes') {
            $current_time = time();
            if (($current_time - strtotime($settings['nextSchedule'])) >= 0) {
                $status = true;
            }
        }

        return $status;
    }

    /**
     * Get all database tables
     * 
     * @return string 
     */
    public function getTables()
    {
        $tables = array();
        $query = $this->db->query("SHOW TABLES FROM `" . DB_DATABASE . "`");

        foreach ($query->rows as $result) {
            $tables[] = $result['Tables_in_' . DB_DATABASE];
        }

        $output = '';

        foreach ($tables as $table) {
            $table_drop = "DROP TABLE IF EXISTS " . $table . ";\n";
            $row2 = $result = $this->db->query('SHOW CREATE TABLE ' . $table);
            $output .= "\n\n" . $table_drop . "\n\n" . $row2->row['Create Table'] . ";\n\n";

            $query = $this->db->query("SELECT * FROM `" . $table . "`");

            foreach ($query->rows as $result) {
                $fields = '';

                foreach (array_keys($result) as $value) {
                    $fields .= '`' . $value . '`, ';
                }

                $values = '';
                foreach (array_values($result) as $value) {
                    $value = str_replace(array("\x00", "\x0a", "\x0d", "\x1a"), array('\0', '\n', '\r', '\Z'), $value);
                    $value = str_replace(array("\n", "\r", "\t"), array('\n', '\r', '\t'), $value);
                    $value = str_replace('\\', '\\\\', $value);
                    $value = str_replace('\'', '\\\'', $value);
                    $value = str_replace('\\\n', '\n', $value);
                    $value = str_replace('\\\r', '\r', $value);
                    $value = str_replace('\\\t', '\t', $value);

                    $values .= '\'' . $value . '\', ';
                }
                $output .= 'INSERT INTO `' . $table . '` (' . preg_replace('/, $/', '', $fields) . ') VALUES (' . preg_replace('/, $/', '', $values) . ');' . "\n";
            }
            $output .= "\n\n";
        }

        return $output;
    }
    
    /**
     * Next schedule date & time
     * 
     * @param string   $schedule     schedule option
     * @param DateTime $lastSchedule Last backup datetime (Y-m-d H:i:s)
     * 
     * @return DateTime 
     */
    public function getNextBackupSchedule($schedule, $lastSchedule)
    {
        $time = ($lastSchedule) ? strtotime($lastSchedule) : time();

        switch ($schedule) {
        case "test_now":
            $nextSchedule = date("Y-m-d H:i:s", strtotime("+2 minutes", $time));
            break;
        case "daily":
            $nextSchedule = date("Y-m-d H:i:s", strtotime("+1 day", $time));
            break;
        case "every_other_day":
            $nextSchedule = date("Y-m-d H:i:s", strtotime("+2 day", $time));
            break;
        case 'weekly':
            $nextSchedule = date("Y-m-d H:i:s", strtotime("+1 week", $time));
            break;
        case 'fortnightly':
            $nextSchedule = date("Y-m-d H:i:s", strtotime("+2 weeks", $time));
            break;
        case 'monthly':
            $nextSchedule = date("Y-m-d H:i:s", strtotime("+1 month", $time));
            break;
        default:
            $nextSchedule = "2000-01-01 00:00:00";
            break;
        }

        return $nextSchedule;
    }

    /**
     * Create sql backup file
     * 
     * @param string $directory Backup directory
     * @param string $filename  Name of file
     * @param string $data      SQL Table Statements
     * 
     * @return null 
     */
    public function createSql($directory, $filename, $data)
    {
        if (!is_dir($directory)) {
            mkdir($directory, 0777);
            chmod($directory, 0777);
            @touch($directory . DIRECTORY_SEPARATOR . 'index.html');
        }

        $file = $directory . $filename;
        $handle = fopen($file, 'w');
        fwrite($handle, $data);
        fclose($handle);
    }

    /**
     * Create a zip of sql file
     * 
     * @param string $directory Backup directory
     * @param string $filename  Name of file
     * 
     * @return string 
     */
    public function createBackupZip($directory, $filename)
    {
        $data = array();

        $zipname = $directory . $filename . '.zip';
        if (class_exists('ZipArchive')) {
            $zip = new ZipArchive;
            if ($zip->open($zipname, ZipArchive::CREATE) === true) {
                $zip->addFile($directory . $filename, $filename);
                $zip->close();
                @unlink($directory . $filename);
                if (is_file($zipname)) {
                    $data = array(
                        'filename' => basename($zipname),
                        'code' => $this->generateCode(),
                        'size' => $this->formatBytes(filesize($zipname))
                    );
                }
            }
        }

        return $data;
    }
    
    /**
     * Get stored backup from database
     * 
     * @return array() 
     */
    public function getBackup()
    {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "accubackup ORDER BY backup_id DESC");
        return $query->rows;
    }

    /**
     * Insert backup record into database
     * 
     * @param array() $data 
     * 
     * @return string 
     */
    public function insertBackup($data)
    {
        $this->db->query("INSERT INTO " . DB_PREFIX . "accubackup SET filename = '" . $this->db->escape($data['filename']) . "', code = '" . $this->db->escape($data['code']) . "', size = '" . $this->db->escape($data['size']) . "', date_created = '" . $this->db->escape($data['date_created']) . "'");
    }

      
    /**
     * Delete stored backup
     * 
     * @param string $file Name of file
     * @param int    $id   Backup ID
     * 
     * @return null 
     */
    public function deleteBackup($file, $id)
    {
        if (file_exists($file)) {
            if (unlink($file)) {
                $this->db->query("DELETE FROM " . DB_PREFIX . "accubackup WHERE backup_id = '" . (int) $id . "'");
            }
        }
    }

    /**
     * Generate Unique Code
     * 
     * @param int $length Code Length
     * 
     * @return string 
     */
    protected function generateCode($length = 12)
    {
        $string = "abcdefghijklmnopqrstuwxyzABCDEFGHIJKLMNOPQRSTUWXYZ0123456789";
        $pass = array();
        $stringLength = strlen($string) - 1;
        for ($i = 0; $i < $length; $i++) {
            $n = rand(0, $stringLength);
            $pass[] = $string[$n];
        }
        return implode($pass);
    }

     /**
      * Convert Bytes to KB, MB & GB
      * 
      * @param string $size File size into Bytes
      * 
      * @return string 
      */
    protected function formatBytes($size)
    {
        if ($size >= 1048576 * 1024) {
            $resize = number_format(($size / 1048576 / 1024), 1) . ' GB';
        } elseif ($size >= 1048576) {
            $resize = number_format(($size / 1048576), 1) . ' MB';
        } elseif ($size >= 1024) {
            $resize = number_format(($size / 1024), 1) . ' KB';
        } else {
            $resize = $size . ' bytes';
        }
        return $resize;
    }

    /**
     * Optimize PHP Configuration
     * 
     * @return null 
     */
    public function optimizeConfiguration()
    {

        $memLimit = ini_get('memory_limit');
        if (substr($memLimit, -1) == 'M') {
            $memLimit = (substr($memLimit, 0, -1) * 1024 * 1024);
        }
        $memLimit = $memLimit / 1024 / 1024;

        if ($memLimit < 256) {
            ini_set('memory_limit', '256M');
        }

        ini_set('max_execution_time', 600);
    }
}
