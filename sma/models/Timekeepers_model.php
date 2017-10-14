<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Timekeepers_model extends CI_Model
{

  public function __construct()
  {
      parent::__construct();
  }

  public function getCompanyByNameAndDepartmentId($name, $department_id){
    $q = $this->db->get_where('companies', array('name' => $name, 'department_id' => $department_id), 1);
    if ($q->num_rows() > 0) {
        return $q->row();
    }
    return FALSE;
  }

  public function addTimekeeper($dataTimekeeper, $dataNormal, $dataOverTime){

    if ($this->db->insert('timekeepers', $dataTimekeeper)) {
      $timekeeper_id = $this->db->insert_id();

      foreach ($dataNormal as $key => $value) {
        $dataNormal[$key]['timekeeper_id'] = $timekeeper_id;
        $dataOverTime[$key]['timekeeper_id'] = $timekeeper_id;

        $this->addTimekeeperDetail($dataNormal[$key]);
        $this->addTimekeeperDetail($dataOverTime[$key]);

      }
      return true;
    }
    return false;
  }

  public function addTimekeeperDetail($data_detail){

    if ($this->db->insert('timekeeper_details', $data_detail)) {
      return true;
    }
    return false;
  }

  public function getTimekeeperDetailsName($department_id, $year, $month){
    $this->db->select('companies.name');
    $this->db->join('timekeeper_details', 'timekeeper_details.timekeeper_id = timekeepers.id');
    $this->db->join('companies', 'companies.id = timekeeper_details.company_id');
    $q = $this->db->get_where('timekeepers', array('timekeepers.department_id' => $department_id, 'timekeepers.year' => $year, 'timekeepers.month' => $month));
    if ($q->num_rows() > 0) {
        foreach (($q->result()) as $row) {
            $data[] = $row;
        }
        return $data;
    }
    return FALSE;
  }

  public function getTimekeeperDetails($department_id, $year, $month){
    $this->db->select('d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15, d16, d17, d18, d19, d20, d21
      , d22, d23, d24, d25, d26, d27, d28, d29, d30, d31');

    $this->db->join('timekeeper_details', 'timekeeper_details.timekeeper_id = timekeepers.id');

    $q = $this->db->get_where('timekeepers', array('timekeepers.department_id' => $department_id, 'timekeepers.year' => $year, 'timekeepers.month' => $month));
    if ($q->num_rows() > 0) {
        foreach (($q->result()) as $row) {
            $data[] = $row;
        }
        return $data;
    }
    return FALSE;
  }

  public function getTimekeeperDetailsId($department_id, $year, $month){
    $this->db->select('timekeeper_details.id as detail_id');

    $this->db->join('timekeeper_details', 'timekeeper_details.timekeeper_id = timekeepers.id');

    $q = $this->db->get_where('timekeepers', array('timekeepers.department_id' => $department_id, 'timekeepers.year' => $year, 'timekeepers.month' => $month));
    if ($q->num_rows() > 0) {
        foreach (($q->result()) as $row) {
            $data[] = $row;
        }
        return $data;
    }
    return FALSE;
  }

  public function updateTimekeeperDetail($detailId, $dataDetail){
    $this->db->where('id', $detailId);
    if ($this->db->update('timekeeper_details', $dataDetail)) {
      return true;
    }
    return false;
  }

  public function getTimekepperByDepartmentIdYearMonth($department_id, $year, $month){
    $this->db->join('departments', 'departments.id = timekeepers.department_id');
    $q = $this->db->get_where('timekeepers', array('department_id' => $department_id
     , 'year' => $year, 'month' => $month), 1);
    if ($q->num_rows() > 0) {
      return $q->row();
    }
    return false;
  }

  public function isExistTimekepper($department_id, $year, $month){
    $q = $this->db->get_where('timekeepers', array('department_id' => $department_id
     , 'year' => $year, 'month' => $month), 1);
    if ($q->num_rows() > 0) {
      return true;
    }
    return false;
  }

}
