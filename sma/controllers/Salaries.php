<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Salaries extends MY_Controller
{

    function __construct()
    {
        parent::__construct();

        if (!$this->loggedIn) {
            $this->session->set_userdata('requested_page', $this->uri->uri_string());
            redirect('login');
        }

        $this->popup_attributes = array('width' => '900', 'height' => '600', 'window_name' => 'sma_popup', 'menubar' => 'yes', 'scrollbars' => 'yes', 'status' => 'no', 'resizable' => 'yes', 'screenx' => '0', 'screeny' => '0');
        $this->lang->load('settings', $this->Settings->language);
        $this->load->model('timekeepers_model');
        $this->load->library('form_validation');

        // $this->load->model('categories_model');
    }

    public function view(){

        $this->data['error'] = validation_errors() ? validation_errors() : $this->session->flashdata('error');
        $bc                  = array(
            array(
                'link' => base_url(),
                'page' => lang('home')
            ),
            array(
                'link' => '#',
                'page' => 'Tính lương'
            )
        );
        $meta = array(
            'page_title' => 'Tính lương',
            'bc' => $bc
        );

        $this->load->model('departments_model');
        $this->load->model('productions_model');

        $this->data['departments'] = $this->departments_model->getAllDepartments();

        $this->data['productions'] = $this->productions_model->getProductionByYearMonth(2017, 7);

        $this->page_construct('salaries/view', $meta, $this->data);
    }

    public function getAllTimekeeperDetails(){
        $this->load->model('productions_model');

        $department_id  = $this->input->get('department_id');
        $year           = $this->input->get('year');
        $month          = $this->input->get('month');

        $data['timekeeperDetailsName']  = $this->timekeepers_model->getTimekeeperDetailsName($department_id, $year, $month);
        $data['timekeeperDetails']      = $this->timekeepers_model->getTimekeeperDetails($department_id, $year, $month);
        $data['timekeeperDetailIds']    = $this->timekeepers_model->getTimekeeperDetailsId($department_id, $year, $month);
        $data['companyIds']             = $this->timekeepers_model->getCompanyIds($department_id, $year, $month);
        $data['productionsInMonthYear'] = $this->data['productions'] = $this->productions_model->getProductionByYearMonth($year, $month);
        $data['basicSalaries']          = $this->timekeepers_model->getBasicCompanies($department_id, $year, $month);


        echo json_encode($data);
    }

}
