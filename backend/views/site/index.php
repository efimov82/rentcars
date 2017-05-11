<?php

/* @var $this yii\web\View */

$this->title = 'My Yii Application';
?>

{include file="views/layouts/header.tpl"}

<!-- page content -->
  <div class="col-md-8">
    <h3>Contracts</h3>
  </div> 
  
  <div class="col-md-4">
    <div id="custom-search-input">
      <form action="/payments">
        <div class="input-group col-md-12">
          <input type="text" name="car_number" value="" class="search-query form-control" placeholder="Search by car number" />
          <span class="input-group-btn"><button class="btn btn-fill" type="submit"><span class="fa fa-search"></span></button></span>
        </div>
      </form> 
    </div>
  </div>

</div>

<div class="content table-responsive table-full-width">
  <table class="table table-hover">
    <thead>
      <th>#</th>
      <th>Date create</th>
      <th>Date start</th>
      <th>Date stop</th>
      <th>Client</th>
      <th>Car</th>
      <th>Status</th>
      <th>&nbsp;</th>
      <th>&nbsp;</th>
    </thead>
    <tbody>
    {foreach $contracts->each() as $contract}
    <tbody>
      <tr>
        <td>{$contract->id}</td>
        <td>{$contract->date_create|date_format:"d/m/y H:i"}</td>
        <td>{$contract->date_start|date_format:"d/m/y"}</td>
        <td>{$contract->date_stop|date_format:"d/m/y"}</td>
        <td>{$contract->client_id}</td>
        <td>{$contract->car_id}</td>
        <td>{$contract->status}</td>
        <td>EDIT</td>
        <td>PAYMENTS</td>
      </tr>
    </tbody>
    {/foreach}
    </tbody>
</table>