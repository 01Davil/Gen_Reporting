<%@ Page Title="" Language="C#" MasterPageFile="~/Finance_MasterPage.master" AutoEventWireup="true" CodeFile="Finance_BankGuarantee.aspx.cs" Inherits="Finance_BankGuarantee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="row mb-2 mb-xl-3">
                            <div class="col-auto d-none d-sm-block">
                                <h3>Bank Guarantee</h3>
                            </div>

                            <div class="col-auto ms-auto text-end mt-n1">

                                <div class=" me-2 d-inline-block">
                                    <span class="btn btn-light bg-white shadow-sm " >
                                        <i class="align-middle mt-n1" data-feather="calendar"></i> <strong class="cv">2022/10/12 - 12:11:47</strong>
                                    </span>
                                </div>
                            </div>
                        </div>


                        <div class="row">

                            <div class="col-12 col-lg-12 d-flex">
                                <div class="card flex-fill w-100">
                                    <div class="card-header">
                                        <h5 class="card-title mb-0">Account Bank Guarantee Add</h5>
                                    </div>
                                    <div class="card-body">

                                        <div class="row mt-4">
                                            <div class="col-md-4">
                                                <label class="form-label">Bank Guarantee Number</label>
                                                <input type="text" class="form-control" >
                                            </div>


                                            <div class="col-md-4">
                                                <label class="form-label">Value</label>
                                                <input type="text" class="form-control" >
                                            </div>

                                            <div class="col-md-4">
                                                <label class="form-label">Issue Date</label>
                                                <input type="date" class="form-control" >
                                            </div>
                                        </div>

                                        <div class="row mt-4">
                                            <div class="col-md-4">
                                                <label class="form-label">Expiry Date</label>
                                                <input type="date" class="form-control" >
                                            </div>


                                            <div class="col-md-4">
                                                <label class="form-label">Claim Date</label>
                                                <input type="date" class="form-control" >
                                            </div>

                                            <div class="col-md-4">
                                                <label class="form-label">Bank Name</label>
                                                <input type="text" class="form-control" >
                                            </div>
                                        </div>

                                        <div class="row mt-4">
                                            <div class="col-md-4">
                                                <label class="form-label">Company Name</label>
                                                <input type="text" class="form-control" >
                                            </div>


                                            <div class="col-md-4">
                                                <label class="form-label">Client Name</label>
                                                <input type="text" class="form-control" >
                                            </div>


                                            <div class="col-md-4">
                                                <label class="form-label">Upload File</label>
                                                <input type="file" class="form-control" placeholder="" >
                                            </div>
                                        </div>

                                        <div class="row mt-4">
                                            <div class="col-md-12">
                                                <label class="form-label">Description (Purpose)</label>
                                                <input type="text" class="form-control" >
                                            </div>

                                        </div>
                                        <div class="row mt-4">
                                            <div class="col-md-12">
                                                <label class="form-label">Comments</label>
                                                <input type="text" class="form-control" >
                                            </div>

                                        </div>

                                        <div class="row mt-4">

                                            <div class="col-md-12 ">
                                                <a href="#" class="btn btn-primary float-end " > <i class="fa fa-save"></i> &nbsp; Save </a>
                                            </div>

                                        </div>


                                    </div>
                                </div>
                            </div>

                        </div>

                        <div class="card flex-fill">
                            <div class="card-header">
                                <h5 class="card-title mb-0" style="display: block; width: 240px; float: left;">Search</h5>


                            </div>
                            <div class="card-body">
                                <div class="row mt-4">
                                    <div class="col-md-8">
                                        <label class="form-label">Enter Bg Number/ Client Name / Company Name</label>
                                        <input type="text" class="form-control" >
                                    </div>


                                   

                                    <div class="col-md-4 pt-1">
                                        <a href="#" class="btn btn-primary float-end mt-4 w-100" > <i class="fa fa-search"></i> &nbsp; Search </a>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <div class="card flex-fill">
                            <div class="card-header">
                                <h5 class="card-title mb-0" style="display: block; width: 240px; float: left;">Search Results</h5>
                                <div class="input-group input-group-sm" style="width: 200px; float: left;">
                                    <select class="form-select"  style="border-radius: 4px;">
                                        <option>01</option>
                                        <option>01</option>
                                        <option>01</option>
                                    </select>
                                </div>
                                <div class="input-group input-group-sm" style="width: 200px; float: right;">
                                    <input type="text" class="form-control" placeholder="Search" style="border-radius: 4px;">
                                </div>
                            </div>
                            <table id="datatables-dashboard-projects" class="table table-striped my-0">
                                <thead>
                                    <tr>
                                        <th>S.No.</th>
                                        <th class="d-none d-xl-table-cell">Loan Amount</th>
                                        <th class="d-none d-xl-table-cell">From</th>
                                        <th class="d-none d-xl-table-cell">To</th>
                                        <th class="d-none d-md-table-cell">Day</th>
                                        <th class="d-none d-md-table-cell">Status</th>
                                        <th class="d-none d-md-table-cell">Approved By</th>
                                        <th class="d-none d-md-table-cell">Option</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>01</td>
                                        <td class="d-none d-xl-table-cell">40000</td>
                                        <td class="d-none d-xl-table-cell">1/11/2022</td>
                                        <td class="d-none d-md-table-cell">3/11/2022</td>
                                        <td class="d-none d-md-table-cell">3</td>
                                        <td><span class="badge bg-success">Approved</span></td>
                                        <td>Indrajeet Sir</td>
                                        <td>
                                            <a class="float-start ms-1" data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Edit"><i class="fa fa-edit"></i></a> 

                                            <a class="float-start ms-2" data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Download"><i class="fa fa-download"></i></a>
                                            &nbsp; &nbsp;
                                            <a class="float-start ms-2" data-bs-toggle="tooltip" data-bs-placement="top" title="" data-bs-original-title="Delete"><i class="fa fa-trash-alt"></i></a>

                                        </td>
                                    </tr>

                                </tbody>
                            </table>
                        </div>


</asp:Content>

