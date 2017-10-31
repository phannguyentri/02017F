<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Departments_model extends CI_Model
{

    public function __construct()
    {
        parent::__construct();
    }

    public function getAllDepartments(){
      $q = $this->db->get('departments');
      if ($q->num_rows() > 0) {
          foreach (($q->result()) as $row) {
              $data[] = $row;
          }
          return $data;
      }
    }

    public function addDepartment($data){
      if ($this->db->insert('departments', $data)) {
        return true;
      }
      return false;
    }

    public function getDepartmentById($id){
      $q = $this->db->get_where('departments', array('id' => $id), 1);
      if ($q->num_rows() > 0) {
          return $q->row();
      }
      return FALSE;
    }

    public function editDepartment($id, $data){
      $this->db->where('id', $id);
      if ($this->db->update('departments', $data)) {
        return true;
      }
      return false;
    }

    public function deleteDepartmentById($id){
      if($this->db->delete('departments', array('id' => $id))){
        return true;
      }
      return false;
    }

    public function isProductionById($department_id){
      $q = $this->db->get_where('departments', array('id' => $department_id, 'type' => 'production'), 1);
      if ($q->num_rows() > 0) {
          return TRUE;
      }
      return FALSE;
    }

    public function getName($department_id){
      $this->db->select('name');
      $q = $this->db->get_where('departments', array('id' => $department_id), 1);
      if ($q->num_rows() > 0) {
          return $q->row();
      }
      return FALSE;
    }
}
