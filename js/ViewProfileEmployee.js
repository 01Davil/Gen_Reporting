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
                $('#image1').attr('src', date[0].Image);
                $("#EmpName").val(date[0].EmpName);
                $("#EmpName1").html(date[0].EmpName);
                $("#EmpCode").val(date[0].EmpCode);
                $("#officialEmail").val(date[0].officeEmail);
                $("#Branch").val(date[0].Branch);
                $("#Department").val(date[0].Department);
                $("#JobProfile").val(date[0].JobProfile);
                $("#JobProfile1").html(date[0].JobProfile);
                $("#DOJ").val(new Date(date[0].DOJ).toLocaleDateString('en-CA'));
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
