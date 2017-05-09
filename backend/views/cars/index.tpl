<!-- header --!>
{include file="layouts/header.tpl"}
            <!-- page content --!>
            <div class="col-md-8">
                <h3>List of cars</h3>
            </div>          
            <div class="col-md-4">
                <div id="custom-search-input">
                    <form action="/cars">
                        <div class="input-group col-md-12">
                            <input type="text" name="number" value={$number} class="search-query form-control" placeholder="Search by number" />
                            <span class="input-group-btn"><button class="btn btn-fill" type="submit"><span class="fa fa-search"></span></button></span>
                        </div>
                    </form> 
                </div>
            </div>
        </div>
        <div class="content table-responsive table-full-width">
            <table class="table table-hover">
                <thead>
                    <th>Car Number</th>
                    <th>Brand</th>
                    <th>Model</th>
                    <th>Color</th>
                    <th>Mileage</th>
                    <th>Start of Lease</th>
                    <th>Paid up to</th>
                    <th>Price</th>
                    <th>Edit</th>
                    </tr>
                </thead>
                <tbody>
                {foreach $cars->each() as $car}
                    <tr>
                    <td>{$car->number}</td>
                    <td>{$car->mark}</td>
                    <td>{$car->model}</td>
                    <td>{$car->color}</td>
                    <td>{$car->mileage}</td>
                    <td>{$car->start_lease}</td>
                    <td>{$car->paid_up_to}</td>
                    <td>PRICES</td>
                    <td>{if Yii::$app->user->can('admin')}<a href="{url route="cars/edit" id=$car->id}"><button class="btn btn-fill btn-xs"><i class="fa fa-pencil-square-o"></i>Edit</button></a>{/if}</td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>