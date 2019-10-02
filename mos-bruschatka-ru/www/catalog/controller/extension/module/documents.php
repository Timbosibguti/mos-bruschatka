<?php
class ControllerExtensionModuleDocuments extends Controller {
	public function index($setting) {
		$this->load->language('extension/module/documents');

		$data['entry_title'] = $setting['title'] ?: '';
		$data['classname'] = $setting['classname'];
		$data['placeholder_img'] = $this->language->get('placeholder_img');

		if($setting['status']) {
			foreach ($setting['images'] as $image) {
				$thumb = $this->model_tool_image->resize($image, 270, 380);
				$popup = $this->model_tool_image->resize($image, 1000, 1000);

				$data['images'][] = array(
					'popup'		=> $popup,
					'thumb'		=> $thumb
				);
			}
		}

		return $this->load->view('extension/module/documents', $data);
	}
}
