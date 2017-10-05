<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Timekeepers extends MY_Controller
{

    function __construct()
    {
        parent::__construct();

        if (!$this->loggedIn) {
            $this->session->set_userdata('requested_page', $this->uri->uri_string());
            redirect('login');
        }


        $this->lang->load('settings', $this->Settings->language);
        $this->load->library('form_validation');
        // $this->load->model('categories_model');
    }

    public function add(){

        $this->data['error'] = validation_errors() ? validation_errors() : $this->session->flashdata('error');
        $bc                  = array(
            array(
                'link' => base_url(),
                'page' => lang('home')
            ),
            array(
                'link' => '#',
                'page' => lang('Chấm công')
            )
        );
        $meta                = array(
            'page_title' => lang('Chấm công'),
            'bc' => $bc
        );
        $this->load->model('companies_model');
        $this->load->model('departments_model');
        // $this->data['billers'] = $this->billers->getAllBillerByDepartmentId($department_id);
        $this->data['departments'] = $this->departments_model->getAllDepartments();
        $this->page_construct('timekeepers/add', $meta, $this->data);
    }

    public function getAllBiller(){
        $department_id = $this->input->get('department_id');
        $this->load->model('companies_model');
        $billers = $this->companies_model->getAllBillerByDepartmentId($department_id);

        echo json_encode($billers);
    }

}
