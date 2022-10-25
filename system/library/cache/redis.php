<?php
namespace Cache;
class Redis {
	private $expire;
	private $cache;

	public function __construct($expire) {
		
		$this->expire = $expire;

		$this->cache = new \Redis();
		$this->cache->pconnect(CACHE_HOSTNAME, CACHE_PORT);
		$this->cache->auth('sdKUHBGVF7868gd');
	}

	public function get($key) {

        if ($this->cache->exists(CACHE_PREFIX . $key)) {
			$data = $this->cache->get(CACHE_PREFIX . $key);
			return json_decode($data, true);
		}
		
		return false;
	}

	public function set($key, $value, $expire = '') {
		if (!$expire) {
			$expire = $this->expire;
		}

		$status = $this->cache->set(CACHE_PREFIX . $key, json_encode($value));

		if ($status) {
			$this->cache->expire(CACHE_PREFIX . $key, $expire);
		}

		return $status;
	}

	public function delete($key) {
		$keys = $this->cache->keys(CACHE_PREFIX . $key . '*');
		$this->cache->del($keys);
	}

	public function flushall() {
		$this->cache->flushall();
	}
}