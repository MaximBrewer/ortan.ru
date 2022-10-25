<?php
class ControllerCommonFlushall extends Controller {
	public function index() {
        $this->cache->flushall();
        $this->session->data['success'] = 'Кэш очищен!';
        $this->response->redirect('/admin/index.php?route=' . $this->session->data['redirect'] . '&token=' . $this->session->data['token']);
    }
}