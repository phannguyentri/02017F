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

        $this->lang->load('products', $this->Settings->language);
        $this->digital_upload_path = 'files/';
        $this->upload_path = 'assets/uploads/';
        $this->thumbs_path = 'assets/uploads/thumbs/';
        $this->image_types = 'gif|jpg|jpeg|png|tif';
        $this->digital_file_types = 'zip|psd|ai|rar|pdf|doc|docx|xls|xlsx|ppt|pptx|gif|jpg|jpeg|png|tif|txt';
        $this->allowed_file_size = '1024';
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
                'page' => 'Chấm công'
            )
        );
        $meta = array(
            'page_title' => 'Chấm công',
            'bc' => $bc
        );
        $this->load->model('companies_model');
        $this->load->model('departments_model');
        // $this->data['billers'] = $this->billers->getAllBillerByDepartmentId($department_id);
        $this->data['departments'] = $this->departments_model->getAllDepartments();
        $this->page_construct('timekeepers/view', $meta, $this->data);
    }

    public function editView(){

        $sheetContentData   = $_POST['sheetContentData'];
        $detailIds          = $_POST['timekeeperDetailIds'];
        $year               = $_POST['year'];
        $month              = $_POST['month'];
        $i                  = 0;
        $error              = false;

        // $keys = array();

        // for ($i=1; $i <= cal_days_in_month(CAL_GREGORIAN, $month, $year); $i++) {
        //     $keys[] = 'd'.$i;
        // }

        $keys = array(
            'd1',
            'd2',
            'd3',
            'd4',
            'd5',
            'd6',
            'd7',
            'd8',
            'd9',
            'd10',
            'd11',
            'd12',
            'd13',
            'd14',
            'd15',
            'd16',
            'd17',
            'd18',
            'd19',
            'd20',
            'd21',
            'd22',
            'd23',
            'd24',
            'd25',
            'd26',
            'd27',
            'd28',
            'd29',
            'd30',
            'd31'
        );

        foreach ($detailIds as $k => $val) {
            $id = $val['detail_id'];
            $totalHour = 0;
            $ct = 0;
            $overTime = 0;

            $detail = array_combine($keys, $sheetContentData[$k]);

            foreach ($sheetContentData[$k] as $k2 => $val2) {
                if ($k % 2 == 0) {
                  if ($val2 == "CT") {
                    $ct++;
                  }elseif ($val2 == "P" || $val2 == "Ro" || $val2 == "R" || $val2 == "Ô" || $val2 == "Đ"
                   || $val2 == "NB" || $val2 == "V" || $val2 == "L") {
                    continue;
                  }else{
                    $totalHour = $totalHour + $val2;
                  }
                }else{
                    $day = $k2+1;
                    if (date("w", strtotime($day.'-'.$month.'-'.$year)) != 0) {
                        $overTime  = $overTime + $val2;
                    }

                }

            }

            $total = ($totalHour/8) + $ct;
            $detail['total'] = $total;
            $detail['overtime'] = $overTime;

            if (!$this->timekeepers_model->updateTimekeeperDetail($id, $detail)) {
                $error = true;
            }
        }

        if ($error) {
            echo json_encode(array('status' => 'error'));
        }else{
            echo json_encode(array('status' => 'success'));
        }


    }

    public function getAllTimekeeperDetails(){
        $department_id  = $this->input->get('department_id');
        $year           = $this->input->get('year');
        $month          = $this->input->get('month');

        $data['timekeeperDetailsName']    = $this->timekeepers_model->getTimekeeperDetailsName($department_id, $year, $month);
        $data['timekeeperDetails']        = $this->timekeepers_model->getTimekeeperDetails($department_id, $year, $month);
        $data['timekeeperDetailIds']      = $this->timekeepers_model->getTimekeeperDetailsId($department_id, $year, $month);
        echo json_encode($data);
    }

    public function checkTimekeeper(){
        $department_id  = $this->input->post('department_id');
        $year           = $this->input->post('year');
        $month           = $this->input->post('month');

        if ($this->timekeepers_model->isExistTimekepper($department_id, $year, $month)) {
            echo json_encode(array('status' => 'exist'));
        }else{
            echo json_encode(array('status' => 'none'));
        }
    }

    public function import_xls(){

        require_once(APPPATH . "third_party" . DIRECTORY_SEPARATOR . 'PHPExcel' . DIRECTORY_SEPARATOR . 'PHPExcel.php');
        $this->load->helper('security');

        $this->form_validation->set_rules('userfile', lang("upload_file"), 'xss_clean');

        if ($this->form_validation->run() == true) {
          $department_id  = $this->input->post('department');
          $month          = $this->input->post('month');
          $year           = $this->input->post('year');

          $existTimekeeper = $this->timekeepers_model->getTimekepperByDepartmentIdYearMonth($department_id, $year, $month);

          if ($existTimekeeper) {
            $this->timekeepers_model->deleteAllTimekeeperAndDetails($existTimekeeper->id);
          }

          if (isset($_FILES["userfile"])) {

              $this->load->library('upload');

              $config['upload_path']   = $this->digital_upload_path;
              $config['allowed_types'] = 'xlsx';
              $config['max_size']      = $this->allowed_file_size;
              $config['overwrite']     = TRUE;

              $this->upload->initialize($config);

              if (!$this->upload->do_upload()) {

                $error = $this->upload->display_errors();
                $this->session->set_flashdata('error', $error);
                redirect("products/import_csv");
              }

              $filename      = $this->upload->file_name;
              $fullfile      = $this->digital_upload_path . $filename;
              $inputFileType = PHPExcel_IOFactory::identify($fullfile);

              $objReader = PHPExcel_IOFactory::createReader($inputFileType);

              $objReader->setReadDataOnly(true);


              /**  Load $inputFileName to a PHPExcel Object  **/
              $objPHPExcel = $objReader->load("$fullfile");

              $total_sheets = $objPHPExcel->getSheetCount();

              $allSheetName       = $objPHPExcel->getSheetNames();
              $objWorksheet       = $objPHPExcel->setActiveSheetIndex(0);
              $highestRow         = $objWorksheet->getHighestRow();
              $highestColumn      = $objWorksheet->getHighestColumn();
              $highestColumnIndex = PHPExcel_Cell::columnIndexFromString($highestColumn);
              $arraydata          = array();
              $arrayDataNormal    = array();

              $i = 0;
              $v = 0;

              for ($row = 7; $row <= $highestRow; ++$row) {
                $row_end = 0;
                $j = 0;
                $k = 0;
                if ($row % 2 != 0) {

                  for ($col = 1; $col < (cal_days_in_month(CAL_GREGORIAN, $month, $year)+3); ++$col) {
                      if($col == 2)
                          continue;

                      $value = $objWorksheet->getCellByColumnAndRow($col, $row)->getValue();
                      if ($col > 2) {
                          $value  = ($value) ? $value : 0;
                      }else{
                          $value  = $objWorksheet->getCellByColumnAndRow($col, $row)->getValue();
                      }

                      $arraydata[$i][$j] = $value;
                      $j++;
                      if (!$value) {
                          $row_end++;
                      }
                  }

                  if ($row_end > cal_days_in_month(CAL_GREGORIAN, $month, $year)) {
                      unset($arraydata[$i]);
                      break;
                  }
                  $i++;
                }else{
                  for ($col = 1; $col < (cal_days_in_month(CAL_GREGORIAN, $month, $year)+3); ++$col) {
                      if($col == 1 || $col == 2)
                          continue;
                      $value  = $objWorksheet->getCellByColumnAndRow($col, $row)->getValue();
                      $value  = ($value) ? $value : 0;
                      $arrayDataNormal[$v][$k]   = $value;
                      $k++;
                  }

                  $v++;
                }

              }


              $keys_day = array();

              for ($i=1; $i <= cal_days_in_month(CAL_GREGORIAN, $month, $year); $i++) {
                $keys_day[] = 'd'.$i;
              }


              $keysOverTime   = $keys_day;
              array_unshift($keys_day, 'name');
              $keys           = $keys_day;

              $finalsNormal   = array();
              $finalsOverTime = array();

              foreach ($arraydata as $key => $value) {
                $finalsNormal[] = array_combine($keys, $value);
              }

              foreach ($arrayDataNormal as $key => $value) {
                $finalsOverTime[] = array_combine($keysOverTime, $value);
              }

              $rw = 7;
              $totalHour      = 0;


              foreach ($finalsNormal as $k => $final) {

                $company = $this->timekeepers_model->getCompanyByNameAndDepartmentId($final['name'], $department_id);
                if ($company) {
                  unset($finalsNormal[$k]['name']);

                  $i = 1;
                  $totalHour  = 0;
                  $ct         = 0;
                  foreach ($finalsNormal[$k] as $day) {
                    if ($day === "CT") {
                      $ct++;
                    }elseif ($day === "P" || $day === "Ro" || $day === "R" || $day === "Ô" || $day === "Đ"
                     || $day === "NB" || $day === "V" || $day === "L") {
                      continue;
                    }else{
                      $totalHour  = $totalHour + $day;
                    }
                  }

                  $overTime       = 0;
                  foreach ($finalsOverTime[$k] as $day) {
                    if (date("w", strtotime($i.'-'.$month.'-'.$year)) != 0) {
                      $overTime  = $overTime + $day;
                    }

                    $i++;
                  }

                  $finalsNormal[$k]['total']      = ($totalHour/8) + $ct;
                  $finalsNormal[$k]['company_id'] = $company->id;
                  $finalsNormal[$k]['type']       = 'normal';
                  $finalsOverTime[$k]['overtime']   = $overTime;
                  $finalsOverTime[$k]['company_id'] = $company->id;
                  $finalsOverTime[$k]['type']   = 'overtime';

                }else{
                  $this->session->set_flashdata('error', "Tên nhân viên không nằm trong danh sách nhân viên, lỗi tại dòng " . " " . $rw);
                  redirect("timekeepers/import_xls");
                }

                $rw += 2;

              }

              $dataTimekeeper = array(
                'department_id' => $this->input->post('department'),
                'month' => $month,
                'year'  => $year
              );


              if ($this->timekeepers_model->addTimekeeper($dataTimekeeper, $finalsNormal, $finalsOverTime)) {
                $this->session->set_flashdata('message', 'Bảng chấm công đã được import thành công!');
                redirect("timekeepers/import_xls");
              }else{
                $this->session->set_flashdata('error', 'Import bảng chấm công thất bại.');
                redirect("timekeepers/import_xls");
              }

            }



        }else{
          $this->data['error'] = (validation_errors() ? validation_errors() : $this->session->flashdata('error'));
          $bc                  = array(
            array(
              'link' => base_url(),
              'page' => lang('home')
            ),
            array(
              'link' => '#',
              'page' => 'Chấm công'
            ),
            array(
              'link' => '#',
              'page' => lang('Import bảng chấm công')
            )
          );
          $meta = array(
            'page_title' => 'Import chấm công',
            'bc' => $bc
          );

          $this->load->model('departments_model');
          $this->data['departments'] = $this->departments_model->getAllDepartments();
          $this->page_construct('timekeepers/import_xls', $meta, $this->data);
        }

    }

}
