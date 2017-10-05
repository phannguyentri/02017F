<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Departments extends MY_Controller
{

    public function __construct()
    {
        parent::__construct();

        if (!$this->loggedIn) {
            $this->session->set_userdata('requested_page', $this->uri->uri_string());
            redirect('login');
        }

        $this->load->library('form_validation');
        $this->load->model('departments_model');
    }

    public function index(){
        $this->data['error'] = validation_errors() ? validation_errors() : $this->session->flashdata('error');

        $bc = array(array('link' => base_url(), 'page' => lang('home')), array('link' => '#', 'page' => 'Phòng ban'));
        $meta = array(
            'page_title' => 'Danh sách phòng ban',
            'bc' => $bc
        );
        $this->page_construct('departments/index', $meta, $this->data);
    }

    public function getDepartments(){
        $this->load->library('datatables');
        $this->datatables
            ->select("id, name")
            ->from("departments")
            ->add_column("Actions", "<center><a href='" . site_url('departments/edit/$1') . "' class='tip' title='Sửa phòng ban' data-toggle='modal' data-target='#myModal'><i class=\"fa fa-edit\"></i></a> <a href='#' class='tip po' title='Xóa phòng ban' data-content=\"<p>" . lang('r_u_sure') . "</p><a class='btn btn-danger po-delete' href='" . site_url('departments/delete/$1') . "'>" . lang('i_m_sure') . "</a> <button class='btn po-close'>" . lang('no') . "</button>\"  rel='popover'><i class=\"fa fa-trash-o\"></i></a></center>", "id");

        echo $this->datatables->generate();
    }

    public function edit($id = NULL){
        $this->sma->checkPermissions();

        $this->form_validation->set_rules('name', 'required');

        if ($this->form_validation->run() == true) {

            $data = array(
                'name'  => $this->input->post('name')
            );
            if ($this->departments_model->editDepartment($id, $data)) {
                $this->session->set_flashdata('message', "Sửa phòng ban thành công");
            }else{
                $this->session->set_flashdata('error', "Sửa phòng ban thất bại");
            }
            redirect("departments");
        } else {
            $this->data['department'] = $this->departments_model->getDepartmentById($id);
            $this->load->view($this->theme . 'departments/edit', $this->data);
        }

    }


    public function add()
    {

        $this->sma->checkPermissions();

        $this->form_validation->set_rules('name', 'required');

        if ($this->form_validation->run() == true) {

            $data = array(
                'name'  => $this->input->post('name')
            );
            if ($this->departments_model->addDepartment($data)) {
                $this->session->set_flashdata('message', "Thêm phòng ban thành công");
            }else{
                $this->session->set_flashdata('error', "Thêm phòng ban thất bại");
            }
            redirect("departments");

        } else {

            $this->load->view($this->theme . 'departments/add');
        }
    }

    public function delete($id = NULL){
        $this->sma->checkPermissions();
        if ($this->departments_model->deleteDepartmentById($id)) {
            echo "Xóa phòng ban thành công";
        }else{
            echo "Xóa phòng ban thất bại";
        }
    }
}
