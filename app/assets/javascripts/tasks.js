var filesToRemove = [];

var submitName;

function setSubmit(button) {
    submitName = button.value;
}

function createTask(url) {
    var d = $('#task-form').serialize(); // get the form data
    var personResponsibleId = $("#assign-img-div").data("person-id");
    d += "&task[person_responsible_id]=" + JSON.stringify(personResponsibleId);

    $.ajax(url, {
        data: d,
        type: 'POST',
        success: function(json) {
            // console.log('ok! > \'' + json.msg + '\'');
            window.location = json.url;
        },
        error: function(xhr, textStatus, errorThrown) {
            var json = xhr.responseJSON;
            try {
                for (var f in json) {
                    $('input[name="task[' + json[f] + ']"]').parent().addClass("has-error");
                }
            } catch (err) {
                alert("Unrecognised error " + xhr.status + " " + errorThrown);
            }
        }
    });
}

function editTask(url) {
    var personResponsibleId = $("#assign-img-div").data("person-id");
    var d = $('#task-form').serialize(); // get the form data
    d += "&task[person_responsible_id]=" + JSON.stringify(personResponsibleId);
    // d += "&filesToRemove=" + JSON.stringify(filesToRemove);

    $.ajax(url, {
        data: d,
        type: 'PUT',
        success: function(json) {
            // console.log('ok! > \'' + json.msg + '\'');
            window.location = json.url;
        },
        error: function(xhr, textStatus, errorThrown) {
            var json = xhr.responseJSON;
            try {
                for (var f in json) {
                    $('input[name="task[' + json[f] + ']"]').parent().addClass("has-error");
                }
            } catch (err) {
                alert("Unrecognised error " + xhr.status + " " + errorThrown);
            }
        }
    });
}

function deleteTask( url) {
    var d = $('#task-form').serialize(); // get the form data

    $.ajax(url, {
        data: d,
        type: 'DELETE',
        success: function(json) {
            // console.log('ok! > \'' + json.msg + '\'');
            window.location = json.url;
        },
        error: function(xhr, textStatus, errorThrown) {
            alert("Error " + xhr.status + " " + errorThrown);
        }
    });
}

/*
 * assing person
 */
$(".assignment-list-item").click(function() {
    var id = $(this).data("person-id");
    console.log("setting asignee: " + id);
    $("#assignment-dialog").hide();
    $("#assign-img-div").data("person-id", id);

    // show in form
    $("#assign-img-div").css("display", "block");
    var imgSrc = $(this).find("img").attr("src");
    var name = $(this).find(".assignement-name").html();
    $("#assign-img").attr("src", imgSrc);
    $("#assign-name").html(name);
});

$("#assign-person").click(function() {
    $("#assignment-dialog").show();
});

$("#assignment-dialog-close").click(function() {
    $("#assignment-dialog").hide();
});

$("p.person-remove").click(function() {
    console.log("removing person: " + $("#assign-img-div").data("person-id"));
    $("#assign-img-div").data("person-id", -1);
    $("#assign-img-div").hide();
});

/*
 * other
 */
$(".file-remove").click(function() {
    var view = $(this).parent("li");
    var id = view.data("file-id");
    console.log("removing file: " + id);
    filesToRemove.push(id);
    view.remove();
});

// comment
function addComment(url) {
    console.log("task comment");
    $.ajax(url, {
        data: $('#comment-form').serialize(), // get the form data
        type: 'POST',
        success: function(json) {
            console.log('ok! > \'' + json.msg + '\'');
            // var date = json.data.created[2] + "-" + json.data.created[1] + "-" + json.data.created[0];
            // s = '<li class="comments-list-item">';
            // s += '<b>' + json.data.createdBy.name + ' ' + json.data.createdBy.lastName + '</b>';
            // s += '<span class="comments-time">' + date + '</span>';
            // s += '<p>' + json.data.text + '</p></li>';
            // $("#comments-list").append(s);
        },
        error: function(xhr, textStatus, errorThrown) {
            console.log(textStatus + "::" + errorThrown);
        }
    });
}
