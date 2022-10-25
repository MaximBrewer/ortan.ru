<?php
namespace Cache;
class File {
	private $expire;


	private function recursiveGlob($startDir, $fileMask) {
		$found = glob($startDir.DIRECTORY_SEPARATOR.$fileMask);
		$dirs  = glob($startDir.DIRECTORY_SEPARATOR."*", GLOB_ONLYDIR);
		foreach ($dirs as $dir) $found = array_merge($found, $this->recursiveGlob($dir, $fileMask));
		return $found;
	}


	public function __construct($expire = 3600) {
		$this->expire = $expire;

		$files = $this->recursiveGlob(DIRECTORY_SEPARATOR.trim(DIR_CACHE,DIRECTORY_SEPARATOR), '*');

		if ($files) {
			foreach ($files as $file) {
				if(is_file($file)){
					$filename = basename($file);

					$time = substr(strrchr($file, '.'), 1);

					if ($time < time()) {
						$this->delete(substr($filename, 6, strrpos($filename, '.') - 6));
					}
				}
			}
		}
	}

	public function get($key) {
		$key = str_replace('.', '/', $key);
		$files = glob(DIR_CACHE . preg_replace('/[^\/A-Z0-9\._-]/i', '', $key) . '.*');
		if ($files) {

			$handle = fopen($files[0], 'r');

			flock($handle, LOCK_SH);

			$size = filesize($files[0]);

			if ($size > 0) {
				$data = fread($handle, $size);
			} else {
				$data = '';
			}

			flock($handle, LOCK_UN);

			fclose($handle);

			return json_decode($data, true);
		}

		return false;
	}

	public function set($key, $value) {
		$key = str_replace('.', '/', $key);
		$this->delete($key);
		@mkdir(dirname(DIR_CACHE  . $key), 0755, true);
		$file = DIR_CACHE  . $key . '.' . (time() + $this->expire);

		$handle = fopen($file, 'w');

		flock($handle, LOCK_EX);

		fwrite($handle, json_encode($value));

		fflush($handle);

		flock($handle, LOCK_UN);

		fclose($handle);
	}

	public function delete(string $key): void {
		$key = str_replace('.', '/', $key);
		$files = glob(DIR_CACHE . $key . '.*');

		if ($files) {
			foreach ($files as $file) {
				if (!@unlink($file)) {
					clearstatcache(false, $file);
				}
			}
		}
	}
}