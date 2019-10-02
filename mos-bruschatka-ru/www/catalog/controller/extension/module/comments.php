<?php
class ControllerExtensionModuleComments extends Controller {
	public function index($setting) {
		static $module = 0;

		$this->load->model('design/banner');
		$this->load->model('tool/image');

		$data['comments'] = array();

		if(isset($setting['comment_image'])){
			foreach ($setting['comment_image'] as  $result) {
				if(!isset($result['language'][$this->config->get('config_language_id')])){ continue; }
				$result = $result['language'][$this->config->get('config_language_id')];
				if (is_file(DIR_IMAGE . $result['image'])) {
					$data['comments'][$result['sort_order']][] = array(
					'author' 			=> $result['author'],
					'thumb_profil' 			=> $this->model_tool_image->resize($result['profil'], 50, 50),
					'location'  		=> $result['location'],
					'date'  			=> $result['date'],
					'text_big' 		    => html_entity_decode($result['text_big'], ENT_QUOTES, 'UTF-8'),
					'text_small'  		=> html_entity_decode($result['text_small'], ENT_QUOTES, 'UTF-8'),
					'thumb_showcase' 			=> $this->model_tool_image->getImage($result['image'])
				);
				}
			}
		}

		$data['placeholder_img'] = $this->language->get('placeholder_img');
		ksort($data['comments']);
		$data['module'] = $module++;

		return $this->load->view('extension/module/comments', $data);

	}
}
?>
