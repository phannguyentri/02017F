<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Working_places extends MY_Controller
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
        $this->load->model('working_places_model');
    }

    function getAllMechines($id = NULL)
    {
        if ($rows = $this->working_places_model->getAllMechines($id)) {
            $data = json_encode($rows);
        } else {
            $data = false;
        }
        echo $data;
    }

    function index()
    {
        $this->data['error'] = validation_errors() ? validation_errors() : $this->session->flashdata('error');      
        $bc = array(array('link' => base_url(), 'page' => lang('home')), array('link' => '#', 'page' => lang('Nguyên vật liệu')));
        $meta = array('page_title' => lang('Nguyên vật liệu'), 'bc' => $bc);
        $this->page_construct('working_places/index', $meta, $this->data);
    }

    function getWorking_Place()
    {

        $this->load->library('datatables');
        $this->datatables
            ->select("working_places.id, working_place, phone, address,
                GROUP_CONCAT(CONCAT('<p class=".'color'.">', ". $this->db->dbprefix('machine') .
                 ".machine_name, ' (Mã máy: ', " .
                 $this->db->dbprefix('machine') . ".machine_code,')</p>') SEPARATOR '') as iname,
                 note",false)
            ->join('working_place_items', 'working_places.id=working_place_items.working_place_id', 'left')
            ->join('machine', 'machine.id=working_place_items.machine_id', 'left')
            ->join('machine_categories', 'machine.id_machine_categories=machine_categories.id', 'left')
            ->group_by('working_places.id')            
            ->from("working_places")
            ->add_column("Actions", "<center><a href='" . site_url('working_places/edit/$1') . "' data-toggle='modal' data-target='#myModal'  class='tip' title='Sửa xưởng'><i class=\"fa fa-edit\"></i></a> <a href='#' class='tip po' title='<b>Xóa xưởng</b>' data-content=\"<p>" . lang('r_u_sure') . "</p><a class='btn btn-danger po-delete' href='" . site_url('working_places/delete/$1') . "'>" . lang('i_m_sure') . "</a> <button class='btn po-close'>" . lang('no') . "</button>\"  rel='popover'><i class=\"fa fa-trash-o\"></i></a></center>", "working_places.id");

        echo $this->datatables->generate();
    }

    function getWorkingPlaceByID($id = NULL)
    {
        if ($rows = $this->hotel_model->getWorkingPlaceByID($id)) {
            $data = json_encode($rows);
        } else {
            $data = false;
        }
        echo $data;
    }

    function add()
    {
        $this->load->helper('security');
        $this->form_validation->set_rules('working_place', lang("Tên xưởng"), 'trim|required');
        $this->form_validation->set_rules('phone', lang("Phone"), 'trim|numeric');
        $this->form_validation->set_rules('address', lang("address"), 'trim');
        if ($this->form_validation->run() == true) {
           $data = array(
                'working_place' => $this->input->post('working_place'),
                'phone' => $this->input->post('phone'),
                'address' => $this->input->post('address'),
                'note' => $this->input->post('note'),                
            ); 

            $machines = array(                
                'machine_id' => $this->input->post('machine'),                
            );



            
        } elseif ($this->input->post('add')) {
            $this->session->set_flashdata('error', validation_errors());
            redirect($_SERVER["HTTP_REFERER"]);
        }

        if ($this->form_validation->run() == true && $this->working_places_model->addWorkingPlace($data,$machines)) {
            $this->session->set_flashdata('message', 'Thêm xưởng thành công');
            redirect($_SERVER["HTTP_REFERER"]);
        } else {
            $this->data['error'] = validation_errors() ? validation_errors() : $this->session->flashdata('error');
            
           
            $q = $this->working_places_model->getAllCategories();
            foreach ($q as $value) {
               $e= $this->working_places_model->getMachineByIdCate($value->id);
               $value->machine=$e;
            }
            $this->data['machine'] = $q;
            
            
            
            $this->data['categories'] = $this->working_places_model->getAllCategories();

            $this->data['modal_js'] = $this->site->modal_js();
            $this->load->view($this->theme . 'working_places/add', $this->data);
        }
    }

    function edit($id=NULL)
    {
        $this->load->helper('security');
        $this->form_validation->set_rules('working_place', lang("Tên xưởng"), 'trim|required');
        $this->form_validation->set_rules('phone', lang("Phone"), 'trim|numeric');
        $this->form_validation->set_rules('address', lang("address"), 'trim');
        if ($this->form_validation->run() == true) {
            $data = array(
                'working_place' => $this->input->post('working_place'),
                'phone' => $this->input->post('phone'),
                'address' => $this->input->post('address'),
                'note' => $this->input->post('note'),                
            ); 

            $machines = array(                
                'machine_id' => $this->input->post('machine'),                
            );
            
        } elseif ($this->input->post('add')) {
            $this->session->set_flashdata('error', validation_errors());
            redirect($_SERVER["HTTP_REFERER"]);
        }

        if ($this->form_validation->run() == true && $this->working_places_model->updateWorkingPlace($id,$data,$machines)) {
            $this->session->set_flashdata('message', 'Sửa xưởng thành công');
            redirect($_SERVER["HTTP_REFERER"]);
        } else {
            $q = $this->working_places_model->getAllCategories();
            foreach ($q as $value) {
               
               $e= $this->working_places_model->getMachineByIdCateEdit($value->id,$id);
               $d = $this->working_places_model->getCategoriesByIdW($id);
               $value->machine=$e;
               
            }
            $d = $this->working_places_model->getCategoriesByIdW($id);
            
            
           
            $this->data['error'] = validation_errors() ? validation_errors() : $this->session->flashdata('error');
            
            $this->data['working_place'] = $this->working_places_model->getWorkingPlaceByID($id);
            $this->data['machineselected'] = $this->working_places_model->getCategoriesByIdW($id);
            $arr=array();
            foreach ($d as $key => $value) {
               $arr[]=$value->machine_id;
               
            }
            

            $this->data['machine'] = $q;

            $this->data['arr']=$arr;
           
           // var_dump($arr);die();
           // var_dump(in_array(1,$arr,true));die();

           
            $this->data['categories'] = $this->working_places_model->getAllCategories();          
            $this->data['id'] = $id;
            $this->data['modal_js'] = $this->site->modal_js();
            $this->load->view($this->theme . 'working_places/edit', $this->data);
        }
    }

    function delete($id = NULL)
    {
        //Check before delete
        if ($this->working_places_model->deleteWorkingPlace($id)) {
            echo lang("Xóa xưởng thành công");
        }
        else
        {
            echo lang("Xóa xưởng thất bại");
        }
    }

    function working_place_actions()
    {

        $this->form_validation->set_rules('form_action', lang("form_action"), 'required');

        if ($this->form_validation->run() == true) {
            if (!empty($_POST['val'])) {
                if ($this->input->post('form_action') == 'delete') {
                    foreach ($_POST['val'] as $id) {
                        $this->working_places_model->deleteWorkingPlace($id);
                    }
                    $this->session->set_flashdata('message', lang("Xóa các xưởng thành công"));
                    redirect($_SERVER["HTTP_REFERER"]);
                }

                if ($this->input->post('form_action') == 'export_excel' || $this->input->post('form_action') == 'export_pdf') {

                    $this->load->library('excel');
                    $this->excel->setActiveSheetIndex(0);
                    $this->excel->getActiveSheet()->setTitle(lang('categories'));
                    $this->excel->getActiveSheet()->SetCellValue('A1', lang('code'));
                    $this->excel->getActiveSheet()->SetCellValue('B1', lang('name'));

                    $row = 2;
                    foreach ($_POST['val'] as $id) {
                        $sc = $this->working_places_model->getWorkingPlaceByID($id);
                        $this->excel->getActiveSheet()->SetCellValue('A' . $row, $sc->code);
                        $this->excel->getActiveSheet()->SetCellValue('B' . $row, $sc->name);
                        $row++;
                    }

                    $this->excel->getActiveSheet()->getColumnDimension('B')->setWidth(20);
                    $this->excel->getDefaultStyle()->getAlignment()->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER);
                    $filename = 'categories_' . date('Y_m_d_H_i_s');
                    if ($this->input->post('form_action') == 'export_pdf') {
                        $styleArray = array('borders' => array('allborders' => array('style' => PHPExcel_Style_Border::BORDER_THIN)));
                        $this->excel->getDefaultStyle()->applyFromArray($styleArray);
                        $this->excel->getActiveSheet()->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
                        require_once(APPPATH . "third_party" . DIRECTORY_SEPARATOR . "MPDF" . DIRECTORY_SEPARATOR . "mpdf.php");
                        $rendererName = PHPExcel_Settings::PDF_RENDERER_MPDF;
                        $rendererLibrary = 'MPDF';
                        $rendererLibraryPath = APPPATH . 'third_party' . DIRECTORY_SEPARATOR . $rendererLibrary;
                        if (!PHPExcel_Settings::setPdfRenderer($rendererName, $rendererLibraryPath)) {
                            die('Please set the $rendererName: ' . $rendererName . ' and $rendererLibraryPath: ' . $rendererLibraryPath . ' values' .
                                PHP_EOL . ' as appropriate for your directory structure');
                        }

                        header('Content-Type: application/pdf');
                        header('Content-Disposition: attachment;filename="' . $filename . '.pdf"');
                        header('Cache-Control: max-age=0');

                        $objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'PDF');
                        return $objWriter->save('php://output');
                    }
                    if ($this->input->post('form_action') == 'export_excel') {
                        header('Content-Type: application/vnd.ms-excel');
                        header('Content-Disposition: attachment;filename="' . $filename . '.xls"');
                        header('Cache-Control: max-age=0');

                        $objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel5');
                        return $objWriter->save('php://output');
                    }

                    redirect($_SERVER["HTTP_REFERER"]);
                }
            } else {
                $this->session->set_flashdata('error', lang("No hotel selected"));
                redirect($_SERVER["HTTP_REFERER"]);
            }
        } else {
            $this->session->set_flashdata('error', validation_errors());
            redirect($_SERVER["HTTP_REFERER"]);
        }
    }

    
}
