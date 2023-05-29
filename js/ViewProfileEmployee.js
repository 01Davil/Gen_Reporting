/// <reference path="app.js" />
/// <reference path="settings.js" />

$(document).ready(function () {
    // end
    // get Employee Details
    setTimeout(function () {
    var formData = new FormData();
    formData.append("Sno",  (new URL(location.href)).searchParams.get('Sno'));
    jQuery.ajax({
        url: 'WebServerFile/Hr_MasterWebService.asmx/GetEmployeeFullDetails',
        type: 'POST',
        data: formData,
        cache: false,
        contentType: false,
        processData: false,
        success: function (date) {
            if (date[0].response == 'Fail') {
                Swal.fire({
                    icon: 'info',
                    width: '300px',
                    text: "No details found.",
                    timer: 3000
                });

            } else {

                if(date[0].Image=="NA"){

                    $('#image1').attr('src', "img/av.png");
                }else{
                    $('#image1').attr('src', date[0].Image);
                }
                $("#EmpName").val(date[0].EmpName);
                $("#EmpName1").html(date[0].EmpName);
                $("#EmpCode").val(date[0].EmpCode);
                $("#officialEmail").val(date[0].officeEmail);
                $("#Branch").val(date[0].Branch);
                $("#Biometricid").val(date[0].Biometricid); 
                $("#Sno").val(date[0].Sno);
                $("#Department").val(date[0].Department);
                $("#JobProfile").val(date[0].JobProfile);
                $("#JobProfile1").html(date[0].JobProfile);
                $("#DOB").val(date[0].DOB1);
                $("#DOJ").val(date[0].DOJ1);
                $("#Contact").val(date[0].Mobile);
                $("#AlterContactNo").val(date[0].AlterContactNo);
                $("#PersonalEmail").val(date[0].Email);
                $("#Gender").val(date[0].Gender);
                $("#BloodGroup").val(date[0].BloodGroup);
                $("#Married").val(date[0].Married);
                $("#EmerName").val(date[0].EmerName);
                $("#EmerRealtion").val(date[0].EmerRealtion);
                $("#EmerContNo").val(date[0].EmerContNo);
                $("#EmerAddress").val(date[0].EmerAddress);
                $("#Fname").val(date[0].Fname);
                $("#Mname").val(date[0].Mname);
                $("#FContactNo").val(date[0].FContactNo);
                $("#MConatctNo").val(date[0].MConatctNo);
                $("#SelectState").val(date[0].SelectState);
                $("#SelectDistrict").val(date[0].SelectDistrict);
                $("#City").val(date[0].City);
                $("#AdharNo").val(date[0].AdharNo);
                $("#PanNo").val(date[0].PanNo);
                $("#DrivingLicenceNo").val(date[0].DrivingLicenceNo);
                $("#LocalAddress").val(date[0].LocalAddress);
                $("#PermanentAddress").val(date[0].PermanentAddress);
                $("#PinCode").val(date[0].PinCode);
                ////////////////////////////////////////////////
                $("#HName").val(date[0].HName);
                $("#HPassingYear").val(date[0].HPassingYear);
                $("#HPercentage").val(date[0].HPercentage);
                $("#HBoard").val(date[0].HBoard);
                $("#IBoard").val(date[0].IBoard);
                $("#IName").val(date[0].IName);
                $("#IPassingYear").val(date[0].IPassingYear);
                $("#IPercentage").val(date[0].IPercentage);
                $("#GUniversityName").val(date[0].GUniversityName);
                $("#GCollegeName").val(date[0].GCollegeName);
                $("#GStreamBranch").val(date[0].GStreamBranch);
                $("#GPassingYear").val(date[0].GPassingYear);
                $("#GPercentage").val(date[0].GPercentage);
                $("#PGUniversityName").val(date[0].PGUniversityName);
                $("#PGCollegeName").val(date[0].PGCollegeName);
                $("#PGStreamBranch").val(date[0].PGStreamBranch);
                $("#PGPassingYear").val(date[0].PGPassingYear);
                $("#PGPercentage").val(date[0].PGPercentage);

                ////////////////////////////////////////
                $("#BName").val(date[0].BName);
                $("#BRName").val(date[0].BRName);
                $("#BRCode").val(date[0].BRCode);
                $("#BrAddress").val(date[0].BrAddress);
                $("#CIFNo").val(date[0].CIFNo);
                $("#IFSCCode").val(date[0].IFSCCode);
                $("#AccountNo").val(date[0].AccountNo);
                ////////////////////

                $("#Basic").val(date[0].Basic);
               // $("#PF_Type").val(date[0].PF_Type);
                $("#PF_E").val(date[0].PF_E);
                $("#PF_ER").val(date[0].PF_ER);
                $("#HRA").val(date[0].HRA);
                $("#ESICNO").val(date[0].ESICNO);
                $("#ESIC_E").val(date[0].ESIC_E);
                $("#ESIC_ER").val(date[0].ESIC_ER);
                $("#ArrearAllowance").val(date[0].ArrearAllowance);
                $("#BonusAllowance").val(date[0].BonusAllowance);
                $("#OtherAllowance").val(date[0].OtherAllowance);
                $("#OtherAdvanceDeduction").val(date[0].OtherAdvanceDeduction);
                $("#Allowance").val(date[0].Allowance);
                $("#ExtraAllowance").val(date[0].ExtraAllowance);
                $("#MediAllowance").val(date[0].MediAllowance);
                $("#SpecialAllowance").val(date[0].SpecialAllowance);
                $("#Bonus").val(date[0].Bonus);
                $("#Conveyance").val(date[0].Conveyance);
                $("#CTC").val(date[0].CTC);
                $("#DA").val(date[0].DA);
                $("#TA").val(date[0].TA);
                $("#TDS").val(date[0].TDS);
                $("#DA").val(date[0].DA);
                
                // date[i].EmpName 
            }
        },
        error: function (sd) {
            // alert("fail");
        }
    });
    }, 1000);
    // end
});
// ClosePage
function ClosePage() {
    close();
}
// Save Employee Professional Details()
function SaveProfessionalDetails() {
    var EmpCode = ("#EmpCode").val();
    var Name = $("#EmpName").val();
    var officialEmail = $("$officialEmail").val();
    var Branch = $("#Branch").val();
    var Department = $("#Department").val();
    var JobProfile = $("#JobProfile").val();
    var DOJ = $("#DOJ").val();
    if (EmpCode == " " || EmpCode.length == 0 || Name == " " || Name.length == 0 || officialEmail == " " || officialEmail.length == 0 || Branch == " " || Branch.length == 0 || Department == " " || Department.length == 0 || JobProfile == " " || JobProfile.length == 0 || DOJ == " " || DOJ.length== 0) {
        Swal.fire({
            icon: 'info',
            width: '300px',
            text: "please fill all required fields."
        });
    } else {
        var formData = new FormData();
        formData.append("EmpCode", EmpCode);
        formData.append("Name", Name);
        formData.append("officialEmail", officialEmail);
        formData.append("Branch", Branch);
        formData.append("Department", Department);
        formData.append("JobProfile", JobProfile);
        formData.append("DOJ", DOJ);
        jQuery.ajax({
            url: 'WebServerFile/Hr_MasterWebService.asmx/UpdateProfessionalDetails',
            type: 'POST',
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success: function (date) {
                if (date[0].response == 'Fail') {
                    Swal.fire({
                        icon: 'info',
                        width: '300px',
                        text: "Employee Professional Details Not Upload ."
                    });
                } else {
                    Swal.fire({
                        icon: 'info',
                        width: '300px',
                        text: "Employee Professional Details  Upload "
                    });
                }
            },
            error: function (sd) {
                // alert("fail");
            }
        });
    }
}
// end
// update employee image

function UpdateImage() {
    debugger;
    var formData = new FormData();
    formData.append("Slip", $("#EmpImage")[0].files[0]);
    formData.append("Sno", (new URL(location.href)).searchParams.get('Sno'));
    $.ajax({
        url: 'WebServerFile/Hr_MasterWebService.asmx/UpdateImageEmp',
        type: 'POST',
        data: formData,
        cache: false,
        contentType: false,
        processData: false,
        success: function (Result) {
            alert(Result);
            if (Result == 'Save') {
                Swal.fire({
                    icon: 'success',
                    width: '300px',
                    text: "Image Update"
                });
            } else {
                Swal.fire({
                    icon: 'info',
                    width: '300px',
                    text: "Image  Not Update"
                  
                });
            }
        },
        xhr: function () {
            var fileXhr = $.ajaxSettings.xhr();
            if (fileXhr.upload) {
                                  
            }
            return fileXhr;
        }
    });

}
