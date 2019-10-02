<?php

abstract class BaseAdminModuleController extends Controller
{
    /**
     * @var string
     */
    protected $moduleName;

    protected $moduleInfo = [];

    private $error = [];

    public function index()
    {
        $this->moduleName = $this->getModuleName();

        $data = $this->getModuleSpecificData($this->doCommonStuff());

        $this->response->setOutput($this->load->view('extension/module/' . $this->moduleName, $data));
    }

    /**
     * @return string
     */
    abstract protected function getModuleName();

    /**
     * @param array $data
     * @return array
     */
    abstract protected function getModuleSpecificData($data);

    /**
     * @param string $filedName
     * @param array $data
     * @return array
     */
    protected function handleField($filedName, $data)
    {
        if (isset($this->request->post[$filedName])) {
            $data[$filedName] = $this->request->post[$filedName];
        } elseif (!empty($this->moduleInfo)) {
            $data[$filedName] = $this->moduleInfo[$filedName];
        } else {
            $data[$filedName] = '';
        }

        return $data;
    }

    /**
     * @return array
     */
    private function doCommonStuff()
    {
        $data = [];

        $this->load->language('extension/module/' . $this->moduleName);
        $this->document->setTitle($this->language->get('heading_title'));
        $this->load->model('extension/module');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            if (!isset($this->request->get['module_id'])) {
                $this->model_extension_module->addModule('' . $this->moduleName, $this->request->post);
            } else {
                $this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post);
            }
            $this->session->data['success'] = $this->language->get('text_success');
            $this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
        }

        $data['lang']['heading_title'] = $this->language->get('heading_title');
        $data['lang']['text_edit'] = $this->language->get('text_edit');
        $data['lang']['text_enabled'] = $this->language->get('text_enabled');
        $data['lang']['text_disabled'] = $this->language->get('text_disabled');
        $data['lang']['entry_name'] = $this->language->get('entry_name');
        $data['lang']['entry_status'] = $this->language->get('entry_status');
        $data['lang']['button_save'] = $this->language->get('button_save');
        $data['lang']['button_cancel'] = $this->language->get('button_cancel');

        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        if (isset($this->error['name'])) {
            $data['error_name'] = $this->error['name'];
        } else {
            $data['error_name'] = '';
        }

        $data['breadcrumbs'] = array();
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
        );
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_extension'),
            'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true)
        );

        if (!isset($this->request->get['module_id'])) {
            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('heading_title'),
                'href' => $this->url->link('extension/module/' . $this->moduleName, 'token=' . $this->session->data['token'], true)
            );
        } else {
            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('heading_title'),
                'href' => $this->url->link('extension/module/' . $this->moduleName, 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], true)
            );
        }

        if (!isset($this->request->get['module_id'])) {
            $data['action'] = $this->url->link('extension/module/' . $this->moduleName, 'token=' . $this->session->data['token'], true);
        } else {
            $data['action'] = $this->url->link('extension/module/' . $this->moduleName, 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], true);
        }

        $data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);

        $data['token'] = $this->session->data['token'];

        if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
            $this->moduleInfo = $this->model_extension_module->getModule($this->request->get['module_id']);
        }

        $data = $this->handleField('name', $data);
        $data = $this->handleField('status', $data);

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        return $data;
    }

    private function validate()
    {
        if (!$this->user->hasPermission('modify', 'extension/module/' . $this->moduleName)) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 64)) {
            $this->error['name'] = $this->language->get('error_name');
        }

        return !$this->error;
    }
}
