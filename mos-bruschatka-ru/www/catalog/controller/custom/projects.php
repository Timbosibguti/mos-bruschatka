<?php
class ControllerCustomProjects extends Controller {

    const PREVIEW_IMAGE_WIDTH = 372;
    const PREVIEW_IMAGE_HEIGHT = 279;
    const PATH_URBAN ='urban';
    const PATH_PRIVATE ='private';
    const PATH_ALL ='all';

    public function index() {
        $this->load->language('custom/projects');
        $this->load->model('tool/image');

        $data['placeholder_img'] = $this->language->get('placeholder_img');

        $path = isset($this->request->get['path']) ? $this->request->get['path'] : self::PATH_ALL;

        $data['heading_title'] = $this->language->get('heading_title');
        $data['link'] = $this->url->link('custom/projects');

        $privateGroup = array(
            'group_id'	=> 1,
            'name'		=> 'частные дома',
            'color'		=> 'green',
            'icon'		=> 'iconHome',
            'href'		=> $this->url->link('custom/projects','path='.self::PATH_PRIVATE)
        );
        $urbanGroup = array(
            'group_id'	=> 2,
            'name'		=> 'городские проекты',
            'color'		=> 'blue',
            'icon'		=> 'iconBuildingBtn',
            'href'		=> $this->url->link('custom/projects','path='.self::PATH_URBAN)
        );

        $data['groups'] = [
            self::PATH_URBAN => $urbanGroup,
            self::PATH_PRIVATE => $privateGroup
        ];

        $data['projects'] = $this->filterProjectsByPathOrGetAll($this->getProjects(),$path);

        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

        $this->response->setOutput($this->load->view('custom/projects',$data));
    }

    private function resizeImage($imagePath)
    {
        return $this->model_tool_image->resize($imagePath, self::PREVIEW_IMAGE_WIDTH, self::PREVIEW_IMAGE_HEIGHT);
    }

    private function filterProjectsByPathOrGetAll($projects,$path)
    {
        return ($path === self::PATH_PRIVATE || $path === self::PATH_URBAN) ? $this->filterProjectsByGroup($projects,$path) : $projects;
    }

    private function filterProjectsByGroup($projects,$group)
    {
        $filteredProjects = [];

        foreach ($projects as $project){
            if ($project['group'] === $group) {
                $filteredProjects[] = $project;
            }
        }

        return $filteredProjects;
    }

    private function getProjects()
    {
        return
            [
                [
                    'name'		=> 'Балашиха, 19 м<sup>2</sup>',
                    'group'		=> self::PATH_PRIVATE,
                    'thumb'		=> $this->resizeImage('catalog/projects/1balashiha.jpg'),
                ],
                [
                    'name'		=> 'Коттеджный поселок Белый берег',
                    'group'		=> self::PATH_URBAN,
                    'thumb'		=> $this->resizeImage('catalog/projects/2belyi bereg.jpg'),
                ],
                [
                    'name'		=> 'Бульвар Карбышева, 115 м<sup>2</sup>',
                    'group'		=> self::PATH_URBAN,
                    'thumb'		=> $this->resizeImage('catalog/projects/3blv.Karbysheva.jpg'),
                ],
                [
                    'name'		=> 'п.Свердловский, 25 м<sup>2</sup>',
                    'group'		=> self::PATH_PRIVATE,
                    'thumb'		=> $this->resizeImage('catalog/projects/4p.sverdlovskyi.jpg'),
                ],
                [
                    'name'		=> 'Аэропорт Внуково',
                    'group'		=> self::PATH_URBAN,
                    'thumb'		=> $this->resizeImage('catalog/projects/5vnykovo airport.jpg'),
                ],
                [
                    'name'		=> 'Софьино КП, 40 м<sup>2</sup>',
                    'group'		=> self::PATH_PRIVATE,
                    'thumb'		=> $this->resizeImage('catalog/projects/6Sofino kp.jpg'),
                ],
                [
                    'name'		=> 'МГУ, 300 м <sup>2</sup>',
                    'group'		=> self::PATH_URBAN,
                    'thumb'		=> $this->resizeImage('catalog/projects/7mgy.jpg'),
                ],
                [
                    'name'		=> 'СНТ Заречье, 35 м<sup>3</sup>',
                    'group'		=> self::PATH_PRIVATE,
                    'thumb'		=> $this->resizeImage('catalog/projects/8snt zarache.jpg'),
                ],
                [
                    'name'		=> 'Апрелевка, 100 м<sup>2</sup>',
                    'group'		=> self::PATH_PRIVATE,
                    'thumb'		=> $this->resizeImage('catalog/projects/9aprelevka.jpg'),
                ],
                [
                    'name'		=> 'СНТ Заречье, 40,5 м <sup>2</sup>',
                    'group'		=> self::PATH_PRIVATE,
                    'thumb'		=> $this->resizeImage('catalog/projects/10Snt.jpg'),
                ],
                [
                    'name'		=> 'Видное, 55 м<sup>2</sup>',
                    'group'		=> self::PATH_PRIVATE,
                    'thumb'		=> $this->resizeImage('catalog/projects/11vidnoe.jpg'),
                ],
                [
                    'name'		=> ' Пионерская ул, 30 м<sup>2</sup>',
                    'group'		=> self::PATH_PRIVATE,
                    'thumb'		=> $this->resizeImage('catalog/projects/12pionerskaya.jpg'),
                ],
                [
                    'name'		=> 'Подмосковная ул., 16 м<sup>2</sup>',
                    'group'		=> self::PATH_PRIVATE,
                    'thumb'		=> $this->resizeImage('catalog/projects/13podmoskovnaya.jpg'),
                ],
                [
                    'name'		=> 'Осенняя ул., 80 м<sup>2</sup>',
                    'group'		=> self::PATH_PRIVATE,
                    'thumb'		=> $this->resizeImage('catalog/projects/14osenayaya.jpg'),
                ],
                [
                    'name'		=> 'Малаховка, 107 м<sup>2</sup>',
                    'group'		=> self::PATH_PRIVATE,
                    'thumb'		=> $this->resizeImage('catalog/projects/15malahovka.jpg'),
                ],
                [
                    'name'		=> 'Наро-Фоминск, 150 м<sup>2</sup>',
                    'group'		=> self::PATH_URBAN,
                    'thumb'		=> $this->resizeImage('catalog/projects/16naro-fominsk.jpg'),
                ],
            ];
    }
}
