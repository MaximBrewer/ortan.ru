<?php
ini_set('memory_limit', '512M');

//developer's tool
class laChromePhp
{
    /**
     * @var string
     */
    const VERSION = '4.1.0';
    /**
     * @var string
     */
    const HEADER_NAME = 'X-ChromeLogger-Data';
    /**
     * @var string
     */
    const BACKTRACE_LEVEL = 'backtrace_level';
    /**
     * @var string
     */
    const LOG = 'log';
    /**
     * @var string
     */
    const WARN = 'warn';
    /**
     * @var string
     */
    const ERROR = 'error';
    /**
     * @var string
     */
    const GROUP = 'group';
    /**
     * @var string
     */
    const INFO = 'info';
    /**
     * @var string
     */
    const GROUP_END = 'groupEnd';
    /**
     * @var string
     */
    const GROUP_COLLAPSED = 'groupCollapsed';
    /**
     * @var string
     */
    const TABLE = 'table';
    /**
     * @var string
     */
    protected $_php_version;
    /**
     * @var int
     */
    protected $_timestamp;
    /**
     * @var array
     */
    protected $_json = array(
        'version' => self::VERSION,
        'columns' => array('log', 'backtrace', 'type'),
        'rows' => array()
    );
    /**
     * @var array
     */
    protected $_backtraces = array();
    /**
     * @var bool
     */
    protected $_error_triggered = false;
    /**
     * @var array
     */
    protected $_settings = array(
        self::BACKTRACE_LEVEL => 1
    );
    /**
     * @var ChromePhp
     */
    protected static $_instance;
    /**
     * Prevent recursion when working with objects referring to each other
     *
     * @var array
     */
    protected $_processed = array();
    /**
     * constructor
     */
    private function __construct()
    {
        $this->_php_version = phpversion();
        $this->_timestamp = $this->_php_version >= 5.1 ? $_SERVER['REQUEST_TIME'] : time();
        $this->_json['request_uri'] = $_SERVER['REQUEST_URI'];
    }
    /**
     * gets instance of this class
     *
     * @return ChromePhp
     */
    public static function getInstance()
    {
        if (self::$_instance === null) {
            self::$_instance = new self();
        }
        return self::$_instance;
    }
    /**
     * logs a variable to the console
     *
     * @param mixed $data,... unlimited OPTIONAL number of additional logs [...]
     * @return void
     */
    public static function log()
    {
        $args = func_get_args();
        return self::_log('', $args);
    }
    /**
     * logs a warning to the console
     *
     * @param mixed $data,... unlimited OPTIONAL number of additional logs [...]
     * @return void
     */
    public static function warn()
    {
        $args = func_get_args();
        return self::_log(self::WARN, $args);
    }
    /**
     * logs an error to the console
     *
     * @param mixed $data,... unlimited OPTIONAL number of additional logs [...]
     * @return void
     */
    public static function error()
    {
        $args = func_get_args();
        return self::_log(self::ERROR, $args);
    }
    /**
     * sends a group log
     *
     * @param string value
     */
    public static function group()
    {
        $args = func_get_args();
        return self::_log(self::GROUP, $args);
    }
    /**
     * sends an info log
     *
     * @param mixed $data,... unlimited OPTIONAL number of additional logs [...]
     * @return void
     */
    public static function info()
    {
        $args = func_get_args();
        return self::_log(self::INFO, $args);
    }
    /**
     * sends a collapsed group log
     *
     * @param string value
     */
    public static function groupCollapsed()
    {
        $args = func_get_args();
        return self::_log(self::GROUP_COLLAPSED, $args);
    }
    /**
     * ends a group log
     *
     * @param string value
     */
    public static function groupEnd()
    {
        $args = func_get_args();
        return self::_log(self::GROUP_END, $args);
    }
    /**
     * sends a table log
     *
     * @param string value
     */
    public static function table()
    {
        $args = func_get_args();
        return self::_log(self::TABLE, $args);
    }
    /**
     * internal logging call
     *
     * @param string $type
     * @return void
     */
    protected static function _log($type, array $args)
    {
        // nothing passed in, don't do anything
        if (count($args) == 0 && $type != self::GROUP_END) {
            return;
        }
        $logger = self::getInstance();
        $logger->_processed = array();
        $logs = array();
        foreach ($args as $arg) {
            $logs[] = $logger->_convert($arg);
        }
        $backtrace = debug_backtrace(false);
        $level = $logger->getSetting(self::BACKTRACE_LEVEL);
        $backtrace_message = 'unknown';
        if (isset($backtrace[$level]['file']) && isset($backtrace[$level]['line'])) {
            $backtrace_message = $backtrace[$level]['file'] . ' : ' . $backtrace[$level]['line'];
        }
        $logger->_addRow($logs, $backtrace_message, $type);
    }
    /**
     * converts an object to a better format for logging
     *
     * @param Object
     * @return array
     */
    protected function _convert($object)
    {
        // if this isn't an object then just return it
        if (!is_object($object)) {
            return $object;
        }
        //Mark this object as processed so we don't convert it twice and it
        //Also avoid recursion when objects refer to each other
        $this->_processed[] = $object;
        $object_as_array = array();
        // first add the class name
        $object_as_array['___class_name'] = get_class($object);
        // loop through object vars
        $object_vars = get_object_vars($object);
        foreach ($object_vars as $key => $value) {
            // same instance as parent object
            if ($value === $object || in_array($value, $this->_processed, true)) {
                $value = 'recursion - parent object [' . get_class($value) . ']';
            }
            $object_as_array[$key] = $this->_convert($value);
        }
        $reflection = new ReflectionClass($object);
        // loop through the properties and add those
        foreach ($reflection->getProperties() as $property) {
            // if one of these properties was already added above then ignore it
            if (array_key_exists($property->getName(), $object_vars)) {
                continue;
            }
            $type = $this->_getPropertyKey($property);
            if ($this->_php_version >= 5.3) {
                $property->setAccessible(true);
            }
            try {
                $value = $property->getValue($object);
            } catch (ReflectionException $e) {
                $value = 'only PHP 5.3 can access private/protected properties';
            }
            // same instance as parent object
            if ($value === $object || in_array($value, $this->_processed, true)) {
                $value = 'recursion - parent object [' . get_class($value) . ']';
            }
            $object_as_array[$type] = $this->_convert($value);
        }
        return $object_as_array;
    }
    /**
     * takes a reflection property and returns a nicely formatted key of the property name
     *
     * @param ReflectionProperty
     * @return string
     */
    protected function _getPropertyKey(ReflectionProperty $property)
    {
        $static = $property->isStatic() ? ' static' : '';
        if ($property->isPublic()) {
            return 'public' . $static . ' ' . $property->getName();
        }
        if ($property->isProtected()) {
            return 'protected' . $static . ' ' . $property->getName();
        }
        if ($property->isPrivate()) {
            return 'private' . $static . ' ' . $property->getName();
        }
        return '';
    }

    /**
     * adds a value to the data array
     *
     * @var mixed
     * @return void
     */
    protected function _addRow(array $logs, $backtrace, $type)
    {
        // if this is logged on the same line for example in a loop, set it to null to save space
        if (in_array($backtrace, $this->_backtraces)) {
            $backtrace = null;
        }
        // for group, groupEnd, and groupCollapsed
        // take out the backtrace since it is not useful
        if ($type == self::GROUP || $type == self::GROUP_END || $type == self::GROUP_COLLAPSED) {
            $backtrace = null;
        }
        if ($backtrace !== null) {
            $this->_backtraces[] = $backtrace;
        }
        $row = array($logs, $backtrace, $type);
        $this->_json['rows'][] = $row;
        $this->_writeHeader($this->_json);
    }
    protected function _writeHeader($data)
    {
        header(self::HEADER_NAME . ': ' . $this->_encode($data));
    }
    /**
     * encodes the data to be sent along with the request
     *
     * @param array $data
     * @return string
     */
    protected function _encode($data)
    {
        return base64_encode(utf8_encode(json_encode($data)));
    }
    /**
     * adds a setting
     *
     * @param string key
     * @param mixed value
     * @return void
     */
    public function addSetting($key, $value)
    {
        $this->_settings[$key] = $value;
    }
    /**
     * add ability to set multiple settings in one call
     *
     * @param array $settings
     * @return void
     */
    public function addSettings(array $settings)
    {
        foreach ($settings as $key => $value) {
            $this->addSetting($key, $value);
        }
    }
    /**
     * gets a setting
     *
     * @param string key
     * @return mixed
     */
    public function getSetting($key)
    {
        if (!isset($this->_settings[$key])) {
            return null;
        }
        return $this->_settings[$key];
    }
}
Class la
{
    public static $isActive = false;
    public static $logFilename = 'la.log';
    public static $logPath = '';
    private static $aTimes = [];
    private static $FP = '';

    public static function init()
    {
        if (defined('DIR_LOGS')){
            self::$logPath = DIR_LOGS;
        } else{
            self::$logPath = __DIR__.DIRECTORY_SEPARATOR.'system'.DIRECTORY_SEPARATOR.'storage'.DIRECTORY_SEPARATOR.'logs'.DIRECTORY_SEPARATOR;
        }
        self::$logFilename = 'la-' . date('Y-m-d') . '.log';

        if (isset($_SERVER['REMOTE_ADDR']) and in_array($_SERVER['REMOTE_ADDR'], ['45.93.158.34', '127.0.0.1'])){
            if (strpos($_SERVER['HTTP_USER_AGENT'], 'Chrome') !== false) {
                self::$isActive = true;

                error_reporting(E_ALL);
                //error_reporting(E_ALL & ~E_DEPRECATED & ~E_NOTICE & ~E_WARNING);
                ini_set('display_errors', 1);
            }
            ob_start();

            self::start();
            self::display(self::$logPath. self::$logFilename);
        } else {
            ini_set('display_errors', 0);
            self::$isActive = false;
        }
    }

    private static function bytes($size)
    {
        $unit = array('b', 'kb', 'mb', 'gb', 'tb', 'pb');
        $i = intval(log($size, 1024));
        return round($size / pow(1024, $i), 2) . ' ' . $unit[$i];
    }

    public static function start($name = 'main')
    {
        if (self::$isActive) {
            $m = explode(' ', microtime());
            self::$aTimes[$name] = ($m[1] + $m[0]) * 1000;
        }
    }

    public static function stop($name = 'main', $isDisplay = true, $isLog = false, $isDel = false)
    {
        $res = '';
        if (self::$isActive and isset(self::$aTimes[$name])) {
            if ($name == 'main') {
                if ($isLog) self::log(self::bytes(memory_get_usage()), 'Memory');
            }
            $m = explode(' ', microtime());
            $res = round(($m[1] + $m[0]) * 1000 - self::$aTimes[$name], 2);
            if ($isDisplay) self::display($res . ' ms', 'Time ' . $name);
            if ($isLog) self::log($res . ' ms', 'Time ' . $name);
            if ($isDel) unset(self::$aTimes[$name]);
        }
        return $res;
    }

    public static function display($var, $lbl = '')
    {
        if (self::$isActive) {
           laChromePhp::log($lbl. ':', $var);
        }
    }

    public static function save($msg, $fileName = '')
    {
        if (!$fileName) $fileName = self::$logFilename;
        $logFile = self::$logPath . $fileName;

        $f = fopen($logFile, 'a+');
        $txt = "\r\n--------------------------------\r\n";
        $txt .= date('Y-m-d H:i:s') . "\r\n";
        $txt .= $msg . "\r\n";

        fwrite($f, $txt);
        fclose($f);
    }
    public static function clean($fileName = '')
    {
        if (!$fileName) $fileName = self::$logFilename;
        $logFile = self::$logPath . $fileName;

        unlink($logFile);
    }

    public static function log($msg, $type = '')
    {
        $saved = 0;

        $ip = isset($_SERVER['REMOTE_ADDR']) ? $_SERVER['REMOTE_ADDR'] : '';
        $browser = isset($_SERVER['HTTP_USER_AGENT']) ? substr($_SERVER['HTTP_USER_AGENT'], 0, 250) : '';
        $request = isset($_SERVER['REQUEST_URI']) ? substr($_SERVER['REQUEST_URI'], 0, 250) : '';

        if (!$saved) {
            $log = '
------------------------------------------
date: ' . date('Y-m-d H:i:s') . '
request: ' . $request . '
ip: ' . $ip . '
browser: ' . $browser . '
type: ' . $type . '
' . $msg ;

            $f = fopen(self::$logPath. self::$logFilename, 'a+');
            fwrite($f, $log);
            fclose($f);
        }
    }
}
\la::init();
if (isset($_SERVER['REQUEST_URI'])) \la::display('-start-'.$_SERVER['REQUEST_URI']);